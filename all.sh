#!/bin/bash

set -euxo pipefail

for m in virt misc; do
  bash "$m.sh"
done
