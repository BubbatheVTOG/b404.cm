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
          pip install --user --upgrade molecule docker
        '''
      }
    }

    stage ('Stage 3: Display Versions') {
      steps {
        sh '''
          docker -v
          python -V
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
              pushd roles/common
              molecule test
              popd
              deactivate
            '''
          }
        }
        stage ('Stage 4.2: Test Back-End_Stack Role') {
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
  }
}
