# Elastic Stack - Azure
This repo contains the Terraform and Ansible playbooks to spin up an Elastic Security Stack in Microsoft Azure. This lab is meant to give hands-on experience using Elasticsearch, Logstash (and Fleet), and Kibana to setup and monitor security logging.

## Lab Objectives
### Setup Fleet
### Search Data in Kibana
### Create a Detection

## Components
- ELK Host
    - VM Size: Standard_B4ls_v2 (4 vCPUs, 8 GB)
    - Containers
        - elasticsearch
        - kibana
    - Admin user: elkadmin
- Windows Client
    - VM Size: Standard_B2ls_v2 (2 vCPUs, 4 GB)
    - Admin user:
- Linux Server
    - VM Size: Standard_B2ls_v2 (2 vCPUs, 4 GB)
    - Admin user: linadmin

## How to use
1. Install Terraform, Ansible, and the Azure CLI to your system
2. Sign into the Azure CLI
3. Clone this repo and fill out the required values in the `variables.tf` file
4. Run `terraform init`
5. Run `terraform apply`. When prompted, type `yes`.

The Terraform playbooks will output the IP address of the virtual machines. The Ansible playbooks are run automatically within the Terraform playbooks.

## Process
1. Terraform will create the required infrastructure within your Azure subscription
2. Terraform will kick off the Ansible playbooks on the associated hosts after the virtual machines are provisioned

## Variables
- slug: String to prepend to created Azure resources (ex. lab -> lab_rg, lab_elk_nic, etc.)
- location: Azure location you want to create the resources in
    - [List of Azure regions](https://gist.github.com/ausfestivus/04e55c7d80229069bf3bc75870630ec8), use the value under DisplayName
    - Alternatively, run `az account list-locations -o table`
- pass: Password to be used for the environment across all machines
    - **Note**: This is intended to be a lab environment with no sensitive data
- subscription_id: Azure subscription ID