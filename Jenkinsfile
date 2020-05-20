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
                bat 'behave -f html -o reports/html_reports/html_reports.html'
                bat 'behave -f allure -o reports/allure_reports ./features'
            }
        }
        stage('reports') {
            steps {
                  script {
                        allure([
                                includeProperties: false,
                                jdk: '',
                                properties: [],
                                reportBuildPolicy: 'ALWAYS',
                                results: [[path: 'reports/allure_reports']]
                        ])
                }
                publishHTML (target: [
                        allowMissing: false,
                        alwaysLinkToLastBuild: false,
                        keepAll: true,
                        reportDir: 'reports/html_reports',
                        reportFiles: 'html_reports.html',
                        reportName: "Reruned Tests"
                    ])

            }
        }
    }
}