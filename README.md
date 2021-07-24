Just a repository documenting the cheatsheet and environment settings

Clone this repository to download files

	git clone https://github.com/spencerimp/myenv.git ~/myenv

# vim
Compile vim with python support

```
#[OSX]
brew install vim --with-python3 --with-python2

#[Ubuntu]
sudo apt-get install build-essential libncurses5-dev libncursesw5-dev
sudo update-alternatives --config editor
git clone https://github.com/vim/vim
cd vim
./configure --enable-multibyte \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --enable-python3interp \
        --with-python3-config-dir=/Users/spencer/anaconda3/lib/python3.6/config-3.6m-darwin\
        --enable-cscope \
        --with-features=huge \

# change the prefix to local path such $HOME/.local/ if you do not have superuser privilege
make
sudo make install
```

In case of error

[No Terminal Library Found when Compiling Vim]
(http://askubuntu.com/questions/158344/no-terminal-library-found-when-compiling-vim)

```
sudo apt-get build-dep vim
```

To check whether python is supported

```
vim --version
```

Copy the .vimrc file

```
cp ~/myenv/.vimrc ~/.vimrc
```

Ininstall Vundle

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Open vim and type

```
:PluginInstall
```

You may need to use python2 to compile YouCompleteMe

Check the comments in ~/.vimrc for details

Copy the neovim config to load from .vimrc

```
mkdir ~/.config
cp -r nvim ~/.config
```

# Atom

To export the list

```
apm list --installed --bare > atom_packages.txt
```

To install from the list

```
apm install --packages-file atom_packages.txt
```


# VS Code extensions

To export the list

(macOS) Open VC code, CMD + P -> Install code command in Path

```
code --list-extensions > vscode-extensions.txt
```

To install from the list
```
cat vscode-extensions.txt | xargs -L 1 code --install-extension
```

# Anaconda and Python3
Install the lastest Anaconda

[https://www.continuum.io/downloads](https://www.continuum.io/downloads)

	conda update conda
	conda update anaconda
	conda install -c anaconda cmake=3.3.1
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


Create a new environment for Python 2

	conda create -n pyenv2 python=2.7
	# to activate
	source activate pyenv2
	# to deactivate
	source deactivate

Export the Anaconda environment

    # the Anaconda-specific and pip-specific packages are under different sections
    conda env export > environment.yml

Import an Anaconda environment

	conda create -f environment.yml

# Install Python 3 without Anaconda
        sudo apt-get install python3-setuptools
        sudo easy_install3 pip

# Atom

Install JDK and set JAVA_HOME environment variable

```
apm install --packages-file atom_packages.txt
```

To export the packges

```
apm list --installed --bare > atom_packages.txt
```

# zsh

Install zsh
[https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp ~/myenv/.zshrc ~/


# Ubuntu

Copy the custom desktop files in order to launch under Show Applications GUI


```
cp ubuntu/*desktop ~/.local/share/applications
```


