#!/bin/bash
acpi | sed 's/Battery [0-9+]: //'
