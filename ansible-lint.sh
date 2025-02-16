#!/bin/bash
for f in *; do
    if [[ "$f" == "*.ansible.yml" ]]; then
        ansible-lint $f
    fi
done