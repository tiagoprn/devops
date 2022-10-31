project home: http://tomashanacek.github.io/mock-server/
python version: python 2.x

---

# How to install and use the python mock server:

## How to install:

    $ pipx install mock-server

## How to raise up the mock server:

    $ mock-server --dir=./current_dir (you can create a shellscript to wrap its creation, so that you can have one dir and one script for each API project to be mocked)

(it will raise on port 8888. The "dir" path pointed is where it stores the mock endpoints.)

## How to create an endpoint on that mock server:

Point your browser to:

    http://localhost:8888/__manage/create

It creates a directory tree on the filesystem on `--dir` path specified, reflecting the url path you are mocking.

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

IMPORTANT: it only supports one response per endpoint (`GET_200.json` or `POST_200.json` e.g.).
To overcome that limitation, I point my installation to `/storage/mock_servers` and there I create a directory
for each API project to be mocked. That directory is version controlled with git.
Then, I create multiple `POST_200.json` (e.g. `POST_200.json.situation_1`, `POST_200.json.situation_2`, etc).
That way, when I need to test a specific situation, I just copy e.g. `POST_200.json.situation_2` to `POST_200.json` and raise the local server.
