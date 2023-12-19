PACKAGE_MANAGER=sudo apt install
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
	$(PACKAGE_MANAGER) fish
	@# Fish shell as default
	sudo chsh -s /usr/bin/fish "$$USER"

git:
	git config --global user.email "vaclav.volhejn@gmail.com"
	git config --global user.name "Václav Volhejn"
	git config --global core.editor "vim"
	git config --global pull.rebase false

vim: ~/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	curl -fLo ~/.vim/colors/monokai.vim --create-dirs \
		https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim	

general: git
	$(package_manager) $(general_packages)
	@# Ripgrep
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
	sudo dpkg -i ripgrep_11.0.2_amd64.deb
	rm ripgrep_11.0.2_amd64.deb

poetry:
	@# https://python-poetry.org/docs/#installing-with-the-official-installer
	curl -sSL https://install.python-poetry.org | python3 -

pip:
	@# From https://pip.pypa.io/en/stable/installing/
	curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
	sudo python3 /tmp/get-pip.py

miniconda:
	curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh
	bash /tmp/miniconda.sh
	@# Automatically activate conda in fish
	bash -c "conda init fish"