#! /usr/bin/awk -f

BEGIN { FS="," }
NR==1{next}
{ gemid[$2]+=$3; aantal[$2]++}
END {
  for (s in gemid)
    printf "%4f\t%s\n", (gemid[s] / aantal[s]), s;
}
