init:
	pip install -r requirements.txt

check:
	#flake8 features/
	#pylint features/
	#pycodestyle features/

test:
	behave 