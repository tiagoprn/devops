
# IMPORTANT: Once a week, or every night, rebuild your Docker image
#            from scratch using `docker build --pull --no-cache`
#            to ensure you have security updates.

FROM python:3.7.3-stretch

RUN apt-get update \
 && apt-get -y install \
 build-essential apt-utils libssl-dev zlib1g-dev libbz2-dev \
 libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
 libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
 libpq-dev sudo tree -y

# Although ADD and COPY are functionally similar, COPY is preferred.
# It’s more transparent than ADD.
# COPY only supports the basic copying of local files into the container,
# while ADD has some features (like local-only tar extraction
# and remote URL support) that are not immediately obvious.

# Because image size matters, using ADD to fetch packages
# from remote URLs is strongly discouraged; you should use
# curl or wget instead. That way you can delete the files
# you no longer need after they’ve been extracted
# and you don’t have to add another layer in your image.
COPY requirements.txt /tmp/

RUN pip install -r /tmp/requirements.txt

# ARG variables are available only when building a container.
ARG UID
ARG GID

RUN echo "Container UID: $UID"
RUN echo "Container GID: $GID"

# You must user the same UID and GID here as the ones from
# the host user that will run this container, so that
# the container has the same permissions as the host user,
# avoiding security problems.
# -u: the user uid (that must match the host user uid)
# -g: group name (that must match the host user group)
# -l: for docker to not use all disk space due to a bug
RUN groupadd -r -g $GID appuser; useradd -l --create-home -u $UID -g $GID appuser
WORKDIR /home/appuser
USER appuser

COPY --chown=$UID:$GID . /home/appuser

EXPOSE 5000

RUN make init-env

ENTRYPOINT [ "make", "runserver" ]
