#!/bin/bash
${file("${path.module}/install_jenkins.sh")}
cat <<EOF > /etc/cloud/cloud.cfg.d/99_runcmd.cfg
#cloud-config
runcmd:
  - [ bash, -c, "sleep 60; ansible-playbook /etc/ansible/volume/mount-ebs.yml" ]
EOF