PACKAGE_MANAGER := $(shell ./detect_package_manager.sh)

# Check if PACKAGE_MANAGER is empty
ifeq ($(strip $(PACKAGE_MANAGER)),)
$(error No supported package manager detected)
endif

# Set PACKAGE_MANAGER_COMMAND based on the detected package manager
ifeq ($(PACKAGE_MANAGER),brew)
PACKAGE_MANAGER_COMMAND=$(PACKAGE_MANAGER) install
else
PACKAGE_MANAGER_COMMAND=sudo $(PACKAGE_MANAGER) install
endif

GENERAL_PACKAGES=tree git vim fish curl tmux wget htop
FISH_CONFIG_PATH=~/.config/fish/config.fish

# Try `make ~/.vimrc`, `make ~/.config/fish/config.fish`
~/%: files/%
	@if [ -e $@ ]; then \
		echo "$@ already exists"; \
	else \
		echo "Creating $@"; \
		mkdir -p $$(dirname $@); \
		cp $< $@; \
	fi

fish: $(FISH_CONFIG_PATH)
	$(PACKAGE_MANAGER_COMMAND) fish
	@# Fish shell as default
	@# On CentOS (and Amazon Linux), chsh is not available.
	@# Run: `sudo yum install util-linux-user` to get it.
	sudo chsh -s /usr/bin/fish "$$USER"

git:
	git config --global user.email "vaclav.volhejn@gmail.com"
	git config --global user.name "Václav Volhejn"
	git config --global core.editor "vim"
	git config --global pull.rebase false
	git config --global push.autoSetupRemote true

vim: ~/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	curl -fLo ~/.vim/colors/monokai.vim --create-dirs \
		https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim	

general: git rg fd
	$(PACKAGE_MANAGER_COMMAND) $(GENERAL_PACKAGES)

rg: # ripgrep
	curl -L -o rg.tar.gz https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz
	tar xzf rg.tar.gz
	rm rg.tar.gz
	mkdir -p ~/.local/bin
	cp ripgrep-14.1.1-x86_64-unknown-linux-musl/rg ~/.local/bin/rg
	rm -r ripgrep-14.1.1-x86_64-unknown-linux-musl
	@echo 'rg should now be available if ~/.local/bin/ is in $$PATH'


fd: # fd-find
	curl -L -o fd.tar.gz https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-gnu.tar.gz
	tar xzf fd.tar.gz
	rm fd.tar.gz
	cp fd-v10.2.0-x86_64-unknown-linux-gnu/fd ~/.local/bin/fd
	rm -r fd-v10.2.0-x86_64-unknown-linux-gnu
	@echo 'fd should now be available if ~/.local/bin/ is in $$PATH'

poetry:
	@# https://python-poetry.org/docs/#installing-with-the-official-installer
	curl -sSL https://install.python-poetry.org | python3 -

# Not needed on Mac. Homebrew installs pip under `pip3`.
# Very likely it'll be installed as a transitive dependency of some other package.
pip:
	@# From https://pip.pypa.io/en/stable/installing/
	curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
	sudo python3 /tmp/get-pip.py

miniconda:
	curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh
	bash /tmp/miniconda.sh
	@# Automatically activate conda in fish
	bash -c "conda init fish"
