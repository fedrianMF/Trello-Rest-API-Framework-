# TRELLO API AUTOMATION FRAMEWORK

Writen in python3.8 and using its behave implementation. Uses gherking syntax to perform tests in the following endpoints:
With prefix: https://api.trello.com/1/
- /boards/
- /lists/
- /cards/
- /members/

## About

### Core

Main functionality is present in this folder. 
It includes the request manager, and its utils as; api constants, file reader, and logger manager.

### Hooks

Ussing defined classes for Trello endpoint allows to create or clean environment for different tests. You can use this section to set and delete all pre-requirements to create a new feature or scenario.

### Trello

This folder includes requests classes to use in any project. Those classes can send request to Trello Rest API, also this folder contains all schemas to compare with the test response.

### Logger

A logger shows actions perfomed in request manager, this information includes:
- Method of the request
- Endpoint name
- Information sent in body

## Getting Started

### Requirements

- Python 3.8.2 version.
- Allure framework (to serve allure reports).
- Make
- A browser to see the reports

### Setup

Uses package manager [pip](https://pip.pypa.io/en/stable/) to install framework requirements.

In your python virtual environment run:

```bash
make init
```

### User data file
A behave.ini file is needed in root directory with following parameters:

You can get all credentials in this link: https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/
```
[behave.userdata]
url = https://api.trello.com/1/
primary_user_key = 'your_user_key'
primary_user_token = 'your_user_token'
primary_user_oauth_token = 'your_user_oauth_token'
secondary_user_key = 'your_secondary_user_key'
secondary_user_token = 'your_secondary_user_tokeny'
secondary_user_oauth_token = 'your_secondary_user_oauth_token'
```

### Usage

To check code style run:
```bash
make check
```

To run all implemented tests run:
```bash
make test
```

To generate allure report or html report:
```bash
make allure_reports
```
or:
```bash
make html_reports
```

If you get a failed feature or scenario re run with:
```bash
make re_run
```

## Acknowledgments

To [Fundacion-jala](http://fundacion-jala.org/)  

A special thanks to: Ignacio Cabrera Bustamante.  

