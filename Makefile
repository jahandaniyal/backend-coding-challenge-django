.PHONY: build start test venv run clean env install-dependencies setup-project build

build:
	docker-compose build

start:
	docker-compose up

test:
	docker-compose run --rm app sh -c "python manage.py test && flake8"

# define the name of the virtual environment directory
VENV := venv

# venv is a shortcut target
venv: $(VENV)/bin/activate

run-local:
	cd app; ../$(VENV)/bin/python manage.py runserver

test-local: venv
	. $(VENV)/bin/activate; cd app; pytest

clean:
	rm -rf $(VENV)
	find . -type f -name '*.pyc' -delete

env:
	python3 -m venv $(VENV)

build-local: env install-dependencies setup-project
	echo "Build Completed!"

install-dependencies:
	$(VENV)/bin/python -m pip install --upgrade pip
	$(VENV)/bin/pip install -r requirements.txt

setup-project:
	cd app; ../$(VENV)/bin/python manage.py makemigrations
	cd app; ../$(VENV)/bin/python manage.py migrate
	cd app; ../$(VENV)/bin/python manage.py loaddata default_admin.json
