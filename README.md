# dgheating.online
The simplest way to bring up a wordpress website using witline (now witpass) wordpress image. You do not need anything fancy in this repository.


# Repository structure:

```
$ tree 
.
├── app.env
├── app.env.example
├── custom-git-issues.sh
├── docker-compose.yml -> docker-compose.yml.server
├── docker-compose.yml.localpc
├── docker-compose.yml.server
├── Dockerfile
├── docs
├── plugins
│   ├── download.list
│   ├── gitrepos.list
│   └── README.md
└── themes
    ├── download.list
    ├── gitrepos.list
    └── README.md

3 directories, 13 files
[kamran@kworkhorse dgheating.online]$
```
# How to use this image:

```
$ docker-compose -f docker-compose.localpc up -d
```


# Environment variables:
Use `app.env` file to pass environment variables to the docker-compose application. 

Ensure that you encode the git token with base64 before placing it in `app.env` . Here is how you can convert your git token into base64 representation:

```
$ MY_GITHUB_TOKEN='thegittokenyouobtainedfromgithub'
$ echo ${MY_GITHUB_TOKEN} | base64 -w 0 
```

Copy the output of the last echo command and paste it in `app.env` for the GITHUB_TOKEN variable. **Note:** GITHUB_USER is not encoded with base64.


Here is what the `app.env` file looks like:
```
$ cat app.env
WORDPRESS_DB_HOST=db.example.com
WORDPRESS_DB_NAME=db_sitename
WORDPRESS_DB_USER=user_sitename
WORDPRESS_DB_PASSWORD=secret_password
WORDPRESS_TABLE_PREFIX=wp_
APACHE_RUN_USER=#1000
APACHE_RUN_GROUP=#1000
GITHUB_USER=regulargithubusername
GITHUB_TOKEN=base64encodedgithubtoken
```


