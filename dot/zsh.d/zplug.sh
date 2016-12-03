ls "$ZPLUG_HOME" > /dev/null 2>&1
if [ $? != 0 ]; then mkdir -p $ZPLUG_HOME/../; git clone https://github.com/zplug/zplug $ZPLUG_HOME; fi


source $ZPLUG_HOME/init.zsh

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'mollifier/anyframe'
zplug "b4b4r07/enhancd", use:init.sh
#zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"
zplug "b4b4r07/dotfiles", as:command, use:bin/peco-tmux
#zplug "motemen/ghq", as:command, from:gh-r, use:bin/ghq
#zplug "arks22/tmuximum", as:command
#zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf, use:"*amd64*"
#zplug "junegunn/fzf", as:command, use:bin/fzf-tmux



if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

