# setup
Scripts for setting up a new workstation. Run `setup.sh` and then run `make [something]` for parts that you want to install.

The configuration is my personal preference and is not really designed for public use.

## LSF (`bsub`) and Python virtualenv

```
# Load the Python module that you want the virtualenv to use
module load python_gpu/3.8.5

python3 -m pip install virtualenv
python3 -m virtualenv venv

source venv/bin/activate
pip install tensorflow  # any packages


# -Ip runs "interactively", i.e. outputs directly to terminal
# Apparently you should run scripts using a redirection
bsub -R "rusage[ngpus_excl_p=1]" -Ip < ./test_gpu.sh
```

[Helper tool for `bsub` commands](https://scicomp.ethz.ch/lsf_submission_line_advisor/)
