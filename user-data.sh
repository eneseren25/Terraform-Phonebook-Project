#! /bin/bash
yum update -y
yum install python3 -y
pip3 install flask
pip3 install flask_mysql
yum install git -y
TOKEN="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"
cd /home/ec2-user && git clone https://$TOKEN@github.com/eneseren25/Terraform-Phonebook-Project.git
python3 /home/ec2-user/phonebook/phonebook-app.py

