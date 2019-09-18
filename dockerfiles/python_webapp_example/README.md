# Flask app Dockerfile

This is a Dockerfile that can be used to dockerize a flask app,
which runs at port :5000.

To quickly test an app, you can create one
following the instructions of [my minimal flask app cookiecutter](https://github.com/tiagoprn/minimal_flask_app_cookiecutter).

To build the image:

```
$ docker build -t tiagoprn/my_flask_app_name:1.0 --pull --no-cache .
```

To check if the image was created:

```
$ docker images
```

To run a container from this image:

```
$ docker run tiagoprn/my_flask_app_name:1.0 --rm -d
```

To check the container is running:

```
$ sudo docker ps
```

