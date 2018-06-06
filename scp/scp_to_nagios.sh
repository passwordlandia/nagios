#!/bin/bash



/Users/pippy/generate_config.sh $1 $2

gcloud compute copy-files $1.cfg nicolebade@nagios-b:/etc/nagios/conf.d

# Note: I had to add user nicolebade to group nagios using usermod -a -G nagios nicolebade
# I also had to chmod 770 /etc/nagios/conf.d

gcloud compute ssh nicolebade@nagios-b "sudo /usr/sbin/nagios -v /etc/nagios/nagios.cfg"
