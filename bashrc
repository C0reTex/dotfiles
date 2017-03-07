#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# cat /etc/Tux.txt

source /usr/share/git/completion/git-completion.bash

if [ -f ~/.vim/powerline/powerline/bindings/bash/powerline.sh ]; then
    source  ~/.vim/powerline/powerline/bindings/bash/powerline.sh
fi

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
       eval `$SSHAGENT $SSHAGENTARGS`
       trap "kill $SSH_AGENT_PID" 0
fi

export PATH=/tmp/yaourt-tmp-doctor/aur-sencha-cmd-5/src/sencha-cmd-5-5.1.3/Sencha/Cmd/5.1.3.61:$PATH

export SENCHA_CMD_3_0_0="/tmp/yaourt-tmp-doctor/aur-sencha-cmd-5/src/sencha-cmd-5-5.1.3/Sencha/Cmd/5.1.3.61"
