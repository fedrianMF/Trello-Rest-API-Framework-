init:
	pip install -r requirements.txt

check:
	flake8 */*.py
	flake8 */*/*.py
	pycodestyle */*.py
	pycodestyle */*/*.py
	pylint */*.py
	pylint */*/*.py

test:
	behave 