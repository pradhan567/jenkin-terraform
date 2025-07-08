#!/bin/bash
# yum update -y
yum install -y cronie
yum install docker -y
systemctl start docker
systemctl enable docker
docker pull jenkins/jenkins:lts

######### Installing Ansible ##############
amazon-linux-extras enable ansible2
yum install -y ansible
mkdir /etc/ansible/volume
cat << 'EOF' > /etc/ansible/volume/mount-ebs.yml
---
- hosts: localhost
  become: yes
  tasks:
    - name: Create mount directory
      file:
        path: /data/jenkins
        state: directory
        mode: '0755'

    - name: Check if device is already formatted
      command: blkid /dev/xvdf
      register: blkid_output
      ignore_errors: yes

    - name: Format the EBS volume if not already formatted
      filesystem:
        fstype: ext4
        dev: /dev/xvdf
      when: blkid_output.rc != 0

    - name: Mount the EBS volume
      mount:
        path: /data/jenkins
        src: /dev/xvdf
        fstype: ext4
        state: mounted

    - name: Add volume to /etc/fstab
      mount:
        path: /data/jenkins
        src: /dev/xvdf
        fstype: ext4
        opts: defaults
        state: present

    - name: applying ownership to jenkins user
      file:
        path: /data/jenkins
        owner: 1000
        group: 1000
        state: directory

    - name: running jenkins container
      docker_container:
        name: jenkins
        image: jenkins/jenkins:lts
        state: started
        restart_policy: always
        ports:
          - "8080:8080"
          - "50000:50000"
        volumes:
          - /data/jenkins:/var/jenkins_home
EOF
