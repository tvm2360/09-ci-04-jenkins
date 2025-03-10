# 09-ci-04-jenkins

## Подготовка к выполнению

### Terraform - подготовка виртуальных машин
``` sh
terraform apply
```
![TerraformApply](./pictures/0_Terraform_Apply.png)

### Ansible - подготовка конфигураций

Используются дистрибутивы (./playbook/group_vars/jenkins.yml):

- Java JDK 17.0.12 (java_download_url: "https://download.oracle.com/java/17/archive/jdk-17.0.12_linux-x64_bin.rpm")

- Jenkins 2.440.1 (jenkins_download_url: "https://archives.jenkins.io/redhat-stable/jenkins-2.440.1-1.1.noarch.rpm")
``` sh
ansible-playbook -i ./inventory/hosts.yml site.yml
```

![AnsiblePlaybook](./pictures/0_Ansible_Playbook.png)

В браузере http://xxx.xxx.xxx.xxx:8080/

![AnsiblePlaybook](./pictures/0_Jenkins_Start.png)

### Jenkins - запуск, первоначальная настройка и проверка работоспособности

Для разблокировки Jenkins, в поле вставляем содержимое файла по указанному пути в виртуальной машины jenkins-master-01:
```sh
ssh xxx.xxx.xxx.xxx
sudo -i
cat /var/lib/jenkins/secrets/initialAdminPassword
```

Устанавливаем плагины:

![JenkinsPlugins](./pictures/0_Jenkins_Install_Plugin.png)

![JenkinsExtensions](./pictures/0_Jenkins_Download_Extensions.png)

Вводим имя пользователя, пароль, данные и почту пользователя:

![JenkinsUser](./pictures/0_Jenkins_Create_User.png)

, и попадаем на стартовую страницу Jenkins:

![JenkinsPlugins](./pictures/0_Jenkins_Wellcome.png)

Добавляем агента:

![JenkinsAddAgent](./pictures/0_Jenkins_Agent_Add1.png)

![JenkinsAddAgent](./pictures/0_Jenkins_Agent_Add2.png)

 - Имя, описание: любое
 - Количество процессов исполнителей: кол-во процессорных потоков
 - Удаленная корневая директория: из значения переменной jenkins_agent_dir в ./playbook/group_vars/jenkins.yml
 - Метки: на свое усмотрение
 - Способ запуска: Launch agents via SSH
 - реквизиты для входа:

![JenkinsCredentials](./pictures/0_Jenkins_Agent_Credentials.png)

 - Kind: SSH Username with private key;
 - id: любой
 - description: любой
 - username: jenkins
 - Private Key => Enter directly => Key => Add: В поле вставить содержимое ~/.ssh/id_rsa виртуальной машины jenkins-master 

Разрешаем входящие соединения от агентов:

![JenkinsSecurity](./pictures/0_Jenkins_Agent_Security.png)

Состояние агентов:

![JenkinsState](./pictures/0_Jenkins_Agents_State.png)

## Основная часть

### 1. Freestyle Job

Шаги:
![FreestyleSteps](./pictures/1_Freestyle_Step.png)

Результат:
![FreestyleResult](./pictures/1_Freestyle_Result.png)

Протокол: [FreestyleResultProtocol](./add/1_Freestyle_Result_Prot.txt)

### 2. Declarative Pipeline Job

![PipelineJob](./pictures/2_Pipeline_Job.png)

Шаги:
![PipelineSteps](./pictures/2_Pipeline_Steps.png)

Результат:
![PipelineResult](./pictures/2_Pipeline_Result.png)

### 3. Declarative Pipeline из Jenkinsfile

![PipelineSCMJob](./pictures/3_Pipeline_SCM_Job.png)

Результат:
![PipelineSCMJobResult](./pictures/3_Pipeline_SCM_Job_Result.png)

### 4. Multibranch Pipeline

![MultibranchPipelineJob](./pictures/4_Multibranch_Pipeline_Job.png)

Результат:
![MultibranchPipelineLog](./pictures/4_Multibranch_Pipeline_Log.png)

### 5. Scripted Pipeline

![ScriptedPipelineJob](./pictures/5_Scripted_Pipeline_Job.png)

Результат:
![ScriptedPipelineResult](./pictures/5_Scripted_Pipeline_Result.png)

![ScriptedPipelineResult](./pictures/5_Scripted_Pipeline_Proto.png)

### 6. Scripted Pipeline с флагами

![ScriptedPipelineJob](./pictures/6_Scripted_Pipeline_Job.png)

Результат:
![ScriptedPipelineResult1](./pictures/6_Scripted_Pipeline_Result_False.png)

![ScriptedPipelineResult1](./pictures/6_Scripted_Pipeline_Result_True.png)

### 7. ScriptedJenkinsfile

``` jenkins
node("linux"){
    stage("Git checkout"){
        git 'https://github.com/aragastmatb/example-playbook.git'
    }
    stage("Sample define prod_run"){
        prod_run=true
    }
    stage("Run playbook"){
        if (prod_run){
            sh 'ansible-playbook site.yml -i inventory/prod.yml'
        }
        else{
            sh 'ansible-playbook site.yml -i inventory/prod.yml --check --diff'
        }
    }
}
```
### 8. Ссылки

Репозиторий с ролью - https://github.com/tvm2360/08-ansible-05-testing/tree/1.0.1/playbook/roles/vector

Declarative Pipeline - https://github.com/tvm2360/09-ci-04-jenkins/blob/main/Jenkinsfile

Scripted Pipeline - https://github.com/tvm2360/09-ci-04-jenkins/blob/main/ScriptedJenkinsfile


