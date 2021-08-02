pipeline {
  agent {
    label "master"
  }

  environment {
    ANSIBLE_VAULT_PASSWORD = credentials('ANSIBLE_VAULT_PASSWORD')
  }

  
  stages {
    stage('Clone from Gogs') {
      agent {
        label "master"
      }
      steps {
        git branch: 'master',
        credentialsId: 'ssh-key-gogs',
        url: 'git@gogs.technocom.tech:Config/Config.git'
      }
    }
    
    stage('Test config nginx') {
      agent {
        docker {
          image 'fadeev/nginx:vts'
          args '-u 0:0 -v $WORKSPACE/roles/nginx/templates/nginx.conf:/etc/nginx/nginx.conf -v $WORKSPACE/roles/nginx/templates/snippets:/etc/nginx/snippets -v $WORKSPACE/roles/nginx/templates/ssl:/etc/nginx/ssl -v $WORKSPACE/roles/nginx/templates/conf.d:/etc/nginx/conf.d'
          label "master"
        }
      }
      steps {
        git branch: 'master',
        credentialsId: 'ssh-key-gogs',
        url: 'git@gogs.technocom.tech:Config/Config.git' 
        sh "nginx -t"
      }
    }
    
    stage('Run Ansible playbook') {
      agent {
        docker {
          image 'fadeev/ansible-no-mitogen:2.9.6'
          args '-v $WORKSPACE:/ansible -u 0:0'
          reuseNode true
        }
      }
      steps {
	
	checkout scm
		
        sshagent(credentials : ['ssh-key-gazprom']) {
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
       deleteDir()
     }
  }

}
