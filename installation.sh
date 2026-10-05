#!/usr/bin/env bash
# Install HRIBO 1.8.0 and set up a project directory.
set -euo pipefail

PROJECT="${1:-project}"
mkdir -p "$PROJECT"
cd "$PROJECT"
PROJECT_DIR="$PWD"

# --- 1. HRIBO source ---------------------------------------------------------
HRIBO_VERSION="1.8.0"
wget -c "https://github.com/RickGelhausen/HRIBO/archive/${HRIBO_VERSION}.tar.gz"
tar -xzf "${HRIBO_VERSION}.tar.gz"
mv "HRIBO-${HRIBO_VERSION}" HRIBO
rm "${HRIBO_VERSION}.tar.gz"

# --- 2. Snakemake environment ------------------------------------------------
# Creates an env named per HRIBO/environment.yaml (commonly "snakemake").

cd ~/Desktop/HRIBO
mamba env create -n hribo -f HRIBO/environment.yaml

# --- 3. Templates ------------------------------------------------------------
cp HRIBO/templates/samples.tsv HRIBO/
cp HRIBO/templates/config.yaml HRIBO/

mkdir -p fastq
echo "HRIBO ${HRIBO_VERSION} installed in ${PROJECT_DIR}"
echo "Next: add reference genome/annotation, edit HRIBO/samples.tsv and HRIBO/config.yaml"

## Tracking progress 
tail -n 5 ~/Desktop/HRIBO/hribo_run.log
grep -E "steps \(" ~/Desktop/HRIBO/hribo_run.log | tail -1
df -h / | tail -1