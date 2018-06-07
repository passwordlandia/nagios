#!/bin/bash

/Users/passwordlandia/nagios/scp/generate_config.sh $1 $2

gcloud compute scp ~/$1.cfg \nagios-a:/etc/nagios/conf.d --ssh-key-file=/Users/paulierev1775/ .ssh/google_compute_engine --zone us-east1-b
usermod -a -G nagios paulierev1775
chmod 770 /etc/nagios/conf.d

gcloud compute ssh paulierev1775@nagios-a "sudo /usr/sbin/nagios -v /etc/nagios/nagios.cfg"
