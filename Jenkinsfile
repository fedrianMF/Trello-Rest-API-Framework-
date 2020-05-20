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
        script{
          try{
            bat 'behave -f allure -o reports/allure_reports ./features'  
          } catch(err){
            first_test_failed = true
          }
        } 
      }
    }
    stage('Generate reports'){
      when {
        expression {
          first_test_failed
        }
      }
      steps{
        catchError(buildResult:'SUCCESS', stageResult:'FAILURE'){
          bat 'behave @rerun_failing.features -f html -o reports/html_reports/html_reports.html'
        }
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
        catchError(buildResult:'SUCCESS', stageResult:'SUCCESS'){
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
}