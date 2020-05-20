pipeline {
    agent any
    stages {
        stage('Download GitLab'){
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/master' ]],
                    extensions: scm.extensions,
                    userRemoteConfigs: [[
                        url: 'https://gitlab.com/atbootcamp02/trello-rest-api-framework.git',
                        credentialsId: 'gitlab-credential'
                    ]]
                ])
            }
        }
        stage('Run test'){
            steps{
                bat 'make test'
            }
        }
        stage('Generate reports'){
            steps{
                bat 'behave -f html -o D:/reports.html'
                bat 'behave -f allure -o ./reports ./features'
            }
        }
        stage('Show allure reports'){
            steps{
                bat 'allure serve ./reports'
            }
        }
    }
}