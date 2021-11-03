#!/usr/bin/env bash

# code snippet by https://github.com/rockyshimithy

current_coverage=$(cat COVERAGE)
new_coverage=$(cat xmlcov/coverage.xml | sed -rn 's/.*coverage.*line-rate="([^"]*)".*/\1/p')

echo "Current coverage: $current_coverage"
echo "New coverage: $new_coverage"

evaluation=$(python -c "print($new_coverage >= $current_coverage)")
if [ $evaluation == "True" ]; then
    echo "Success during the test coverage";
else
    echo "The coverage needs be greater or equal than the current coverage"
    exit 1
fi
