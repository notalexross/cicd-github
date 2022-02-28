colors=($COLORS)
message=$(awk "BEGIN { print int($COVERAGE)\"%\" }")
index=$(awk "BEGIN {
  print int($COVERAGE < $MIN_COVERAGE ? 0 : ($COVERAGE - $MIN_COVERAGE) * (${#colors[@]} - 2) / (100 - $MIN_COVERAGE) + 1)
}")
color=${colors[index]}

echo "::set-output name=message::$message"
echo "::set-output name=color::$color"
