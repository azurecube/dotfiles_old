#Directory
function = {
  if [ $# -eq 0 ]; then
    dirs -lpv
  else
    pushd +${@}
  fi
}

function - {
  if [ $# -eq 0 ]; then
    pushd +1
  else 
    pushd +${@}
  fi
}

function + {
  if [ $# -eq 0 ]; then
    pushd -1
  else 
    pushd -${@}
  fi
}

#Virtualbox
function vbm {
  if [ $# -eq 0 ]; then
    VBoxManage list runningvms
  else
    VBoxManage $@
  fi
}

