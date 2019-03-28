# An example wordpress based website
This is the simplest way to bring up a wordpress website, using witline (now witpass) wordpress image. You do not need anything fancy in this repository.

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
[kamran@kworkhorse example.com]$
```

# How to use this image:
* Clone this repository on your computer, and save it with the name of the website you are going to setup, e.g. `example.com` . 
* Setup a MySQL database to hold this site's database stuff, and/or keep the DB credentials handy.
* Setup a persistent storage on the computer to hold this website's **uploads** . This location will be specified in `docker-compose.yml.localpc` and/or `docker-compose.yml.server` files, and will be mounted at `/var/www/html/wp-content/uploads` when the container is started using `docker-compose up -d` command. An example of this directory is: `/home/kamran/container_data/example.com/uploads` . You will need to make sure that you do a frequent backup of this location.
* If you intend to download any custom plugins or themes which are actually in a private fit repository, then you need to provide your github username and a github token. You can create a github token just for this specific person against your github user. If you don't then you do not need to provide github_user or github_token. 
* Find the id of the OS user you are logged in as on your computer. This wil be used to set correct ownership and permissions for the `uploads` directory.
* Create `app.env` by copying `app.env.example` file. 
* Adjust app.env with the environment variables related to this particular website.
* Make sure that you adjust `docker-compose.yml.localpc` file with correct values, while you are working on your local computer. The person who is deploying this website on the server is responsible for adjusting `docker-compose.yml.server` according to the setup/environment in the server.
* Also ensure that the name resolution/DNS is in place. On your local computer you can use `/etc/hosts` , but for setup to work on the server, the website/domain should have correct DNS settings in the related domain registrar.
 
Bring up the image using:
```
$ docker-compose -f docker-compose.localpc build
$ docker-compose -f docker-compose.localpc up -d
```

Check status of the container:
```
$ docker-compose -f docker-compose.localpc ps

or

$ docker ps
```

Check logs:
```
$ docker logs -f <container-name|container-id>
```

Stop and remove a container using `docker-compose`:
```
$ docker-compose -f docker-compose.localpc stop  <container-name|container-id> 
$ docker-compose -f docker-compose.localpc rm -f  <container-name|container-id> 
```


# Environment variables:
* Use `app.env` file to pass environment variables to the docker-compose application. This file is part of `.gitignore` and must remain so.
* Ensure that you encode your git token with base64 before placing it in `app.env` . Here is how you can convert your git token into base64 representation:

```
$ MY_GITHUB_TOKEN='yourgithubtokenyouobtainedfromgithub'
$ echo ${MY_GITHUB_TOKEN} | base64 -w 0 
```

Copy the output of the last echo command and paste it in `app.env` for the GITHUB_TOKEN variable. **Note:** GITHUB_USER is not encoded with base64.


Here is what the `app.env` file looks like:
```
$ cat app.env
WORDPRESS_DB_HOST=db.example.com
WORDPRESS_DB_NAME=db_sitename
WORDPRESS_DB_USER=user_sitename
WORDPRESS_DB_PASSWORD=secret
WORDPRESS_TABLE_PREFIX=wp_
APACHE_RUN_USER=#1000
APACHE_RUN_GROUP=#1000
GITHUB_USER=kamran
GITHUB_TOKEN=base64encodedgithubtoken
```


