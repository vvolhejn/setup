# setup
Scripts for setting up a new workstation. Run `setup.sh` and then run `make [something]` for parts that you want to install.

The configuration is my personal preference and is not really designed for public use.

## Setting up a Mac

After installing Brew, you can install fish shell via `fish install brew`.
But then the `brew` command doesn't work within the shell, which you can fix by adding the following to `config.fish`: ([link](https://github.com/orgs/Homebrew/discussions/4412#discussioncomment-7348762)):
```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

iTerm2 settings can be imported from another computer, I don't think there is an account to automatically sync the settings. You just need to export them in advance.

To install the `code` CLI command, run the "Shell Command: Install 'code' command in PATH" action from VSCode.

Python seems to get installed automatically in Brew as a transitive dependency of other packages.
It only installs `python3` and `pip3` executables. To get `python` and `pip`, you can do
`fish_add_path /opt/homebrew/opt/python/libexec/bin` ([source](https://stackoverflow.com/questions/49704364/make-python3-as-my-default-python-on-mac)).

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
