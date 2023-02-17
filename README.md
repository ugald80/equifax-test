# Equifax-test
Test to apply for SRE at Equifax. 
General instructions to reproduce the test resolutions are described below.

### 0. Setup 
- Install python, terraform, packer and ansible tools
- Create a service account and a service account key in json format
- Replace the content in google-credentials with the content of your service account key file
- Make sure you have enabled the following Google Cloud Services/Apis: 
Compute Engine,
Cloud DNS API,
Kubernetes Engine API,
Service Networking API,
Serverless VPC Access API,
GKE Hub API,
Anthos API,
Cloud Build API,
Cloud Datastore API,
Cloud SQL,
Cloud Storage,
Container Registry API,
GKE Connect API




### 1. Provisioning infrastructure using Terraform: 
(kubernetes node pool was created in a region only, in order to avoid multiregion replicas)
- cd /terraform
- terraform init
- terraform apply

### 2. Building a simple python service
This app has junt one method (GET at port 80), which retrieves a list of songs 
- cd ../python-service
- python3 -m venv venv 
- source venv/bin/activate 
- pip install Flask 
- pip freeze > requirements.txt

### 3. Build Image with Packer: 
(-force flag allows to override the image at gcr.io)
- cd ../packer
- packer build -force packer.json

### 4. Deploy image in kubernetes with Ansible
- ansible-playbook -i inventory deployment.yml

### 5. Implement an ISTIO service mesh with Terraform
The ASM submodule from Google's kubernetes-engine Terraform module is used to install an Anthos Service Mesh over the kubernetes cluster created previously
(source: https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/25.0.0/submodules/asm)
