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
(in vscode Command Palette, cmd+shift+p) shell command to find Shell Command: Install 'code' command in PATH command
cat vscode-extensions.txt | xargs -L 1 code --install-extension
```

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


```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ~/myenv/.zshrc ~/

```

# Powerline

Make the ZSH status code better

https://caffeinedev.medium.com/customize-your-terminal-oh-my-zsh-on-ubuntu-18-04-lts-a9b11b63f2

```
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

Add these line to .zshrc

```
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
```

# Font

Install SourceCodePro font and set it for terminal and vim

https://askubuntu.com/questions/193072/how-to-use-the-adobe-source-code-pro-font

Basically, download the font from [Google Fonts](https://www.google.com/fonts)

extract under **~/.local/share/fonts**

```
mkdir -p ~/.local/share/fonts
unzip SourceCodePro.zip ~/.local/share/fonts
fc-cache -f
```

Note that in .vimrc you will need to use space with escape char such as

```
set gfn=Source\ Code\ Pro:h14
```

# Ubuntu

Copy the custom desktop files in order to launch under Show Applications GUI


```
cp ubuntu/*desktop ~/.local/share/applications
```


