function icat_tile
  if not test -d $argv[1]
    echo "Usage: icat_tile <folder>"
    return 1
  end

  set -l folder $argv[1]
  set -l images (find $folder -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | sort)
  set -l count (count $images)

  if test $count -eq 0
    echo "No images found in $folder"
    return 1
  end

  set -l cols (tput cols)
  set -l rows (tput lines)

  set -l tile_cols (math "ceil(sqrt($count))")
  set -l tile_rows (math "ceil(($count + $tile_cols - 1) / $tile_cols)")

  set -l tile_width (math "floor($cols / $tile_cols)")
  set -l tile_height (math "floor($rows / $tile_rows)")

  for i in (seq 1 $count)
    set -l idx (math "$i - 1")
    set -l x (math "($idx % $tile_cols) * $tile_width")
    set -l y (math "($idx / $tile_cols) * $tile_height")

    kitty +kitten icat --place "$tile_width"x"$tile_height"@"$x"x"$y" $images[$i]
  end
end
