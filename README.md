Working environment settings

Clone this repository to download files

	git clone https://github.com/spencerimp/myenv.git ~/myenv

# vim
Compile vim with python support

	#[OSX]
	brew install vim --with-python3 --with-python2
    
    #[Ubuntu]
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp \
                --enable-python3interp \
                --with-python3-config-dir=/usr/lib/python3.5/config \
                --enable-gui=gtk2 --enable-cscope --prefix=/usr
    sudo make install
    
In case of error

[No Terminal Library Found when Compiling Vim]
    (http://askubuntu.com/questions/158344/no-terminal-library-found-when-compiling-vim)
    
To check whether python is supported

	vim --version

Install [Vundle](https://github.com/VundleVim/Vundle.vim) to handle the vim plugins

	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Copy the .vimrc file

	cp ~/myenv/.vimrc ~/.vimrc

Open vim and type

	:PluginInstall

Copy the independent configuration for python files

	mkdir ~/.vim/ftplugin
	cp ~/myenv/ftplugin/python.vim ~/.vim/ftplugin/python.vim

Check the comments in ~/.vimrc for details

# Anaconda and Python3
Install the lastest Anaconda

[https://www.continuum.io/downloads](https://www.continuum.io/downloads)

	conda update conda
	conda update anaconda
	conda install pip 
	conda install ipython
	conda install pip
	conda install scikit-learn
	conda install pandas
	conda install h5py
	conda install pydot-ng
	conda install openblas
	conda install -c menpo opencv3=3.1.0
	pip install Theano
	pip install scikit-image
	pip install flake8
	pip install pylint

Install Tensorflow following the guide on the official website

Create a separate environment for Python 2

	conda create -n pyenv2 python=2.7
	# to activate
	source activate pyenv2
	# to deactivate
	source deactivate
# zsh configuration
    cp ~/myenv/.zshrc ~/

