**Пример - конфиги прокси частично удалены**

**Автоматизация работы с прокси сервером**

**Управляется Jenkins**
 https://jenkins.technocom.tech/view/CONFIG/job/TECHNOCOM-nginx/

**Запуск плейбука для обновления конфига nginx и его перезапуска:**

ansible-playbook nginx.yml --tags="nginx" --ask-vault-pass

**Сборка контейнера для запуска Ansible**

docker build -t fadeev/ansible:2.9.6 .
