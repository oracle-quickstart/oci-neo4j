# oci-neo4j
This is a Terraform module that deploys [Neo4j](https://neo4j.com/product/) on [Oracle Cloud Infrastructure (OCI)](https://cloud.oracle.com/en_US/cloud-infrastructure).  It is developed jointly by Oracle and Neo4j.

## Prerequisites
First off you'll need to do some pre deploy setup.  That's all detailed [here](https://github.com/oracle/oci-quickstart-prerequisites).

## Clone the Module
Now, you'll want a local copy of this repo by running:

    git clone https://github.com/oracle/oci-quickstart-neo4j.git

## Deploy
The TF templates here can be deployed by running the following commands:
```
cd oci-quickstart-neo4j/simple
terraform init
terraform plan
terraform apply # will prompt to continue
```

The output of `terraform apply` should look like:
```
Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:

Core server private IPs = 10.0.0.3,10.0.0.2,10.0.0.4
Core server public IPs = 150.136.212.76,129.213.91.51,132.145.183.234
```

You can access the Neo4j browser at `http://<core_public_ip>:7474` with the default login `neo4j/neo4j`. You will be prompted to change the password at first login.
