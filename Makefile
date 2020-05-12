init:
	pip install -r requirements.txt

check:
	flake8 core/
	pylint core/
	pycodestyle core/
	flake8 features/
	pylint features/
	pycodestyle features/
	flake8 features/hooks/
	pylint features/hooks/
	pycodestyle features/hooks/
	flake8 features/steps/
	pylint features/steps/
	pycodestyle features/steps/
	flake8 main/
	pylint main/
	pycodestyle main/

test:
	behave 