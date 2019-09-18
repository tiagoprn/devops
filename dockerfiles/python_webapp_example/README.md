# Flask app Dockerfile

This is a Dockerfile that can be used to dockerize a flask app,
which runs at port :5000.

To quickly test an app, you can create one
following the instructions of [my minimal flask app cookiecutter](https://github.com/tiagoprn/minimal_flask_app_cookiecutter).

To build the image:

```
$ docker build -t tiagoprn/my_flask_app_name:1.0 --pull --no-cache --build-arg UID=$(id -u) --build-arg GID=$(id -g) .
```

To check if the image was created:

```
$ docker images
```

To run a container from this image:

```
$ docker run -p '5000:5000' --name validation_container --rm -d tiagoprn/my_flask_app_name:1.0
```

To check the container is running:

```
$ sudo docker ps
```

