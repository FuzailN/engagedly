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
1. Select the VPC created earlier, provide a name, set the Availability Zone, and define the IPv4 CIDR block for the public and private subnet (10.0.1.0/24, 10.0.3.0/24).

#### Configure Routing Tables
1. Provided internet gateway to public route table.

### Step 2: Provision Remote Machines
1. Launch two EC2 instances within the VPC - One instance for a web application (Python Flask) & One instance for a PostgreSQL database.
2. Both instances should be in the same private subnet to allow communication.
3. Verify security group rules to ensure internal communication on required ports (e.g., port 5432 for PostgreSQL).

### Step 3: Application and Database Configuration
#### Install and Configure Web Application
1. SSH into the web application EC2 instance using the bastion host.
   ```
   ssh -i your-key.pem ec2-user@<PUBLIC_IP>
   ```
(Use the bastion host to SSH into instances within the private subnet)
   ```
   ssh -i your-key.pem ec2-user@<web_private_IP>
   ```
3. Install necessary packages and dependencies for your web application (Python Flask).
   ```
   sudo yum update -y
   sudo yum install -y python3 python3-pip git
   mkdir flask_app
   cd flask_app
   python3 -m venv venv
   source venv/bin/activate
   pip install Flask psycopg2-binary
   vi app.py (find following code in my github engagedly repositories)
   ```
5. Deploy your web application.
   ```
   sudo nohup python3 app.py &
   ```

#### Install and Configure PostgreSQL
1. SSH into the PostgreSQL EC2 instance using the bastion host.
    ```
   ssh -i your-key.pem ec2-user@<PUBLIC_IP>
   ```
(Use the bastion host to SSH into instances within the private subnet)
   ```
   ssh -i your-key.pem ec2-user@<web_private_IP>
   ```
2. Install PostgreSQL.
   ```
   sudo yum update -y
   sudo amazon-linux-extras install postgresql11 -y 
   sudo yum install -y postgresql-server postgresql-devel postgresql-contrib
   sudo service postgresql initdb
   sudo service postgresql start
   sudo su - postgres
   psql
   ```
create db and user:
  ```
  CREATE DATABASE yourdatabase;
  CREATE USER fuzail WITH ENCRYPTED PASSWORD 'fuzail';
  GRANT ALL PRIVILEGES ON DATABASE yourdatabase TO fuzail;
  exit the prompt: \q
  ```
3. Ensure the Web Application Can Connect to the PostgreSQL Database
   ```
   sudo nano /var/lib/pgsql/data/pg_hba.conf
   (add below line)
   host    all             all             <WEB_INSTANCE_PRIVATE_IP>/32          md5
   :wq
   ```

   ```
   sudo nano /var/lib/pgsql/data/postgresql.conf
   listen_addresses = '*' (uncomment)
   :wq
   sudo service postgresql restart
   ```

**Open a browser and navigate to the web application instance's public IP.**
open the browser: http://10.1.0.4 

### Step 4: Application Load Balancer (ALB) and DNS
1. Create an ALB in the VPC.
2. Configure the ALB to route traffic to the web application instance.
(Select the web application instance and add it to the target group).
3. Get the DNS Name: Copy the DNS name of your ALB (web-alb-1234567890.us-east-1.elb.amazonaws.com).
4. You should see the response from your Flask web application.

### Step 5: Secure Communication
1. Create security groups to allow only necessary traffic (e.g., HTTP, HTTPS, PostgreSQL, Flask application port) between the instances.

### Step 6: Automate the Setup with Terraform
1. Run terraform init
2. Run terraform apply
