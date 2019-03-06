python version: python 2.x


# How to install and use a python mock server:

http://tomashanacek.github.io/mock-server/

## How to install:

    $ pip install mock-server

## How to raise up the mock server:

    $ mock-server --dir=./current_dir

(it will raise on port 8888. The "dir" path is where it store the mock endpoints.)

## How to create and endpoint on that mock server:

http://localhost:8888/__manage/create

Alternatively, you can create the folders physically that will hold the endpoints. E.g.:

```
- response content format: %METHOD%_%STATUS%.%FORMAT%
- response headers format: %METHOD%_H_%STATUS%.%FORMAT%

current_dir/
    GET_200.json         # response content for GET /
    GET_H_200.json       # headers for GET /
    user/
        DELETE_404.xml   # response content for DELETE /user.xml?__statusCode=404
        POST_200.json    # response content for POST /user
        POST_H_200.json  # headers for POST /user
```


