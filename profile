# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Unbreak broken, non-colored terminal
export TERM='xterm-color'
export GREP_OPTIONS="--color"

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

export P4PORT=descode:1666
export P4USER=henrik.wist
export P4CONFIG=.p4config
export TRELLO_BOARD=510a3902bce28e4a38002089
export TRELLO_KEY=c9c2eca40e4825d997632bc70dd18857
export TRELLO_TOKEN=dab6de31d35f2bab7478d5af11a883168cab26b8528c2352cd0db36b53003d05
export TRELLO_CARD=510a487bdf52f3cd0c001075
