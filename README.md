# myenv

Personal environment configuration files for vim, neovim, zsh, and more.

## Quick Start (New Machine)

```bash
# 1. Clone this repo
git clone https://github.com/spencerimp/myenv.git ~/myenv

# 2. Set up neovim (recommended)
mkdir -p ~/.config
ln -s ~/myenv/nvim ~/.config/nvim

# 3. Set up vim (optional, for legacy vim)
ln -s ~/myenv/.vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# 4. Set up zsh (optional)
ln -s ~/myenv/.zshrc ~/.zshrc
```

> **Note**: Using symlinks (`ln -s`) keeps configs synced with the repo. Use `cp` instead if you want independent copies.

---

# Neovim

Modern Lua-based configuration with lazy.nvim plugin manager.

## Requirements

- Neovim 0.10+ (0.11+ recommended for LSP support)
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons (optional but recommended)

## Installation

```bash
# macOS
brew install neovim

# Ubuntu
sudo apt install neovim

# Link config (or copy with: cp -r ~/myenv/nvim ~/.config/)
mkdir -p ~/.config
ln -s ~/myenv/nvim ~/.config/nvim

# First launch - plugins auto-install
nvim
```

## What Happens on First Launch

1. **lazy.nvim** bootstraps itself automatically
2. All plugins are downloaded and installed
3. Treesitter parsers are installed for syntax highlighting

## Neovim Version Notes

| Version | Status |
|---------|--------|
| 0.11+   | Full support (enable LSP in `plugins/init.lua`) |
| 0.10.x  | Works with LSP disabled (current default) |
| < 0.10  | Not supported |

To enable LSP on Neovim 0.11+, edit `nvim/lua/plugins/init.lua` and uncomment:
```lua
{ import = "plugins.lsp" },
```

## Key Bindings

**Leader key: `;`**

### Navigation
| Key | Action |
|-----|--------|
| `Space` | Toggle fold |
| `Ctrl+h/j/k/l` | Window navigation |
| `Ctrl+arrows` | Window navigation |
| `H` / `L` | Previous / Next buffer |
| `B` | Add buffer (`:badd`) |
| `Ctrl+X` | Delete buffer |

### Function Keys
| Key | Action |
|-----|--------|
| `F2` | Reload config |
| `F3` | Run current Python file |
| `F5` | Toggle file tree (nvim-tree) |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `Ctrl+p` | Find files |
| `;ff` | Find files |
| `;fg` | Live grep (search text) |
| `;fb` | Find buffers |
| `;fh` | Help tags |
| `;fr` | Recent files |

### Git (Gitsigns)
| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / Previous hunk |
| `;hs` | Stage hunk |
| `;hr` | Reset hunk |
| `;hp` | Preview hunk |
| `;hb` | Blame line |

### Editing
| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment selection |
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |

## Commands

```vim
:Lazy              " Plugin manager UI
:Telescope         " Fuzzy finder
:NvimTreeToggle    " File tree (or F5)
:Shell <cmd>       " Run shell command in buffer
```

## Directory Structure

```
nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/
│   │   ├── options.lua      # Vim options
│   │   ├── keymaps.lua      # Key bindings
│   │   └── autocmds.lua     # Autocommands
│   ├── plugins/
│   │   ├── init.lua         # lazy.nvim setup
│   │   ├── completion.lua   # nvim-cmp
│   │   ├── treesitter.lua   # Syntax highlighting
│   │   ├── telescope.lua    # Fuzzy finder
│   │   ├── ui.lua           # Theme, statusline, tree
│   │   ├── editor.lua       # Surround, comment, etc.
│   │   └── git.lua          # Fugitive, gitsigns
│   └── utils/
│       └── shell.lua        # :Shell command
└── after/ftplugin/          # Language-specific settings
    ├── python.lua           # 4 spaces
    ├── typescript.lua       # 2 spaces
    └── ...
```

## Troubleshooting

**Reset plugins** (if something breaks):
```bash
rm -rf ~/.local/share/nvim/lazy ~/.local/state/nvim/lazy
nvim
```

**Check health**:
```vim
:checkhealth
```

---

# Vim (Legacy)

The `.vimrc` works with regular vim using Vundle plugins.

## Installation

```bash
# Link .vimrc (or copy with: cp ~/myenv/.vimrc ~/.vimrc)
ln -s ~/myenv/.vimrc ~/.vimrc

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install plugins
vim +PluginInstall +qall
```

---

# VS Code

## Export Extensions

```bash
code --list-extensions > vscode-extensions.txt
```

## Install Extensions

```bash
cat vscode-extensions.txt | xargs -L 1 code --install-extension
```

---

# Zsh + Oh My Zsh

## Installation

```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Link config
ln -s ~/myenv/.zshrc ~/.zshrc
```

## Powerlevel10k Theme

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

Then restart terminal and follow the configuration wizard.

---

# Fonts

Install a Nerd Font for icons in neovim and terminal.

## Recommended: Hack Nerd Font

Download from [nerdfonts.com](https://www.nerdfonts.com/font-downloads)

### macOS
```bash
# Using Homebrew
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
```

### Ubuntu/Linux
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
unzip Hack.zip
rm Hack.zip
fc-cache -fv
```

Then set the font in your terminal emulator preferences.

---

# Ubuntu Desktop

Copy custom `.desktop` files for application launchers:

```bash
cp ~/myenv/ubuntu/*.desktop ~/.local/share/applications/
```
