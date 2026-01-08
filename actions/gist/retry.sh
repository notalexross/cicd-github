initial_delay=1
max_delay=10

while (( $# > 0 )); do
  case "$1" in
    --max-attempts)
      max_attempts="$2"
      shift 2
      ;;
    *)
      break
      ;;
  esac
done

max_attempts=${max_attempts:-2}
command=$@

try() {
  $command
  if (( $? == 0 )); then
    echo command succeeded in $((max_attempts - $1 + 1)) attempt\(s\)
    return 0
  else
    if (( $1 > 1 )); then
      sleep $2
      try $(($1 - 1)) $(($2 * 2 > max_delay ? max_delay : $2 * 2))
    else
      echo command failing after $max_attempts attempt\(s\)
      return 1
    fi
  fi
}

try $max_attempts $initial_delay
