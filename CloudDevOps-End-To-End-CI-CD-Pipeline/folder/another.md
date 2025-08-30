# 🏗️ JokeMaster Cloud DevOps Architecture Diagrams

## High-Level Architecture Overview

```mermaid
graph TB
    subgraph "External"
        U[Users/Internet]
        GH[GitHub Repository]
    end
    
    subgraph "CI/CD Pipeline"
        GA[GitHub Actions]
        TF[Terraform]
        DOCKER[Docker Build]
    end
    
    subgraph "AWS Cloud - ap-south-1"
        subgraph "State Management"
            S3[S3 Bucket<br/>Terraform State]
            DDB[DynamoDB<br/>State Locking]
        end
        
        subgraph "Container Registry"
            ECR[ECR Repository<br/>jokes-app]
        end
        
        subgraph "VPC - 172.31.0.0/16"
            subgraph "Public Subnets"
                ALB[Application Load Balancer<br/>Internet-facing]
                NAT[NAT Gateway<br/>with Elastic IP]
            end
            
            subgraph "Private Subnets"
                ECS[ECS Fargate Cluster<br/>jokes-app-cluster]
                TASK1[ECS Task 1<br/>jokes-app:latest]
                TASK2[ECS Task 2<br/>jokes-app:latest]
            end
        end
        
        subgraph "Monitoring & Logging"
            CW[CloudWatch Logs<br/>/ecs/jokes-app]
        end
        
        subgraph "Auto-scaling"
            AS[Application Auto Scaling<br/>1-5 instances<br/>CPU-based]
        end
    end
    
    subgraph "Application Stack"
        subgraph "Container - jokes-app"
            NODE[Node.js/Express<br/>Port 5000]
            SQLITE[SQLite Database<br/>jokes.db]
            STATIC[Static Files<br/>HTML/CSS/JS]
        end
    end
    
    %% Connections
    U -->|HTTP/HTTPS| ALB
    ALB -->|Port 5000| TASK1
    ALB -->|Port 5000| TASK2
    
    GH -->|Push to main| GA
    GA -->|Deploy| TF
    GA -->|Build & Push| DOCKER
    
    TF -->|State| S3
    TF -->|Lock| DDB
    TF -->|Provision| ECS
    TF -->|Provision| ALB
    
    DOCKER -->|Push Image| ECR
    ECR -->|Pull Image| TASK1
    ECR -->|Pull Image| TASK2
    
    TASK1 -->|Logs| CW
    TASK2 -->|Logs| CW
    
    AS -->|Scale| ECS
    
    TASK1 --> NODE
    TASK2 --> NODE
    NODE --> SQLITE
    NODE --> STATIC
    
    NAT -->|Outbound| U
    TASK1 -->|Outbound via NAT| U
    TASK2 -->|Outbound via NAT| U
```

## Detailed Technical Architecture

```mermaid
graph TB
    subgraph "Internet"
        USER[👤 Users]
    end
    
    subgraph "GitHub"
        REPO[📁 Repository<br/>CloudDevOps End‑To‑End CICD Pipeline]
        WORKFLOW[🔄 GitHub Actions<br/>Full Infra + App CI/CD]
    end
    
    subgraph "AWS Account - ap-south-1"
        subgraph "State Management"
            S3_STATE[🪣 S3 Bucket<br/>my-tf-state-bucket-rex-2025<br/>Versioning Enabled]
            DDB_LOCK[🔒 DynamoDB Table<br/>my-tf-lock-table-rex-2025<br/>LockID String]
        end
        
        subgraph "Container Registry"
            ECR_REPO[📦 ECR Repository<br/>jokes-app<br/>Image Scanning Enabled]
        end
        
        subgraph "VPC - jokes-app-vpc (172.31.0.0/16)"
            subgraph "Availability Zone 1a"
                subgraph "Public Subnet A (172.31.1.0/24)"
                    IGW[🌐 Internet Gateway<br/>jokes-app-igw]
                    ALB_A[⚖️ ALB Subnet A<br/>Public IP Auto-assign]
                    NAT_EIP[📍 Elastic IP<br/>NAT Gateway]
                    NAT_GW[🚪 NAT Gateway<br/>jokes-app-nat-gw]
                end
                
                subgraph "Private Subnet A (172.31.3.0/24)"
                    ECS_TASK_A[🐳 ECS Task A<br/>jokes-app:latest<br/>256 CPU, 512 MB<br/>Port 5000]
                end
            end
            
            subgraph "Availability Zone 1b"
                subgraph "Public Subnet B (172.31.2.0/24)"
                    ALB_B[⚖️ ALB Subnet B<br/>Public IP Auto-assign]
                end
                
                subgraph "Private Subnet B (172.31.4.0/24)"
                    ECS_TASK_B[🐳 ECS Task B<br/>jokes-app:latest<br/>256 CPU, 512 MB<br/>Port 5000]
                end
            end
            
            subgraph "Load Balancing"
                ALB[⚖️ Application Load Balancer<br/>jokes-app-alb<br/>Internet-facing<br/>Multi-AZ]
                TG[🎯 Target Group<br/>jokes-app-tg<br/>Port 5000, HTTP<br/>Health Check: /]
                LISTENER[👂 ALB Listener<br/>Port 80, HTTP<br/>Forward to Target Group]
            end
            
            subgraph "Security Groups"
                ALB_SG[🛡️ ALB Security Group<br/>jokes-app-alb-sg<br/>Inbound: 80,443 from 0.0.0.0/0<br/>Outbound: All]
                ECS_SG[🛡️ ECS Security Group<br/>jokes-app-ecs-sg<br/>Inbound: 5000 from ALB SG<br/>Outbound: All]
            end
            
            subgraph "Route Tables"
                PUBLIC_RT[🛣️ Public Route Table<br/>jokes-app-public-rt<br/>0.0.0.0/0 → IGW]
                PRIVATE_RT[🛣️ Private Route Table<br/>jokes-app-private-rt<br/>0.0.0.0/0 → NAT Gateway]
            end
        end
        
        subgraph "ECS Cluster"
            ECS_CLUSTER[🏗️ ECS Cluster<br/>jokes-app-cluster<br/>Fargate Launch Type]
            ECS_SERVICE[⚙️ ECS Service<br/>jokes-app-service<br/>Desired Count: 2<br/>Auto-assign Public IP: No]
            TASK_DEF[📋 Task Definition<br/>jokes-app-task<br/>Network Mode: awsvpc<br/>Execution Role: ecs-task-exec-role]
        end
        
        subgraph "Auto-scaling"
            AS_TARGET[📈 Auto Scaling Target<br/>Min: 1, Max: 5<br/>Resource: ECS Service]
            AS_POLICY[📊 CPU Scaling Policy<br/>Target: 50% CPU<br/>Scale-in Cooldown: 60s<br/>Scale-out Cooldown: 60s]
        end
        
        subgraph "IAM & Security"
            ECS_ROLE[👤 ECS Task Execution Role<br/>jokes-app-ecs-task-exec-role<br/>AssumeRole: ecs-tasks.amazonaws.com]
            LOGGING_POLICY[📜 ECS Logging Policy<br/>ecs-logging-policy<br/>logs:CreateLogStream<br/>logs:PutLogEvents<br/>logs:CreateLogGroup]
        end
        
        subgraph "Monitoring & Logging"
            CW_LOG_GROUP[📊 CloudWatch Log Group<br/>/ecs/jokes-app<br/>Retention: 7 days]
            CW_LOG_STREAM[📝 CloudWatch Log Stream<br/>jokes-app-log-stream]
        end
    end
    
    subgraph "Application Components"
        subgraph "Container: jokes-app"
            NODE_APP[🟢 Node.js Application<br/>Express.js Server<br/>Port 5000<br/>Health Check: /]
            SQLITE_DB[🗄️ SQLite Database<br/>jokes.db<br/>Tables: jokes, favorites, user_sessions]
            FRONTEND[🎨 Frontend Assets<br/>HTML, CSS, JavaScript<br/>Static file serving]
        end
    end
    
    %% User Flow
    USER -->|HTTP/HTTPS Request| ALB
    
    %% ALB Distribution
    ALB -->|Health Check| TG
    ALB -->|Route Traffic| LISTENER
    LISTENER -->|Forward| TG
    TG -->|Port 5000| ECS_TASK_A
    TG -->|Port 5000| ECS_TASK_B
    
    %% CI/CD Flow
    REPO -->|Push to main branch| WORKFLOW
    WORKFLOW -->|1. Checkout Code| WORKFLOW
    WORKFLOW -->|2. Configure AWS| WORKFLOW
    WORKFLOW -->|3. Bootstrap S3/DynamoDB| S3_STATE
    WORKFLOW -->|3. Bootstrap S3/DynamoDB| DDB_LOCK
    WORKFLOW -->|4. Terraform Init| S3_STATE
    WORKFLOW -->|4. Terraform Init| DDB_LOCK
    WORKFLOW -->|5. Auto-import Resources| WORKFLOW
    WORKFLOW -->|6. Terraform Apply| ECS_CLUSTER
    WORKFLOW -->|6. Terraform Apply| ALB
    WORKFLOW -->|7. ECR Login| ECR_REPO
    WORKFLOW -->|8. Build & Push Image| ECR_REPO
    WORKFLOW -->|9. Update ECS Service| ECS_SERVICE
    
    %% Container Image Flow
    ECR_REPO -->|Pull Image| ECS_TASK_A
    ECR_REPO -->|Pull Image| ECS_TASK_B
    
    %% Application Internal Flow
    ECS_TASK_A --> NODE_APP
    ECS_TASK_B --> NODE_APP
    NODE_APP --> SQLITE_DB
    NODE_APP --> FRONTEND
    
    %% Logging Flow
    ECS_TASK_A -->|Application Logs| CW_LOG_GROUP
    ECS_TASK_B -->|Application Logs| CW_LOG_GROUP
    CW_LOG_GROUP --> CW_LOG_STREAM
    
    %% Auto-scaling Flow
    AS_TARGET -->|Monitor| ECS_SERVICE
    AS_POLICY -->|Scale based on CPU| AS_TARGET
    AS_TARGET -->|Scale Up/Down| ECS_TASK_A
    AS_TARGET -->|Scale Up/Down| ECS_TASK_B
    
    %% Security Group Associations
    ALB_SG -.->|Applied to| ALB
    ECS_SG -.->|Applied to| ECS_TASK_A
    ECS_SG -.->|Applied to| ECS_TASK_B
    
    %% Route Table Associations
    PUBLIC_RT -.->|Associated with| ALB_A
    PUBLIC_RT -.->|Associated with| ALB_B
    PRIVATE_RT -.->|Associated with| ECS_TASK_A
    PRIVATE_RT -.->|Associated with| ECS_TASK_B
    
    %% IAM Role Associations
    ECS_ROLE -.->|Assumed by| ECS_TASK_A
    ECS_ROLE -.->|Assumed by| ECS_TASK_B
    LOGGING_POLICY -.->|Attached to| ECS_ROLE
    
    %% Networking Flow
    IGW -->|Internet Access| ALB_A
    IGW -->|Internet Access| ALB_B
    NAT_GW -->|Outbound Internet| NAT_EIP
    NAT_EIP -->|Via IGW| IGW
    ECS_TASK_A -->|Outbound via NAT| NAT_GW
    ECS_TASK_B -->|Outbound via NAT| NAT_GW
    
    %% Styling
    classDef aws fill:#ff9900,stroke:#232f3e,stroke-width:2px,color:#fff
    classDef container fill:#2496ed,stroke:#fff,stroke-width:2px,color:#fff
    classDef security fill:#ff6b6b,stroke:#fff,stroke-width:2px,color:#fff
    classDef network fill:#4ecdc4,stroke:#fff,stroke-width:2px,color:#fff
    classDef storage fill:#45b7d1,stroke:#fff,stroke-width:2px,color:#fff
    classDef monitoring fill:#96ceb4,stroke:#fff,stroke-width:2px,color:#fff
    
    class S3_STATE,DDB_LOCK,ECR_REPO aws
    class ECS_TASK_A,ECS_TASK_B,NODE_APP,SQLITE_DB,FRONTEND container
    class ALB_SG,ECS_SG,ECS_ROLE,LOGGING_POLICY security
    class IGW,NAT_GW,ALB,TG,LISTENER,PUBLIC_RT,PRIVATE_RT network
    class CW_LOG_GROUP,CW_LOG_STREAM,AS_TARGET,AS_POLICY monitoring
```

## Data Flow Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant ALB as Application Load Balancer
    participant ECS as ECS Fargate Task
    participant DB as SQLite Database
    participant CW as CloudWatch Logs
    participant AS as Auto Scaling
    
    Note over U,AS: User Request Flow
    U->>ALB: HTTP Request (Port 80)
    ALB->>ALB: Health Check (/)
    ALB->>ECS: Forward Request (Port 5000)
    ECS->>DB: Query Jokes/Favorites
    DB-->>ECS: Return Data
    ECS->>ECS: Process & Generate Response
    ECS-->>ALB: HTTP Response
    ALB-->>U: Return Response
    
    Note over U,AS: Logging Flow
    ECS->>CW: Application Logs
    CW->>CW: Store & Index Logs
    
    Note over U,AS: Auto-scaling Flow
    AS->>ECS: Monitor CPU Utilization
    alt CPU > 50%
        AS->>ECS: Scale Out (Add Tasks)
    else CPU < 50%
        AS->>ECS: Scale In (Remove Tasks)
    end
```

## CI/CD Pipeline Flow

```mermaid
flowchart TD
    A[👨‍💻 Developer Push to main] --> B[🔄 GitHub Actions Triggered]
    B --> C[📥 Checkout Repository]
    C --> D[🔐 Configure AWS Credentials]
    D --> E[🪣 Ensure S3 State Bucket Exists]
    E --> F[🔒 Ensure DynamoDB Lock Table Exists]
    F --> G[📋 Install Terraform 1.7.5]
    G --> H[🚀 Terraform Init with S3 Backend]
    H --> I[📥 Auto-import Existing Resources]
    I --> J[🏗️ Terraform Apply Infrastructure]
    J --> K[🐳 Login to Amazon ECR]
    K --> L[🔨 Build Docker Image]
    L --> M[📤 Push Image to ECR]
    M --> N[🚀 Update ECS Service]
    N --> O[✅ Deployment Complete]
    
    subgraph "Infrastructure Changes"
        J1[VPC & Networking]
        J2[ECS Cluster & Service]
        J3[Load Balancer & Target Groups]
        J4[Security Groups & IAM]
        J5[Auto-scaling Configuration]
        J6[CloudWatch Logging]
    end
    
    subgraph "Application Changes"
        L1[Node.js Application]
        L2[SQLite Database Schema]
        L3[Frontend Assets]
        L4[Docker Configuration]
    end
    
    J --> J1
    J --> J2
    J --> J3
    J --> J4
    J --> J5
    J --> J6
    
    L --> L1
    L --> L2
    L --> L3
    L --> L4
```

## Security Architecture

```mermaid
graph TB
    subgraph "Security Layers"
        subgraph "Network Security"
            IGW_SEC[🌐 Internet Gateway<br/>Public Internet Access]
            NAT_SEC[🚪 NAT Gateway<br/>Private Outbound Access]
            SG_ALB[🛡️ ALB Security Group<br/>Ports 80,443 from 0.0.0.0/0]
            SG_ECS[🛡️ ECS Security Group<br/>Port 5000 from ALB SG only]
        end
        
        subgraph "Identity & Access Management"
            ECS_ROLE_SEC[👤 ECS Task Execution Role<br/>AssumeRole: ecs-tasks.amazonaws.com]
            LOGGING_POLICY_SEC[📜 ECS Logging Policy<br/>CloudWatch Logs Permissions]
            AWS_POLICIES[🔑 AWS Managed Policies<br/>AmazonECSTaskExecutionRolePolicy]
        end
        
        subgraph "Data Security"
            ECR_SCAN[🔍 ECR Image Scanning<br/>Vulnerability Detection]
            S3_VERSION[📦 S3 Versioning<br/>State File Protection]
            DDB_ENCRYPT[🔐 DynamoDB Encryption<br/>State Lock Protection]
        end
        
        subgraph "Application Security"
            NON_ROOT[👤 Non-root Container User<br/>Security Best Practice]
            HEALTH_CHECK[❤️ Health Checks<br/>ALB & ECS Monitoring]
            LOGGING[📊 Comprehensive Logging<br/>CloudWatch Integration]
        end
    end
    
    subgraph "Security Flow"
        USER_SEC[👤 User] -->|HTTPS/HTTP| IGW_SEC
        IGW_SEC -->|Filtered Traffic| SG_ALB
        SG_ALB -->|Port 80/443 Only| ALB_SEC[⚖️ ALB]
        ALB_SEC -->|Port 5000 Only| SG_ECS
        SG_ECS -->|Restricted Access| ECS_SEC[🐳 ECS Tasks]
        
        ECS_SEC -->|Assume Role| ECS_ROLE_SEC
        ECS_ROLE_SEC -->|Attached Policies| LOGGING_POLICY_SEC
        ECS_ROLE_SEC -->|Attached Policies| AWS_POLICIES
        
        ECS_SEC -->|Outbound via NAT| NAT_SEC
        NAT_SEC -->|Secure Outbound| IGW_SEC
    end
    
    classDef security fill:#ff6b6b,stroke:#fff,stroke-width:2px,color:#fff
    classDef network fill:#4ecdc4,stroke:#fff,stroke-width:2px,color:#fff
    classDef data fill:#45b7d1,stroke:#fff,stroke-width:2px,color:#fff
    classDef app fill:#96ceb4,stroke:#fff,stroke-width:2px,color:#fff
    
    class SG_ALB,SG_ECS,ECS_ROLE_SEC,LOGGING_POLICY_SEC,AWS_POLICIES security
    class IGW_SEC,NAT_SEC,ALB_SEC,ECS_SEC network
    class ECR_SCAN,S3_VERSION,DDB_ENCRYPT data
    class NON_ROOT,HEALTH_CHECK,LOGGING app
```

## Deployment Architecture

```mermaid
graph TB
    subgraph "Development Environment"
        DEV_CODE[💻 Local Development<br/>Node.js + SQLite]
        DEV_DOCKER[🐳 Local Docker<br/>Testing & Validation]
    end
    
    subgraph "Source Control"
        GIT_REPO[📁 GitHub Repository<br/>main branch]
        GIT_WORKFLOW[🔄 GitHub Actions<br/>CI/CD Pipeline]
    end
    
    subgraph "AWS Production Environment"
        subgraph "Infrastructure Layer"
            TERRAFORM[🏗️ Terraform<br/>Infrastructure as Code]
            S3_STATE_PROD[🪣 S3 State Bucket<br/>Production State]
            DDB_LOCK_PROD[🔒 DynamoDB Lock<br/>State Protection]
        end
        
        subgraph "Container Layer"
            ECR_PROD[📦 ECR Repository<br/>Production Images]
            ECS_PROD[🐳 ECS Fargate<br/>Production Tasks]
        end
        
        subgraph "Application Layer"
            ALB_PROD[⚖️ Application Load Balancer<br/>Production Traffic]
            APP_PROD[🟢 JokeMaster App<br/>Production Instance]
        end
        
        subgraph "Monitoring Layer"
            CW_PROD[📊 CloudWatch<br/>Production Monitoring]
            AS_PROD[📈 Auto Scaling<br/>Production Scaling]
        end
    end
    
    subgraph "User Access"
        USERS[👥 End Users<br/>Internet Access]
    end
    
    %% Development Flow
    DEV_CODE -->|Test Locally| DEV_DOCKER
    DEV_CODE -->|Commit & Push| GIT_REPO
    
    %% CI/CD Flow
    GIT_REPO -->|Trigger on Push| GIT_WORKFLOW
    GIT_WORKFLOW -->|Deploy Infrastructure| TERRAFORM
    GIT_WORKFLOW -->|Build & Push Image| ECR_PROD
    GIT_WORKFLOW -->|Update Service| ECS_PROD
    
    %% Infrastructure Management
    TERRAFORM -->|Store State| S3_STATE_PROD
    TERRAFORM -->|Lock State| DDB_LOCK_PROD
    TERRAFORM -->|Provision| ECS_PROD
    TERRAFORM -->|Provision| ALB_PROD
    
    %% Application Deployment
    ECR_PROD -->|Pull Image| ECS_PROD
    ECS_PROD -->|Run Application| APP_PROD
    ALB_PROD -->|Route Traffic| APP_PROD
    
    %% Monitoring & Scaling
    APP_PROD -->|Send Logs| CW_PROD
    CW_PROD -->|Monitor Metrics| AS_PROD
    AS_PROD -->|Scale Tasks| ECS_PROD
    
    %% User Access
    USERS -->|HTTP/HTTPS| ALB_PROD
    
    classDef dev fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    classDef prod fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    classDef infra fill:#fff3e0,stroke:#e65100,stroke-width:2px
    classDef user fill:#e8f5e8,stroke:#1b5e20,stroke-width:2px
    
    class DEV_CODE,DEV_DOCKER dev
    class ECR_PROD,ECS_PROD,ALB_PROD,APP_PROD,CW_PROD,AS_PROD prod
    class TERRAFORM,S3_STATE_PROD,DDB_LOCK_PROD infra
    class USERS user
```

## Key Architecture Features

### 🔒 **Security Features**
- **Network Isolation**: Private subnets for application tasks
- **Security Groups**: Restrictive inbound/outbound rules
- **IAM Roles**: Least-privilege access for ECS tasks
- **Image Scanning**: ECR vulnerability scanning
- **Non-root Containers**: Security best practices

### 📈 **Scalability Features**
- **Auto-scaling**: CPU-based scaling (1-5 instances)
- **Load Balancing**: Multi-AZ ALB distribution
- **Fargate**: Serverless container execution
- **Health Checks**: Automatic unhealthy task replacement

### 🔄 **CI/CD Features**
- **Infrastructure as Code**: Complete Terraform automation
- **State Management**: S3 backend with DynamoDB locking
- **Auto-import**: Handles existing resources gracefully
- **Zero-downtime**: Rolling deployments via ECS

### 📊 **Monitoring Features**
- **CloudWatch Logs**: Centralized application logging
- **Health Monitoring**: ALB and ECS health checks
- **Metrics**: CPU utilization for auto-scaling
- **Retention**: 7-day log retention policy

### 🌐 **Networking Features**
- **Multi-AZ**: High availability across availability zones
- **Public/Private**: Secure network segmentation
- **NAT Gateway**: Secure outbound internet access
- **Route Tables**: Proper traffic routing

This architecture provides a production-ready, scalable, and secure deployment of the JokeMaster application with comprehensive CI/CD automation.

