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

Open vim and type

	:PluginInstall

Copy the indepentent configuration for python files

	mkdir ~/.vim/ftplugin
	cp ~/myenv/ftplugin/python.vim ~/.vim/ftplugin/python.vim
	
# Anaconda and Python3
Install the lastest Anaconda

[https://www.continuum.io/downloads]()

	conda install ipython
	conda install pip
	conda scikit-learn
	conda install pandas
	conda install h5py
	conda install pydot-ng
	conda install -c conda-forge tensorflow
	conda install -c menpo opencv3=3.1.0
	pip install Theano
	
Create a separate environment for Python 2
	
	conda create -n pyenv2 python=2.7
	# to activate
	# source activate pyenv2
	# to deactivate
	# deactivate