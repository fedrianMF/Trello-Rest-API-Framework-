init:
	pip install -r requirements.txt

check:
	flake8 core/*py
	pylint core/*py
	pycodestyle core/*py
	flake8 core/main/*py
	pylint core/main/*py
	pycodestyle core/main/*py
	flake8 features/*py
	pylint features/*py
	pycodestyle features/*py
	flake8 features/hooks/*py
	pylint features/hooks/*py
	pycodestyle features/hooks/*py
	flake8 features/steps/*py
	pylint features/steps/*py
	pycodestyle features/steps/*py

test:
	behave 