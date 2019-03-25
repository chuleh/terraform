#!/bin/bash

#wait for the instance to be ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

# install nginx
apt-get update
apt-get install -y nginx

# start the service
service nginx start