colors=($COLORS)
message=$([[ $STATUS == 'success' ]] && echo 'passing' || echo 'failing')
index=$([[ $STATUS == 'success' ]] && echo -1 || echo 0)
color=${colors[$index]}

echo "::set-output name=message::$message"
echo "::set-output name=color::$color"
