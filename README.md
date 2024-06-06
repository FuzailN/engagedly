# Flask App with PostgreSQL Setup

## Documentation for Setting Up a Private Network with AWS VPC, EC2 Instances, and Terraform

This documentation provides step-by-step instructions for setting up a secure, isolated private network on AWS using VPC, provisioning remote machines (EC2 instances), configuring a web application and a PostgreSQL database, and automating the setup with Terraform.

### Prerequisites:
1. AWS account with appropriate permissions to create VPC, subnets, security groups, and EC2 instances.
2. Terraform installed on your local machine.

### Step 1: Set Up a Private Network Using AWS VPC
#### Create VPC
1. Create VPC.
2. Set the IPv4 CIDR block (e.g., 10.0.0.0/16), and leave other options as default.

#### Create Subnets
1. Select the VPC created earlier, provide a name, set the Availability Zone, and define the IPv4 CIDR block for the subnet (10.0.1.0/24, 10.0.3.0/24, 10.0.3.0/24).

#### Configure Routing Tables
1. Provided internet gateway to bastion_public_rt

### Step 2: Provision Remote Machines
1. Launch two EC2 instances within the VPC - One instance for a web application (Python Flask) & One instance for a PostgreSQL database.
2. Both instances should be in the same private subnet to allow communication.
3. Verify security group rules to ensure internal communication on required ports (e.g., port 5432 for PostgreSQL).

### Step 3: Application and Database Configuration
#### Install and Configure Web Application
1. SSH into the web application EC2 instance using the bastion host.
(Use the bastion host to SSH into instances within the private subnet)
2. Install necessary packages and dependencies for your web application (Python Flask).
3. Deploy your web application.

#### Install and Configure PostgreSQL
1. SSH into the PostgreSQL EC2 instance using the bastion host.
(Use the bastion host to SSH into instances within the private subnet)
2. Install PostgreSQL.
3. Configure PostgreSQL to accept connections from the web application instance.
4. Create necessary databases and users.

#### Ensure Web Application Can Connect to PostgreSQL
1. Update the web application configuration to connect to the PostgreSQL database using the internal IP address.

### Step 4: Application Load Balancer (ALB) and DNS
1. Create an ALB in the VPC.
2. Configure the ALB to route traffic to the web application instance.
3. Set up a DNS record for your application pointing to the ALB.

### Step 5: Secure Communication
1. Create security groups to allow only necessary traffic (e.g., HTTP, HTTPS, PostgreSQL, Flask application port) between the instances.

### Step 6: Automate the Setup with Terraform
1. Run terraform init
2. Run terraform apply