DOT_FILES=ackrc emacs gdbinit gemrc ghci gitconfig gitignore hgignore hgrc\
	  screenrc tmux.conf vimrc zshrc

all: install

install: $(foreach f, $(DOT_FILES), install-file-$(f))

install-file-%: %
	@echo "ln -snf $< to $(HOME)/.$<"
	@ln -snf $(CURDIR)/$< $(HOME)/.$<
