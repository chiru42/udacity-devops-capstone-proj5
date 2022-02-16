## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	# Additional, optional, tests could go here
	python -m pytest -vv tests/*.py
	#python -m pytest --nbval notebook.ipynb
validate-circleci:
    # See https://circleci.com/docs/2.0/local-cli/#processing-a-config
    # circleci config process .circleci/config.yml
run-circleci-local:
    # See https://circleci.com/docs/2.0/local-cli/#running-a-job
    # circleci local execute
    
lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint --ignore=DL3013 Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,E,W app.py

dockerize: 
	./run_docker.sh
dockepush:
	./upload_docker.sh
setupcluster:
	eksctl create cluster --config-file=/kubernetes/demo-cluster.yaml
	# fetch cluster name and export to env variable "cluster-name"
deletecluster:
	eksctl delete cluster --region=ap-south-1 --name=$cluster-name

all: install lint test

#####create cluster using eksctl
## eksctl create cluster --config-file=demo-cluster.yaml
## eksctl delete cluster --region=ap-south-1 --name=$cluster-name

#### handy commads for kubectl

## kubectl get deployments
## kubectl get nodes
## kubectl get pods
## kubectl get services Or kubectl get svc $servicename
## kubectl describe pod $podname
## To get the service external-ip
# kubectl get service $service-name -o jsonpath="{.status.loadBalancer.ingress[0].hostname}"

## kubectl apply -f deployment.yaml
## kubectl delete deployment $deployment-name

## secretes encoding via terminal
# echo -n 'password' | openssl base64
