---
date: 2024-07-18
categories:
    - FastAPI
    - AWS
slug: eb-for-fastapi
readtime: 12
authors:
  - hk
    
---

# Deploy FastAPI using AWS Elastic BeanStalk


i wont get into the development part of the application using FastAPI, this blog will be completely focused on the deployment and operations part of the application.


# Install the dependencies

??? tip
        
    Be sure to register an IAM user for getting access to your AWS account.

To access the Elastic Beanstalk in your laptop, install the [EB CLI](https://github.com/aws/aws-elastic-beanstalk-cli-setup#2-quick-start) or with [pip](https://pypi.org/project/awsebcli/)

<!-- more -->

??? tip

    Do check the colorama and other dependencies if you are using the pip awsebcli. it can break your entire environment.

After installing, check if the EB CLI is installed perfectly by running:

```sh
eb --version
```


Once everything mentioned above is setup:

## Intialize the project

```sh
eb init
```

You'll be asked multiple questions:

- Default Region
- Applicaiton Name
- Platform
- Asks for the Code Commit, be sure if you are using the git or code commit to push changes in your applicaiton


After answering all the questions, it adds a new directory in the project dir `.elasticbeanstalk`.

```
.elasticbeanstalk
----- config.yml
```

The file should be something more like this:

```

# config.yml

branch-defaults:
  branch-name:
    environment: Env-dev
    group_suffix: null
global:
  application_name: App Name
  branch: null
  default_ec2_keyname: key-pair
  default_platform: Python 3.11 running on 64bit Amazon Linux 2023
  default_region: ap-south-1
  include_git_submodules: true
  instance_profile: null
  platform_name: null
  platform_version: null
  profile: null
  repository: null
  sc: git
  workspace_type: Application

```


## Create the Environment

```sh
eb create
```

Again, you'll be prompted with a few questions.

Once you are done with the questions, your environment will spin up and the Elastic BeanStalk will spin up EC2 instance with your FastAPI application.

you can view the status of the environment by:

```sh
eb status
```


```
Environment details for: Env-Name
  Application name: Application Name
  Region: ap-south-1
  Deployed Version: app-82fb-2203743843434324
  Environment ID: e-nsizyek74z
  Platform: arn:aws:elasticbeanstalk:us-west-2::platform/Python 3.8 running on 64bit Amazon Linux 2/3.3.11
  Tier: WebServer-Standard-1.0
  CNAME: cname-env.us-west-2.elasticbeanstalk.com
  Updated: 2024-07-11 23:16:03.822000+00:00
  Status: Launching
  Health: Red
```


## Configure an Environment

In the previous step, we tried accessing our application and it returned 502 Bad Gateway. There are three reasons behind it:

Python needs `PYTHONPATH` in order to find modules in our application.
By default, Elastic Beanstalk attempts to launch the WSGI application from application.py, which doesn't exist.
If not specified otherwise, Elastic Beanstalk tries to serve Python applications with Gunicorn. 

Gunicorn by itself is not compatible with FastAPI since FastAPI uses the newest ASGI standard.

Let's fix these errors.

Create a new folder in the project root called `.ebextensions`. Within the newly created folder create a file named `01_fastapi.config`:

```

# .ebextensions/01_fastapi.config

option_settings:
  aws:elasticbeanstalk:application:environment:
    PYTHONPATH: "/var/app/current:$PYTHONPATH"
  aws:elasticbeanstalk:container:python:
    WSGIPath: "main:app"

container_commands:
    01_init:
        command: "source /var/app/venv/*/bin/activate && pip install -r requirements.txt"

```

The important part for running the application on the environment:


### Create a Procfile

make a file with name `Procfile` in the project directory

```
web: gunicorn main:app --workers=4 --worker-class=uvicorn.workers.UvicornWorker
```

At this stage after completing all the above steps, the project structure should look like this:

```
|-- .ebextensions
|   └-- 01_fastapi.config
|-- .elasticbeanstalk
|   └-- config.yml
|-- .gitignore
|-- Procfile
|-- README.md
|-- main.py
|-- models.py
`-- requirements.txt
```

You can add in the ENV variables in the `Configuration` tab of the environment.

Now commit the changes to your git repository and deploy:

```
git add .

git commit -m "feat: elastic beanstalk added"

git push 

eb deploy

```


After the deployment you can view the status of the application from the AWS portal or you can use:

```
eb status
```

For getting a more detailed logs:

```
eb logs
```

## Terminate

If you are done with testing and want to remove all the resources associated with this project:

```
eb terminate
```


## My CheckList

I use AWS Amplify(service for deploying static sites) for my client and AWS EB for the server deployment.

### Client

    - [X] Update the server uri in the build
    - [X] Also remove all the console statements to not disclose any information

### Server

    - [X] Update the Security Rules for the environment (Inbound and Outbound)
    - [X] Update the client uri in the ENV Variables and other if required
    - [X] If using any Auth providers, append your server uri
    - [X] If using HTTPS, add the `Listener` for port 443 and select the SSL certificate from ACM

