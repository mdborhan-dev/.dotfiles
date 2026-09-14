# Dotfiles

My personal Linux configuration files.

## Included

- Kitty
- Neovim / LazyVim
- Starship
- Zsh
- Fastfetch

## Structure

```text
dotfiles/
├── kitty/
├── nvim/
├── starship/
├── zsh/
├── fastfetch/
├── install.sh
├── README.md
└── .gitignore
```

## Automatic Installation

On a fresh machine:

```bash
git clone git@github.com:mdborhan-dev/.dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The installer creates symlinks from the expected configuration locations to this repository.

## Manual Installation

You can also create the symlinks manually.

### Kitty

```bash
mkdir -p ~/.config
mv ~/.config/kitty ~/.config/kitty.backup 2>/dev/null
ln -s ~/dotfiles/kitty ~/.config/kitty
```

### Neovim / LazyVim

```bash
mkdir -p ~/.config
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null
ln -s ~/dotfiles/nvim ~/.config/nvim
```

### Starship

```bash
mkdir -p ~/.config
mv ~/.config/starship.toml ~/.config/starship.toml.backup 2>/dev/null
ln -s ~/dotfiles/starship/starship.toml ~/.config/starship.toml
```

### Fastfetch

```bash
mkdir -p ~/.config
mv ~/.config/fastfetch ~/.config/fastfetch.backup 2>/dev/null
ln -s ~/dotfiles/fastfetch ~/.config/fastfetch
```

### Zsh

```bash
mv ~/.zshrc ~/.zshrc.backup 2>/dev/null
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
```

After installing the Zsh configuration:

```bash
exec zsh
```

## Symlink Layout

The repository is the source of truth for the configuration files.

```text
~/.config/kitty         -> ~/dotfiles/kitty
~/.config/nvim          -> ~/dotfiles/nvim
~/.config/starship.toml -> ~/dotfiles/starship/starship.toml
~/.config/fastfetch   -> ~/dotfiles/fastfetch
~/.zshrc                -> ~/dotfiles/zsh/.zshrc
```

## Updating

Because the configuration files are symlinked, editing the files normally also changes the files in the repository.

After making changes:

```bash
cd ~/dotfiles
git status
git add .
git commit -m "Update config"
git push
```

## Notes

Do not commit:

- API keys
- Passwords
- Tokens
- Private keys
- Machine-specific secrets
- Caches
- Temporary files
- Backup files

Machine-specific configuration should be kept outside the repository when possible.