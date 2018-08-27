#!/bin/bash
acpi | sed 's/Battery [0-9+]: //' | sed ':a;N;$!ba;s/\n/\. /g'
