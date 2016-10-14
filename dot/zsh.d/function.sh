#SSH
function ssh-agentup {
  keys="$@ $(ls ~/.ssh/id_* | grep -Pv '.pub$')"
  ssh-add $(echo $keys)
}

#TaskWarrior
function tasknote {
  if [ $# -lt 1 ]; then echo no task id; return -1; fi
  FOLDER=~/.tasknote
  UUID=$(task information ${1} | awk '($1 ~ /^UUID/){print $2}')
  FILE="${UUID}.txt"

  ls ${FOLDER}/${FILE} || new=1
  ${EDITOR} ${FOLDER}/${FILE}

  if [ "$new" == "1" ]; then
    ls ${FOLDER}/${FILE} && task ${1} append '[n]'
  fi
}
