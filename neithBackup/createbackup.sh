#!/bin/bash
PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
    echo "Initialising new SSH agent..."
    (umask 066; /usr/bin/ssh-agent > "${SSH_ENV}")
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
ssh-add '.ssh/rsyncsshkey'
goodbye () {
	if [ -n "$SSH_AUTH_SOCK" ]; then
	  eval `/usr/bin/ssh-agent -k`
	fi
}
trap goodbye EXIT
echo 'Starting backup from Neith'
echo -e $(/bin/date +%Y.%m.%d) >> '/neithlog.txt'
rsync -aAzxP --delete-excluded --timeout=30 --backup -e "ssh -p 00000" "EDIT@EDIT:/backups" "/$(/bin/date +%Y.%m.%d)" >> '/neithlog.txt'
echo 'Backup finished'
