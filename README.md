# docker-pritunl

Docker image for pritunl.

## Installation

```shell
$ docker build -t jqtype/pritunl .
```

or

```shell
$ docker pull jqtype/pritunl
```

## Configuration

The pritunl can be configured through `pritunl.env`.

```
# External MongoDB URI.
# NOTE: Unlike existing docker images, this image doesn't prorvide MongoDB inside Pritunl Docker image.
# mongodb://<ip_addr_or_container_name>:<mongodb_port>/pritunl

PRITUNL_MONGODB_URI=mongodb://mongodb:27017/pritunl

# (Optional)
PRITUNL_REVERSE_PROXY=false

# (Optional)
# PRITUNL_WEBCONSOLE_PORT=9700
```

We should note that unlike most of existing pritunl docker images, the pritunl image does not include MongoDB. This means that the MongoDB must be defined as a separated container as given in the `docker-compose.yml`. In the `pritunl.env`, you should also specify the URI of MongoDB. When MongoDB is prepared as a docker container with the name 'mongodb', it can be accessed as `mongodb://mongodb:27017/pritunl`.

## How to run

```shell
$ docker-compose up -d
```

Then, you can access the web console.

At the first time, you should execute the following command to retrieve the initial password for web console login.

```
$ docker exec pritunl /bin/sh -c 'pritunl default-password'
```
