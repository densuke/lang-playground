#!/usr/bin/env bash
cd "$(dirname "$0")"
./run.sh bash -c "$(cat ./inner-run.sh)"
