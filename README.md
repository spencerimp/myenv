Working environment settings

Clone this repository to download files

	git clone https://github.com/spencerimp/myenv.git ~/

# vim
Compile vim with python support
	
	#[OSX]
	brew install vim --with-python3 --with-python2 

To check whether python is supported

	vim --version

Install [Vundle](https://github.com/VundleVim/Vundle.vim) to handle the vim plugins

	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Copy the .vimrc file

	cp ~/myenv/.vimrc ~/.vimrc

Install the plugins in vim
open vim and type

	:PluginInstall

Copy the indepentent configuration for python files

	mkdir ~/.vim/ftplugin
	cp ~/myenv/ftplugin/python.vim ~/.vim/ftplugin/python.vim