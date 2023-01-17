#! /usr/bin/awk -f

BEGIN { FS="," }
{
  for (i=3;i<=NF; i++) {
    a[i]+=$i
    if($i!="")
      b[i]++}
  }
END {
  for(i=3; i<=NF; i++)
    printf "%s%s", a[i]/b[i], (i==NF?ORS:OFS)
}
