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
          /usr/bin/docker -v
          /usr/bin/python -V
          /usr/local/bin/ansible --version
          /usr/local/bin/molecule --version
        '''
      }
    }

    stage ('Stage 3: Molecule Tests') {
      parallel {
        stage ('Stage 3.1: Test Common Role') {
          steps {
            sh '''
              pushd roles/common
              /usr/local/bin/molecule test
              popd
            '''
          }
        }
        stage ('Stage 3.2: Test Back-End_Stack Role') {
          steps {
            sh '''
              pushd roles/b404_stack
              /usr/local/bin/molecule test
              popd
            '''
          }
        }
      }
    }
  }
}
