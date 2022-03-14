method=$1
i=0
valid=()
blank=()
code=0

if (($# < 2)); then
  echo "::error::Insufficient arguments passed to \"$0\"."
  exit 21
fi

if (($# % 2 != 1)); then
  echo "::error::Invalid number of arguments passed to \"$0\"."
  exit 21
fi

if [[ $method != every && $method != some ]]; then
  echo "::error::First argument to \"$0\" must be either \"every\" or \"some\"."
  exit 21
fi

shift

while (($#)); do
  ((i += 2))

  if [[ $1 == "" ]]; then
    echo "::error::Invalid argument passed to \"$0\" at position $i."
    exit 21
  fi

  if [[ $2 ]]; then
    valid+=("$1")
  else
    blank+=("$1")
  fi

  shift
  shift
done

if [[ $method == every ]]; then
  if ((${#blank[@]})); then
    echo "::error::Must specify all of: $(
      r=("${blank[@]:1}")
      printf "%s" "${blank[0]}" "${r[@]/#/", "}"
    )."
    exit 11
  fi
else
  if ((!${#valid[@]})); then
    echo "::error::Must specify at least one of: $(
      r=("${blank[@]:1}")
      printf "%s" "${blank[0]}" "${r[@]/#/", "}"
    )."
    exit 11
  fi
fi
