# kickstart.nvim

Personal Neovim config.  

## Requirements for an Apple Silicon MacBook

Install the following packages using Homebrew:

```bash
brew install neovim ripgrep fzf sqlite fd black isort prettier stylua terraform
brew install --cask font-hack-nerd-font
```

## Python Setup for Neovim

Create a dedicated virtual environment for Neovim:

```bash
# Create a virtual environment for Neovim
python3 -m venv ~/neovim_env

# Activate the environment
source ~/neovim_env/bin/activate

# Install the neovim package
pip install neovim

# Deactivate the environment
deactivate
```

Add this to your Neovim configuration (init.lua or similar):

```lua
-- Set the Python provider to use the dedicated Neovim environment
vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim/neovim_env/bin/python')
```

Add the virtual environment to your global `.gitignore`:

```bash
echo "~/neovim_env/" >> ~/.gitignore
```

## Node.js Setup

1. Install nvm:
```bash
brew install nvm
```

2. Add to your `.zshrc`:
```bash
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion"
```

3. Install and use a Node.js version:
```bash
nvm install node  # Install the latest version
nvm use node      # Use the latest version
```

4. Install the neovim npm package:
```bash
npm install -g neovim
```

## Language Server Protocol (LSP) Setup

To set up LSP for various languages, you'll need to install language servers and configure them in Neovim. Here's an example for Python using Pyright:

1. Install Pyright:
```bash
npm install -g pyright
```

2. Add this to your Neovim configuration:
```lua
local lspconfig = require('lspconfig')

lspconfig.pyright.setup{
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace"
      }
    }
  }
}
```

Repeat similar steps for other languages you work with.

## Final Steps

After completing the setup:

1. Restart Neovim
2. Run `:checkhealth` to ensure everything is properly configured
3. Address any remaining warnings or errors as needed

Remember to keep your Neovim and its plugins updated regularly for the best experience.
