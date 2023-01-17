#!/bin/bash
history | tr -s ' ' | cut -d ' ' -f3 | sort | uniq -c | sort -n -r | head


