# equifax-test
Test to apply for SRE at Equifax


### Provisioning infrastructure using Terraform: 
(kubernetes node pool was created in a region only, in order to avoid multiregion replicas)
- cd /terraform
- terraform init
- terraform apply

### Build a simple python service
This app has junt one method (GET at port 80), which retrieves a list of songs 
- cd ../python-service
- python3 -m venv venv 
- source venv/bin/activate 
- pip install Flask 
- pip freeze > requirements.txt

### Build Image with packer: 
(-force flag allows to override the image at gcr.io)
- cd ../packer
- packer build -force packer.json

### deploy image in kubernetes with ansible
- ansible-playbook -i inventory playbook.yml
