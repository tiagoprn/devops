# jenkins2

# How to use:

## Run the containers:

    $ make up
    (pay attention to the message at the end, you must start your browser for Jenkins to generate the initial password it asks you to input)

To get the initial Admin password, so you can move on with the
installation:

    $ make passwd

(it may take a little while to work without errors, since jenkins is being initialized. ;)    

So you can test the creation of a testing jenkins job with some sample shellscripts, run:

    $ make copyscripts

## Kill the container:
    $ make kill

** IMPORTANT: If you want to enable Blue Ocean, it is available as a plugin on the Plugin Manager.    


## EXAMPLES

### How to create a shellscript job on Jenkins WebUI:
- **New Item**
- **Freestyle Project**
- **General** - click **"Advanced"**
- Check **"Use custom workspace"**
- On **"Directory"**, type the path of the script (e.g. ```/tmp/script_01.sh```)
- On **"Display name"**, give a friendly name to the script (e.g. "example shell script")
- On **"Build Triggers"**, check **"Build periodically"** and type the following:
```
(cron syntax, below runs each 2 minutes)
*/2 * * * *
```
- On **"Build Environment"**, check **"Add timestamps to the Console Output"**.
- Click "Save".

### How to create a pipeline job on Jenkins WebUI:
(advantage: the pipelines are created on code).
- **New Item**
- Item Name: "Pipeline project" => OK
- On **Pipeline name:**, type: Testing pipeline
- On **Description:**, type: Runs shellscripts in sequence
- On **"Build Triggers"**, check **"Build periodically"** and type the following:
```
(cron syntax, below runs each 5 minutes)
*/5 * * * *
```
- On "Pipeline", choose "Pipeline Script", and type below:
```
    node {
        echo 'Running script 01...[WAIT]'
        stage 'Script 01'
        sh '/tmp/script_01.sh'
        echo 'Running script 01...[DONE]'   

        echo 'Running script 02...[WAIT]'   
        stage 'Script 02'
        sh '/tmp/script_02.sh'
        echo 'Running script 02...[DONE]'   

        echo 'Running script 03...[WAIT]'      
        stage 'Script 03'
        sh '/tmp/script_03.sh'
        echo 'Running script 03...[DONE]'         
    }
```
(notice that this is a script, AKA "Jenkinsfile". It seems to be on a
language called "Groovy".)
- Click "Save".

# Enter the jenkins2 master container:

    $ make exec    

# Credentials:

For testing, I use to create a user with login "admin", password "123456".

# HOW TO RUN COMMANDS ON REMOTE MACHINES THROUGH SSH ON JENKINS (without having Jenkins installed on them):

On your Jenkins machine that will be used to access the remote servers:

## 1) Install Plugin "Publish Over SSH Plugin"

## 2) Configure your SSH credentials
- Manage Jenkins => Configure System => SSH:

- On the "Key" textarea, paste your id_rsa (private key) full text contents. The key full text contents can be obtained this way:

```
$ ssh your-jenkins-server-machine
$ cd /opt/devops/devops_linode/jenkins2
$ make exec
$ cat /var/jenkins_home/.ssh/id_rsa [*]
```

([*] important: its corresponding public key - id_rsa.pub - must be on the remote host/user ~/.ssh/authorized_keys file.)

- On "SSH Servers", click "Add". Fill in the fields:

```
- Name: a human-friendly alias to your server. E.g.: "My Digital Ocean Machine".
- Hostname: host/ip of the remote machine
- Username: ssh account username
- Remote Directory: the "root" directory after logging in.
```

Then, click on "Test Configuration" to make sure the SSH connection is working.

- Click "Save" to save the SSH credentials.

## 3) Create a new Freestyle / Pipeline Job:

- On the "Build" Section, On "Add Buildstep", check "Send files or execute commands over SSH".

- On "Exec Command", type the command to be remotely executed on the remote machine. E.g.:

```
cd /opt/tiagoprnl/tiagoprnl/ && ./deploy.sh
```

- On the Jenkins Dashboard, open your job, build it manually and open the logs to check everything is OK.

###  If running your command remotely results on the following error on its' logs:

```
"sorry, you must have a tty to run sudo"
```

- On the remote machine, run:

```
$ visudo
```

, then change the ssh user line to this:

```
ALL=(ALL) NOPASSWD: ALL
```

, and comment this line:

```
# Defaults requiretty
```

# Create an automatic build of my static blog (bitbucket integration):

## TODO
