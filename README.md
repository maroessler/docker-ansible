# docker-ansible

A simple image for running [Ansible](https://www.ansible.com/) in a Docker container. The image is built automatically and updated whenever there is a new tag in the [official repository](https://github.com/ansible).
Built images are available for amd64 and armv7, e.g. Raspberry Pi (except 1 and Zero).

## List of aliases for simpler commands

```
alias ansible='docker run -v "${PWD}":/work:ro --rm maroessler/ansible:latest ansible'
alias ansible-playbook='docker run -v "${PWD}":/work:ro -v ~/.ansible/roles:/root/.ansible/roles -v ~/.ssh:/root/.ssh:ro --rm maroessler/ansible:latest ansible-playbook'
alias ansible-vault='docker run -v "${PWD}":/work:ro --rm maroessler/ansible:latest ansible-vault'
```
