init:
	pip install -r requirements.txt

check:
	flake8 */*.py
	flake8 */*/*.py
	flake8 */*/*/*.py
	pycodestyle */*.py
	pycodestyle */*/*.py
	pycodestyle */*/*/*.py
	pylint */*.py
	pylint */*/*.py
	pylint */*/*/*.py

test:
	behave 

allure_reports:
	behave -f allure -o reports/allure_reports ./features

html_reports:
	behave -f html -o reports/html_reports/html_reports.html

re_run:
	behave @rerun_failing.features -f html -o reports/html_reports/html_reports.html