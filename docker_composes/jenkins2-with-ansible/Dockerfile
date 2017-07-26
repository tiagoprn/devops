FROM jenkins:latest

ENV LAST_UPDATED_AT 20170725_1705

USER root

RUN apt-get update && apt-get install -y ansible && rm -rf /var/lib/apt/lists/*

USER jenkins

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

