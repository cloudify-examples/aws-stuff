#!/bin/bash -xe

PUBLIC_IP=$1
PRIVATE_IP=$2
USERNAME=$3
LARGEVM=$4
MEDIUMVM=$5
SMALLVM=$6
TRUSTY_IMG_PUB=$7
TRUSTY_IMG_OFF=$8
TRUSTY_IMG_SKU=$9
TRUSTY_IMG_VER=$10
CENTOS_IMG_PUB=$11
CENTOS_IMG_OFF=$12
CENTOS_IMG_SKU=$13
CENTOS_IMG_VER=$14
SUBNET=$15
VIRTUAL_NETWORK=$16
RESOURCE_GROUP=$17
LOCATION=$18
PLUGINS_LIST="https://github.com/cloudify-incubator/cloudify-utilities-plugin/releases/download/1.3.0/cloudify_utilities_plugin-1.3.0-py27-none-linux_x86_64-centos-Core.wgn https://github.com/cloudify-incubator/cloudify-utilities-plugin/releases/download/1.2.5/cloudify_utilities_plugin-1.2.5-py27-none-linux_x86_64-centos-Core.wgn https://github.com/cloudify-incubator/cloudify-kubernetes-plugin/releases/download/1.2.0/cloudify_kubernetes_plugin-1.2.0-py27-none-linux_x86_64-centos-Core.wgn http://repository.cloudifysource.org/cloudify/wagons/cloudify-diamond-plugin/1.3.5/cloudify_diamond_plugin-1.3.5-py27-none-linux_x86_64-centos-Core.wgn http://repository.cloudifysource.org/cloudify/wagons/cloudify-diamond-plugin/1.3.5/cloudify_diamond_plugin-1.3.5-py27-none-linux_x86_64-Ubuntu-trusty.wgn http://repository.cloudifysource.org/cloudify/wagons/cloudify-fabric-plugin/1.5/cloudify_fabric_plugin-1.5-py27-none-linux_x86_64-centos-Core.wgn http://repository.cloudifysource.org/cloudify/wagons/cloudify-aws-plugin/1.5/cloudify_aws_plugin-1.5-py27-none-linux_x86_64-centos-Core.wgn http://repository.cloudifysource.org/cloudify/wagons/cloudify-aws-plugin/1.4.13/cloudify_aws_plugin-1.4.13-py27-none-linux_x86_64-centos-Core.wgn https://github.com/cloudify-incubator/cloudify-awssdk-plugin/releases/download/1.0.0/cloudify_awssdk_plugin-1.0.0-py27-none-any-none-none.wgn https://github.com/cloudify-cosmo/cloudify-openstack-plugin/releases/download/2.2.0/cloudify_openstack_plugin-2.2.0-py27-none-linux_x86_64-centos-Core.wgn https://github.com/cloudify-incubator/cloudify-azure-plugin/releases/download/1.4.3/cloudify_azure_plugin-1.4.3-py27-none-linux_x86_64.wgn"

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

run_until_success "id -u $USERNAME"

ssh-keygen -f /home/$USERNAME/.ssh/key.pem -t rsa -N ''
cat /home/$USERNAME/.ssh/key.pem.pub >> /home/$USERNAME/.ssh/authorized_keys
sudo rpm -i http://repository.cloudifysource.org/cloudify/4.1.0/ga-release/cloudify-enterprise-cli-4.1.rpm
sleep 1

cfy bootstrap /opt/cfy/cloudify-manager-blueprints/simple-manager-blueprint.yaml -i public_ip=$PUBLIC_IP -i private_ip=$PRIVATE_IP -i ssh_user=cfyuser -i ssh_key_filename=/home/cfyuser/.ssh/key.pem -i ignore_bootstrap_validations=false -i admin_username=admin -i admin_password=admin

run_until_success "cfy profiles use -u admin -p admin -t default_tenant $PUBLIC_IP",
run_until_success "cfy status"

#sleep 15
#
#run_until_success "cfy secrets create large_image_size -s $LARGEVM"
#run_until_success "cfy secrets create medium_image_size -s $MEDIUMVM"
#run_until_success "cfy secrets create small_image_size -s $SMALLVM"
#run_until_success "cfy secrets create ubuntu_trusty_image_publisher -s $TRUSTY_IMG_PUB"
#run_until_success "cfy secrets create ubuntu_trusty_image_offer -s $TRUSTY_IMG_OFF"
#run_until_success "cfy secrets create ubuntu_trusty_image_sku -s $TRUSTY_IMG_SKU"
#run_until_success "cfy secrets create ubuntu_trusty_image_version -s $TRUSTY_IMG_VER"
#run_until_success "cfy secrets create centos_core_image_publisher -s $CENTOS_IMG_PUB"
#run_until_success "cfy secrets create centos_core_image_offer -s $CENTOS_IMG_OFF"
#run_until_success "cfy secrets create centos_core_image_sku -s $CENTOS_IMG_SKU"
#run_until_success "cfy secrets create centos_core_image_version -s $CENTOS_IMG_VER"
#run_until_success "cfy secrets create mgr_subnet_name -s $SUBNET"
#run_until_success "cfy secrets create mgr_virtual_network_name -s $VIRTUAL_NETWORK"
#run_until_success "cfy secrets create mgr_resource_group_name -s $RESOURCE_GROUP"
#run_until_success "cfy secrets create location -s $LOCATION"
#
#for i in $PLUGINS_LIST;
#    do run_until_success "cfy plugins upload $i";
#    sleep 3;
#done
#
#run_until_success "cfy install https://github.com/cloudify-incubator/cloudify-utilities-plugin/archive/1.3.0.zip -n cloudify_ssh_key/examples/create-secret-agent-key.yaml -b agent_key"
