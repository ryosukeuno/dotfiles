DOT_FILES=ackrc conkyrc emacs gdbinit gemrc ghci gitconfig gitignore hgignore\
	  hgrc pryrc screenrc tmux.conf vimrc zshrc

all: install

install: $(foreach f, $(DOT_FILES), install-file-$(f))

install-file-%: %
	@echo "ln -snf $< to $(HOME)/.$<"
	@ln -snf $(CURDIR)/$< $(HOME)/.$<
