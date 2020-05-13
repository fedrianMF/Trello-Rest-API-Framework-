init:
	pip install -r requirements.txt

check:
	flake8 main/
	flake8 features/
	pylint main/
	pylint features/
	pycodestyle main/
	pycodestyle features/

test:
	behave 