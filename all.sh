#!/bin/bash

set -euxo pipefail

for m in virt misc website acme; do
  bash "$m.sh"
done
