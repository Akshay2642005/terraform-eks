# Terraform EKS Cluster

A cost-optimized Terraform configuration for deploying Amazon EKS clusters designed for short-lived development and testing environments.

## 🎯 Overview

This project creates a fully functional EKS cluster optimized for:
- **Short-lived sessions** (2-3 hours)
- **Cost efficiency** (70-80% cost reduction)
- **Fast deployment** (minimal resources)
- **Development and testing** purposes

## 💰 Cost Optimization Features

- **Spot Instances**: 50-70% cost savings
- **Minimal Resources**: 1-2 nodes instead of 3
- **Smaller Instance Types**: t3.small and t3.medium
- **Reduced Subnets**: 2 subnets instead of 3
- **Auto-scaling**: Scale to zero when not in use

**Expected Cost**: ~.03-0.08/hour (vs .20-0.25/hour with standard configuration)

## 🏗️ Architecture

\\\
┌─────────────────────────────────────────────────────────────┐
│                        VPC (10.16.0.0/16)                  │
│  ┌─────────────────┐  ┌─────────────────┐                  │
│  │   Public Subnet │  │   Public Subnet │                  │
│  │   (10.16.0.0/20)│  │ (10.16.16.0/20)│                  │
│  │   ap-south-2a   │  │   ap-south-2b   │                  │
│  │                 │  │                 │                  │
│  │  ┌─────────────┐│  │  ┌─────────────┐│                  │
│  │  │ EKS Cluster ││  │  │ EKS Nodes   ││                  │
│  │  │ (Private)   ││  │  │ (Spot)      ││                  │
│  │  └─────────────┘│  │  └─────────────┘│                  │
│  └─────────────────┘  └─────────────────┘                  │
└─────────────────────────────────────────────────────────────┘
\\\

## 📁 Project Structure

\\\
terraform-eks/
├── eks/                    # Root module
│   ├── main.tf            # Main configuration
│   ├── variables.tf       # Variable definitions
│   ├── backend.tf         # Provider configuration
│   └── dev.tfvars         # Development values
├── modules/               # Reusable modules
│   ├── eks.tf            # EKS cluster configuration
│   ├── iam.tf            # IAM roles and policies
│   ├── vpc.tf            # VPC and networking
│   └── variables.tf      # Module variables
├── README.md             # This file
└── .gitignore           # Git ignore rules
\\\

## 🚀 Quick Start

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.9.3
- [AWS CLI](https://aws.amazon.com/cli/) configured
- AWS credentials with EKS permissions
- SSH key pair named \
control\ in your AWS account

### 1. Clone and Navigate

\\\ash
git clone <your-repo-url>
cd terraform-eks
\\\

### 2. Configure AWS Credentials

\\\ash
aws configure
# Enter your AWS Access Key ID, Secret Access Key, and region
\\\

### 3. Deploy the Cluster

\\\ash
# Initialize Terraform
terraform init

# Review the plan
terraform plan -var-file=\eks/dev.tfvars\

# Deploy the cluster
terraform apply -var-file=\eks/dev.tfvars\
\\\

### 4. Connect to the Cluster

After deployment, get the cluster information:

\\\ash
# Get cluster endpoint
terraform output cluster_endpoint

# Get cluster name
terraform output cluster_name

# Update kubeconfig
aws eks update-kubeconfig --region ap-south-2 --name dev-ap-medium-eks-cluster
\\\

## ⚙️ Configuration

### Key Variables (dev.tfvars)

\\\hcl
# Environment
env                   = \dev\
aws-region            = \ap-south-2\

# Networking
vpc-cidr-block        = \10.16.0.0/16\
pub-subnet-count      = 2
pub-cidr-block        = [\10.16.0.0/20\, \10.16.16.0/20\]
pub-availability-zone = [\ap-south-2a\, \ap-south-2b\]

# EKS Configuration
cluster-version        = \1.33\
endpoint-public-access = false
max_capacity_spot      = \2\
min_capacity_spot      = \1\
desired_capacity_spot  = \1\
instance-types         = [\t3.small\, \t3.medium\]
\\\

### Customization

To modify the configuration:

1. **Change instance types**: Update \instance-types\ in \dev.tfvars\
2. **Adjust node count**: Modify \min_capacity_spot\, \max_capacity_spot\
3. **Change region**: Update \ws-region\ and \pub-availability-zone\
4. **Modify networking**: Update CIDR blocks and subnet configuration

## 🔧 Available Outputs

After deployment, you can access:

- \cluster_endpoint\: EKS cluster API endpoint
- \cluster_name\: EKS cluster name
- \cluster_security_group_id\: Cluster security group ID

## 🛡️ Security Features

- **Private EKS Endpoint**: API server not accessible from internet
- **Security Groups**: Configured for EKS requirements
- **IAM Roles**: Least privilege access for EKS and node groups
- **Spot Instances**: Cost-effective worker nodes

## 💡 Best Practices

### For Development
- Use spot instances for cost savings
- Scale down to 0 nodes when not in use
- Use smaller instance types for testing
- Keep sessions short (2-3 hours)

### For Production
- Use private subnets for worker nodes
- Enable cluster logging
- Use on-demand instances for critical workloads
- Implement proper backup strategies

## 🧹 Cleanup

To destroy the cluster and avoid charges:

\\\ash
terraform destroy -var-file=\eks/dev.tfvars\
\\\

**Important**: Always run \	erraform destroy\ after your session to avoid unexpected charges.

## 📊 Cost Monitoring

Monitor your costs with:

\\\ash
# Check current costs
aws ce get-cost-and-usage \\
  --time-period Start=2024-01-01,End=2024-01-02 \\
  --granularity MONTHLY \\
  --metrics BlendedCost
\\\

## 🐛 Troubleshooting

### Common Issues

1. **SSH Key Not Found**
   - Ensure \control\ key pair exists in your AWS account
   - Check the region matches your configuration

2. **Insufficient Permissions**
   - Verify your AWS credentials have EKS permissions
   - Check IAM policies for EKS, EC2, and VPC access

3. **Spot Instance Interruption**
   - This is normal behavior for spot instances
   - Consider using on-demand instances for critical workloads

### Getting Help

- Check Terraform logs: \	erraform apply -var-file=\eks/dev.tfvars\ -auto-approve\
- Verify AWS resources in the console
- Check EKS cluster status: \ws eks describe-cluster --name <cluster-name>\

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

For issues and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review AWS EKS documentation

---

**Happy Kubernetes-ing! 🚀**
