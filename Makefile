HUMILIS := .env/bin/humilis
PIP := .env/bin/pip
PYTHON := .env/bin/python
AWS := .env/bin/aws
STAGE := DEV
JOBS := 1
HUMILIS_ENV := s3d-demo
OUTPUTS = $(HUMILIS_ENV)-$(STAGE).outputs.json

# create virtual environment
.env:
	virtualenv .env -p python3

# setup humilis to support the deployment targets: create, update, delete
install: .env
	$(PIP) install -r requirements.txt

# remove .env
clean:
	rm -rf .env

# configure humilis
configure:
	$(HUMILIS) configure --local

# deploy the AWS resources needed to learn and serve the mappings
create: install
	$(HUMILIS) create \
		--stage $(STAGE) \
		--output $(OUTPUTS) \
		$(HUMILIS_ENV).yaml.j2

# update the CF deployment
update: install
	$(HUMILIS) update \
		--stage $(STAGE) \
		--output $(OUTPUTS) \
		$(HUMILIS_ENV).yaml.j2

# destroy the CF deployment
delete: install
	$(HUMILIS) delete \
		--stage $(STAGE) \
		$(HUMILIS_ENV).yaml.j2
