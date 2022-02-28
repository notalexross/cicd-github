num_skipped=$((NUM_TOTAL - NUM_PASSED - NUM_FAILED))
colors=($COLORS)
formats=(
  "$PASSED_LABEL %d%.s%.s"
  "$FAILED_LABEL %.s%d%.s"
  "$SKIPPED_LABEL %.s%.s%d"
  "$PASSED_LABEL %d$LABEL_SEPARATOR$FAILED_LABEL %d%.s"
  "$PASSED_LABEL %d$LABEL_SEPARATOR$SKIPPED_LABEL %.s%d"
  "$FAILED_LABEL %.s%d$LABEL_SEPARATOR$SKIPPED_LABEL %d"
  "$PASSED_LABEL %d$LABEL_SEPARATOR$FAILED_LABEL %d$LABEL_SEPARATOR$SKIPPED_LABEL %d"
  "$PASSED_LABEL 0"
)

if (($NUM_PASSED)); then
  if (($NUM_FAILED)); then
    if (($num_skipped)); then
      format_index=6
    else
      format_index=3
    fi
  else
    if (($num_skipped)); then
      format_index=4
    else
      format_index=0
    fi
  fi
else
  if (($NUM_FAILED)); then
    if (($num_skipped)); then
      format_index=5
    else
      format_index=1
    fi
  else
    if (($num_skipped)); then
      format_index=2
    else
      format_index=7
    fi
  fi
fi

if (($NUM_FAILED)); then
  color_index=0
else
  color_index=-1
fi

message=$(printf "${formats[format_index]}" $NUM_PASSED $NUM_FAILED $num_skipped)
color=${colors[$color_index]}

echo "::set-output name=message::$message"
echo "::set-output name=color::$color"
