#!/usr/bin/env bash
set -euo pipefail

# AWS Region set to us-east-1
: "${AWS_DEFAULT_REGION:=us-east-1}"

# Timestamped report inside /output
ts="$(date -u +"%Y%m%dT%H%M%SZ")"
outdir="/output/scoutsuite-${ts}"

mkdir -p "${outdir}"

# Run Scout Suite for AWS and write static report to ${outdir}
scout aws --report-dir "${outdir}" "$@"

# Pass through any extra args provided to the container.
echo "Scoutsuite report: ${outdir}"