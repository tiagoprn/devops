# portainer - a Web UI to manage docker containers, images, volumes, etc...

To run this container:

```
$ sudo docker-compose up -d
```

The admin passwd file must NOT contain new line characters at all, just the password. Otherwise, it
will not login with the password and no feedback will be provided.

So, to remove the '\n' from the file if it exists:

```
$ cat  admin.passwd | tr -d '\n' > admin.passwd.new
$ mv admin.passwd.new admin.passwd
```

Then, you can login with these credentials:

[Local container url](http://localhost:9000/)

Credentials:

```
username: admin
password: the one from the file provided
```

