# docker-autoheal


Monitor and restart unhealthy docker containers. 
This functionality was propose to be included with the addition of `HEALTHCHECK`, however didn't make the cut.
This container is a stand-in till there is native support for `--exit-on-unhealthy` https://github.com/docker/docker/pull/22719.

## Fork
This project is fork from https://github.com/willfarrell/docker-autoheal/
This fork was create to add the funcionality of sending email when a unhealthy container is restarted

## Supported tags and Dockerfile links
- [`latest` (*Dockerfile*)](https://github.com/willfarrell/docker-autoheal/blob/master/Dockerfile)

[![](https://images.microbadger.com/badges/version/willfarrell/autoheal.svg)](http://microbadger.com/images/willfarrell/autoheal "Get your own version badge on microbadger.com")  [![](https://images.microbadger.com/badges/image/willfarrell/autoheal.svg)](http://microbadger.com/images/willfarrell/autoheal "Get your own image badge on microbadger.com")

## How to use
a) Apply the label `autoheal=true` to your container to have it watched.

b) Set ENV `AUTOHEAL_CONTAINER_LABEL=all` to watch all running containers. 

c) Set ENV `AUTOHEAL_CONTAINER_LABEL` to existing label name that has the value `true`.

Note: You must apply `HEALTHCHECK` to your docker images first. See https://docs.docker.com/engine/reference/builder/#/healthcheck for details.


## Hot to use (mail)
To send emails you must set the env vars `MAILTO` and `MAILFROM`

`MAILTO`: list of emails separated by commas to the emails that will receive the email

`MAILFROM`: who are sending email: Example noreplay@yourdomain.com

Complete the file ssmtp.conf with your domain, smtp server (hostname and port)

Note: If `MAILTO` OR `MAILFROM` are empty strings, the email will not be sent.

## ENV Defaults
```
AUTOHEAL_CONTAINER_LABEL=autoheal
AUTOHEAL_INTERVAL=5
DOCKER_SOCK=/var/run/docker.sock
MAILTO=
MAILFROM=
```

## Testing
```bash
docker build -t autoheal .

docker run -d \
    -e AUTOHEAL_CONTAINER_LABEL=all \
    -e MAILTO=example1@mail,example2@mail \
    -e MAILFROM=noreplay@autohealdomain \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$(pwd)/ssmtp.conf:/etc/ssmtp/ssmtp.conf" \
    autoheal                                                                        
```
