pipeline {
  agent {
    label "master"
  }

  environment {
    ANSIBLE_VAULT_PASSWORD = credentials('ANSIBLE_VAULT_PASSWORD_TECH')
  }

  stages {
    stage('Clone from Gogs') {
      agent {
        label "master"
      }
      steps {
        git branch: 'technocom-nginx',
        credentialsId: 'ssh-key-gogs',
        url: 'git@gogs.technocom.tech:Config/Config.git'
        sh 'ls -a'
        sh 'cat README.md'
      }
    }

    stage('Test config nginx') {
      agent {
        docker {
          image 'fadeev/nginx:vts'
          args '-u 0:0 -v $WORKSPACE/files/letsencrypt/live:/etc/letsencrypt/live -v $WORKSPACE/roles/nginx/templates/nginx.conf:/etc/nginx/nginx.conf -v $WORKSPACE/roles/nginx/templates/snippets:/etc/nginx/snippets -v $WORKSPACE/roles/nginx/templates/ssl:/etc/nginx/ssl -v $WORKSPACE/roles/nginx/templates/conf.d:/etc/nginx/conf.d'
          label "master"
        }
      }
      steps {
        sh "nginx -t"
      }
    }

    stage('Run Ansible playbook') {
      agent {
        docker {
          image 'fadeev/ansible-no-mitogen:2.9.6'
          args '-v $WORKSPACE:/ansible -u 0:0'
          label "master"
        }
      }

      steps {
        sshagent(credentials : ['ssh-key-technocom']) {
          sh '''
            echo ${ANSIBLE_VAULT_PASSWORD} | ansible-playbook \
              --tags="nginx" \
              --extra-vars ansible_ssh_common_args='"-o StrictHostKeyChecking=no"' \
              --ask-vault-pass \
              nginx.yml
          '''
        }
      }
    }

  }

  post {
     always {
       deleteDir()  // удаление рабочего каталога
     }
  }

 }
