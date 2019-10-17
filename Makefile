PACKAGE_MANAGER=sudo apt install
GENERAL_PACKAGES=tree git vim fish curl
FISH_CONFIG_PATH=~/.config/fish/config.fish

# Try `make ~/.vimrc`, `make ~/.config/fish/config.fish`
~/%: files/%
	@if [ -e $@ ]; then \
		echo "$@ already exists"; \
	else \
		echo "Creating $@"; \
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

general: git
	$(package_manager) $(general_packages)
	@# Ripgrep
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
	sudo dpkg -i ripgrep_11.0.2_amd64.deb
	rm ripgrep_11.0.2_amd64.deb

