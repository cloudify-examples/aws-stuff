#!/bin/bash -xe

PUBLIC_IP=$1

function run_until_success {
    COUNTER=0
    while true; do
        sleep 3
        eval $1
        if [ $? -eq 0 ] || [ $COUNTER -eq 10 ]; then
            return $?
        fi
        let COUNTER=COUNTER+1
    done
}

ssh-keygen -f /home/cfyuser/.ssh/key.pem -t rsa -N ''
cat /home/cfyuser/.ssh/key.pem.pub >> /home/cfyuser/.ssh/authorized_keys
sudo rpm -i http://repository.cloudifysource.org/cloudify/4.1.0/ga-release/cloudify-enterprise-cli-4.1.rpm
sleep 1

cfy bootstrap /opt/cfy/cloudify-manager-blueprints/simple-manager-blueprint.yaml -i public_ip=$PUBLIC_IP -i ssh_user=cfyuser -i ssh_key_filename=/home/cfyuser/.ssh/key.pem -i ignore_bootstrap_validations=false -i admin_username=admin -i admin_password=admin

until cfy status;
    do sleep 3;
done
sleep 15

run_until_success "cfy profiles use -u admin -p admin -t default_tenant $PUBLIC_IP",
#run_until_success "cfy secrets create ubuntu_trusty_image -s $UBUNTU_TRUSTY_IMAGE"
#run_until_success "cfy secrets create centos_core_image -s $CENTOS_CORE_IMAGE"
#run_until_success "cfy secrets create ubuntu_trusty_image -s $UBUNTU_TRUSTY_IMAGE"
#
#for i in $PLUGINS_LIST;
#    do run_until_success "cfy plugins upload $i";
#    sleep 3;
#done
#
#run_until_success "cfy install https://github.com/cloudify-incubator/cloudify-utilities-plugin/archive/1.3.0.zip -n cloudify_ssh_key/examples/create-secret-agent-key.yaml -b agent_key"
