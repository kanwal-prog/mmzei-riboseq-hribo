# Fixes applied to run HRIBO on this system

HRIBO v1.8.0's pinned tool environments were built years ago, and several
no longer solve or run cleanly against current conda channel contents. The
fixes below were required to complete the run. None change the pipeline's
scientific logic — they only replace a network fetch with a local file, or
add a missing shared library / R data package to an existing environment.

## 1. Rule edits (network dependencies replaced with local files)

**`HRIBO/rules/reparation.smk`** — the `uniprotDBRetrieve` rule originally
fetched Swiss-Prot over FTP (`storage.ftp("ftp://ftp.ebi.ac.uk/...")`), which
was intermittently unreachable ("too many connected users"). Fixed by
downloading `uniprot_sprot.fasta.gz` once with `wget` into the project root
and changing the rule's `input` to the local filename directly.

**`HRIBO/rules/deepribo.smk`** — the `deepriboGetModel` rule originally
fetched the pretrained model over HTTP
(`storage.http("https://github.com/.../DeepRibo_model_v1.pt?raw=true")`).
Fixed the same way: downloaded once, rule `input` changed to the local
filename, and `mv` changed to `cp` so the local copy is preserved for reruns.

## 2. Conda environment fixes (missing shared libraries / data packages)

These environments are built from old pinned package sets
(e.g. `r-base=3.5.1`, `python=3.7.12`) that no longer resolve or run
correctly with current system libraries. In each case the environment
itself is fine; one dependency was added after the fact with `mamba install
-p <env-path> ...`:

| Environment (rule) | Missing dependency | Symptom |
|---|---|---|
| `xtail`, `riborex` | `libgfortran=3.0.0` | `Rscript: error while loading shared libraries: libgfortran.so.3` |
| `reparation` | `libtiff<4.5` | `ImportError: libtiff.so.5: cannot open shared object file` (Pillow/matplotlib, used by reparation's plotting step) |
| `xtail` | `bioconductor-genomeinfodbdata` | conda reported it as installed, but the R data package's post-link install script failed silently when originally built; re-running the environment's own post-link script (with `$PREFIX` set manually) completed the install |

On a system where these environments are built fresh with a **recent**
conda/mamba and the default channel set, some of these mismatches may not
occur. They were specific to this system's package solver behavior and
channel configuration (a local `.condarc` with additional channels caused
some environments to fail to solve at all with plain `conda`; rebuilding
with `mamba env create --no-rc` — ignoring the local channel config —
resolved those cases).

## 3. Environment builder note

Plain `conda`'s classic solver repeatedly failed to terminate (multi-hour
hangs) on several of HRIBO's older pinned environments. These were instead
built directly with `mamba env create --no-rc -f <env>.yaml -p <path>`,
which solves the same environment files correctly in seconds. No environment
*specifications* were changed — only the tool used to build them.