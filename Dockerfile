FROM alpine:latest

ARG ANSIBLE_RELEASE

RUN apk add --no-cache \
   curl \
   python3 \
   py3-pip \
   py3-jinja2 \
   py3-yaml \
   py3-crypto \
   openssh-client \
   bash \
   tar \
   && apk add --no-cache --virtual .build-deps \
     curl \
     tar \
   && pip3 install --upgrade pip \
   && ln /usr/bin/python3 /usr/bin/python \
   && mkdir /etc/ansible /ansible ~/.ssh

# # Overrides SSH Hosts Checkinddg
# RUN echo "host *" >> ~/.ssh/config \
#     && echo "StrictHostKeyChecking no" >> ~/.ssh/config

RUN curl -fsSL https://github.com/ansible/ansible/archive/refs/tags/${ANSIBLE_RELEASE}.tar.gz -o ansible.tar.gz \
  && tar -xzf ansible.tar.gz -C ansible --strip-components 1 \
  && rm -fr ansible.tar.gz /ansible/docs /ansible/examples /ansible/packaging \
  && apk del .build-deps \
  && mkdir -p /ansible/playbooks

WORKDIR /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING False
ENV ANSIBLE_RETRY_FILES_ENABLED False
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

