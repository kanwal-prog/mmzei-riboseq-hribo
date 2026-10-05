#!/usr/bin/env bash
# Download the M. mazei Go1 Ribo-seq / RNA-seq dataset (GSE240615, SRP454525)
# from the ENA FTP mirror and rename to HRIBO sample names.
#
#   ./05_download_mmazei.sh [OUTDIR]      # default OUTDIR = ./fastq
#
# ~4.9 GB total. Re-runnable: verified files are skipped.

set -euo pipefail

# accession | sample name | md5
SAMPLES=(
  "SRR25604697 RIBO-MINUSN-1 1e961cc4b1e4512f03fcfb69e0522d4a"
  "SRR25604696 RIBO-MINUSN-2 bfac931015801e4f55b615a0e91d82c2"
  "SRR25604695 RNA-MINUSN-1  a87cad4f2d54ef2c9d2a83152f9251d8"
  "SRR25604694 RNA-MINUSN-2  b4917b5190d9451b4db47ed08f86e2b4"
  "SRR25604693 RIBO-PLUSN-1  81991ee388b3ba2e375ae3e12a60e6fa"
  "SRR25604692 RIBO-PLUSN-2  9c2090ad6cad40d45553c8dc1765afb3"
  "SRR25604691 RNA-PLUSN-1   cd2801a6219cf471c82d0cf119e6439c"
  "SRR25604690 RNA-PLUSN-2   61448e78f8de1e680774aef5308b9a5c"
)

OUTDIR="${1:-$(dirname "$0")/fastq}"
mkdir -p "$OUTDIR"

log() { printf '[%s] %s\n' "$(date +%H:%M:%S)" "$*"; }

# ENA FTP layout: vol1/fastq/<first6>/<0-padded last digits>/<acc>/<acc>.fastq.gz
ena_url() {
  local acc="$1" prefix="${1:0:6}" digits="${1:3}" sub=""
  case "${#digits}" in
    7) sub="00${digits: -1}/" ;;
    8) sub="0${digits: -2}/" ;;
    9) sub="${digits: -3}/" ;;
  esac
  printf 'ftp://ftp.sra.ebi.ac.uk/vol1/fastq/%s/%s%s/%s.fastq.gz' \
         "$prefix" "$sub" "$acc" "$acc"
}

failed=0
for entry in "${SAMPLES[@]}"; do
  read -r acc name md5 <<<"$entry"
  dest="${OUTDIR}/${name}.fastq.gz"

  if [[ -s "$dest" ]] && [[ "$(md5sum "$dest" | cut -d' ' -f1)" == "$md5" ]]; then
    log "OK (cached)  ${name}"
    continue
  fi

  url="$(ena_url "$acc")"
  log "GET ${acc} -> ${name}"
  wget --continue --tries=5 --waitretry=10 --timeout=60 \
       --progress=dot:giga -O "${dest}.part" "$url"

  got="$(md5sum "${dest}.part" | cut -d' ' -f1)"
  if [[ "$got" == "$md5" ]]; then
    mv -f "${dest}.part" "$dest"
    log "OK           ${name}  (md5 verified)"
  else
    log "FAILED       ${name}  expected ${md5} got ${got}"
    failed=$((failed + 1))
  fi
done

if (( failed )); then
  log "${failed} file(s) failed verification."
  exit 1
fi

log "All 8 libraries downloaded and verified:"
ls -lh "$OUTDIR"