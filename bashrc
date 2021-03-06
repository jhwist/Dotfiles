source ~/.profile

if [ -f /etc/bash.bashrc ];
then
  source /etc/bash.bashrc
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/bin/p4-completion.bash ]; then
  source ~/bin/p4-completion.bash
fi
if [ -f ~/bin/git-completion.bash ]; then
  source ~/bin/git-completion.bash
fi

alias vi=vim
alias ls="ls --color"

function minutes_since_last_commit {
  now=`date +%s`
  last_commit=`git log --pretty=format:'%at' -1`
  seconds_since_last_commit=$((now-last_commit))
  minutes_since_last_commit=$((seconds_since_last_commit/60))
  echo $minutes_since_last_commit
}

git_prompt() {
  local g="$(__gitdir)"
  if [ -n "$g" ]; then
    local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
    if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
      local COLOR=${RED}
    elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
      local COLOR=${YELLOW}
    else
      local COLOR=${GREEN}
    fi
    local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${NORMAL}"
    # The __git_ps1 function inserts the current git branch where %s is
    local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
    echo ${GIT_PROMPT}
  fi
}
PS1="\u@\h:\W\$(git_prompt)\$ "
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
