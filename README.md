**Пример - конфиги apache не полные**

**Автоматизация работы с кластером Apache**

**Управляется Jenkins**
https://jenkins.technocom.tech/view/PROD-CONFIG/job/TIS-UGRA-httpd/

**Запуск плейбука для обновления конфига Apache и его перезапуска:**

ansible-playbook httpd.yml --tags="httpd" --ask-vault-pass

**Сборка контейнера для запуска Ansible**

docker build -t fadeev/ansible:2.9.6 .
