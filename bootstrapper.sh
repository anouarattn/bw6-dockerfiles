#!/bin/bash



/bin/bash -c "cd /opt/tibco/bw/6.5/bin && ./bwadmin mode enterprise"
sed -i 's/.*${TIBCO_HOME}\/ems.*//g' /opt/tibco/bw/6.5/scripts/bashrc.sh
sed -i 's/.*EMS_HOME=.*//g' /opt/tibco/bw/6.5/scripts/bashrc.sh
sed -i 's/.*{TIBCO_HOME}\/tea.*//g' /opt/tibco/bw/6.5/scripts/bashrc.sh
sed -i 's/.*TEA_HOME=.*/export TEA_HOME=\/opt\/tibco\/tea\/2.3/g' /opt/tibco/bw/6.5/scripts/bashrc.sh
. /opt/tibco/bw/6.5/scripts/bashrc.sh
/opt/tibco/bw/6.5/scripts/admin/genbwagentini.sh
sed -in '/\#statsprovider/q;p' /opt/tibco/bw/6.5/config/bwagent.ini
/opt/tibco/bw/6.5/scripts/admin/bwagent.sh
/opt/tibco/bw/6.5/scripts/admin/tea.sh
/opt/tibco/bw/6.5/scripts/admin/registeragent.sh 
/bin/bash