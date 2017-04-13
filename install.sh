#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc zshrc tmux.conf"    # list of files/folders to symlink in homedir

##########

# install oh-my-zsh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
	fullfile=~/.$file
	if [ -e $fullfile ]; then
		echo "Moving $fullfile..."
		mv $fullfile ~/dotfiles_old/
	fi

	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done

# init localzshrc
touch $dir/localzshrc

git config --global color.ui true
