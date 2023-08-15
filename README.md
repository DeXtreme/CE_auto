# CE_auto

### Problem Statement: 

You've been tasked with creating a flexible infrastructure for an eco-friendly car-sharing service. The service should automatically adapt to varying usage demands while keeping costs in check.

### Guidelines/Goals:

- Create EC2 Instances and Load Balancer:
- Create an Elastic Load Balancer (ELB) to distribute traffic.
- Create an Auto Scaling Group for the EC2 instances.
- Configure scaling policies to add or remove instances based on CPU utilization.


## Usage

1. Clone the repo
2. Initialize terraform
    ```
    terraform init
    ```
3. Apply the configuration
    ```
    terraform apply
    ```