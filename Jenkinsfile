pipeline {

  agent any

  stages {

    stage ('Stage 1: Get Latest Code') {
      steps {
        step([$class: 'WsCleanup'])
        checkout scm
      }
    }

    stage ('Stage 2: Setup Python Virtual Environment') {
      steps {
        sh '''
          pip3.6 install --user -I virtualenv
          /usr/local/bin/virtualenv --system-site-packages virtenv
          source virtenv/bin/activate
          pip install --upgrade molecule docker
        '''
      }
    }

    stage ('Stage 3: Display Versions') {
      steps {
        sh '''
          source virtenv/bin/activate
          docker -v
          ansible --version
          molecule --version
        '''
      }
    }

    stage ('Stage 4: Molecule Tests') {
      parallel {
        stage ('Stage 4.1: Test Common Role') {
          steps {
            sh '''
              source virtenv/bin/activate
              pushd roles/common
              molecule test
              popd
              deactivate
            '''
          }
        }
        stage ('Stage 4.2: Test Compose Host Role') {
          steps {
            sh '''
              source virtenv/bin/activate
              pushd roles/compose_host
              molecule test
              popd
              deactivate
            '''
          }
        }
        stage ('Stage 4.3: Test Back-End_Stack Role') {
          steps {
            sh '''
              source virtenv/bin/activate
              pushd roles/b404_stack
              molecule test
              popd
              deactivate
            '''
          }
        }
      }
    }

    stage('Stage 5: SonarQube analysis') {
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
