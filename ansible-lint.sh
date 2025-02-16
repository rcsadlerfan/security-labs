#!/bin/bash
for f in *; do
    if [[ "$f" == "*.ansible.yml" ]]; then
        echo "Checking file $f"
        ansible-lint $f
    fi
done