pipeline {

  agent any

  stages {

    stage ('Stage 1: Get Latest Code') {
      steps {
        step([$class: 'WsCleanup'])
        checkout scm
      }
    }

    stage ('Stage 2: Display Versions') {
      steps {
        sh '''
          docker -v
          ansible --version
          molecule --version
        '''
      }
    }

    stage ('Stage 3: Molecule Tests') {
      parallel {
        stage ('Stage 3.1: Test Common Role') {
          steps {
            sh '''
              pushd roles/common
              molecule test
              popd
              deactivate
            '''
          }
        }
        stage ('Stage 3.2: Test Compose Host Role') {
          steps {
            sh '''
              pushd roles/compose_host
              molecule test
              popd
              deactivate
            '''
          }
        }
        stage ('Stage 3.3: Test Back-End_Stack Role') {
          steps {
            sh '''
              pushd roles/b404_stack
              molecule test
              popd
              deactivate
            '''
          }
        }
      }
    }

    stage('Stage 4: SonarQube analysis') {
      stages {
        stage ("When on Designated Branch") {
          when {
            anyOf{
              branch 'dev'
            }
          }
          steps {
            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
              withSonarQubeEnv(installationName: 'sonar.b404') {
                script {
                  sh '''
                  docker run -e SONAR_HOST_URL=http://sonar.blink-404.com:9000 --user="$(id -u):$(id -g)" -v "$PWD:/usr/src" sonarsource/sonar-scanner-cli
                  '''
                }
              }
            }
          }
        }
      }
    }
  }
}
