package_manager=sudo apt install
general_packages=tree git vim fish curl

vimrc:
ifeq (,$(wildcard ~/.vimrc))
	cp files/.vimrc ~/.vimrc
else
	@echo "~/.vimrc already exists"
endif

general:
	$(package_manager) $(general_packages)
	@# Ripgrep
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
	sudo dpkg -i ripgrep_11.0.2_amd64.deb
	rm ripgrep_11.0.2_amd64.deb
	@# Fish shell as default
	chsh -s /usr/bin/fish
