#Directory
setopt auto_cd
setopt chase_dots
setopt chase_links
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

#Prompt
setopt transient_rprompt

#History
#setopt hist_verify

#Completion
setopt list_packed

#cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
