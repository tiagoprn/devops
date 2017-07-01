FROM williamyeh/ansible:centos7-onbuild

ENV LAST_UPDATED_AT 20170701_1216

RUN yum upgrade -y && \
    yum install openssh openssl openssh-clients -y &&\
    yum clean all -y

CMD ["ansible-playbook", "--version"]

