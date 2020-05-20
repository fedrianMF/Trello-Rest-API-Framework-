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
                bat 'allure --version'
            }
        }
    }
}