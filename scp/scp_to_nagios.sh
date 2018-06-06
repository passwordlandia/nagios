#!/bin/bash

###prior to running this command I need to have my server already written in my gcloud init file,###
###and add it in to there. I also need to define my IP's better.####

/Users/pippy/generate_config.sh $1 $2

gcloud compute copy-files $1.cfg paulierev1775@:nagios-scp-server/etc/nagios/conf.d

usermod -a -G nagios paulierev1775
chmod 770 /etc/nagios/conf.d

gcloud compute ssh paulierev1775@nagios-scp-server "sudo /usr/sbin/nagios -v /etc/nagios/nagios.cfg"
