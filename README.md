# Personal Neovim

Built on top of LazyVim starter kit.  
Some plugins will be installed, but not listed in the code,  
this is because LazyVim starter does this under the hood.  

## Modifying default plugins and mappings

LazyVim starter Kit seems to come with plugins under the hood  
that are not exposed to a user. As such, to change the default  
behaviour we have to override said plugins by recreating them in  
the plugins folder.  

In order to override them without removing existing functionality  
we can simply copy paste the full spec shown in the LazyVim Website:  
https://www.lazyvim.org/plugins/ui

## Plugins to install

- [ ] 

### Plugins AstroVim is using

* Plugin Manager - [https://github.com/folke/lazy.nvim](https://github.com/folke/lazy.nvim)
* Package Manager - [https://github.com/williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
* Session Manager - [https://github.com/Shatur/neovim-session-manager](https://github.com/Shatur/neovim-session-manager)
* Lua Functions - [https://github.com/nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
* Notifications - [https://github.com/rcarriga/nvim-notify](https://github.com/rcarriga/nvim-notify)
* Neovim UI Enhancer - [https://github.com/MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim)
* Automatic Indent Detection - [https://github.com/NMAC427/guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim)
* Smarter Splits - [https://github.com/mrjones2014/smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim)
* Icons - [https://github.com/nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
* Buffer Closing - [https://github.com/echasnovski/mini.bufremove](https://github.com/echasnovski/mini.bufremove)
* File Explorer - [https://github.com/nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
* Statusline - [https://github.com/rebelot/heirline.nvim](https://github.com/rebelot/heirline.nvim)
* Syntax Highlighting - [https://github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* Syntax Text Objects - [https://github.com/nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
* Autoclose tags - [https://github.com/windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
* Context Commenting - [https://github.com/JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
* Snippet Engine - [https://github.com/L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)
* Snippet Collections - [https://github.com/rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
* Completion Engine - [https://github.com/hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* Snippet Completion - [https://github.com/saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
* Buffer Completion - [https://github.com/hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
* DAP Completion - [https://github.com/rcarriga/cmp-dap](https://github.com/rcarriga/cmp-dap)
* Path Completion - [https://github.com/hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
* LSP Completion - [https://github.com/hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* Built-in LSP - [https://github.com/neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* Mason LSP Configuration - [https://github.com/williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
* LSP Symbols - [https://github.com/stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim)
* LSP Local Configuration - [https://github.com/folke/neoconf.nvim](https://github.com/folke/neoconf.nvim)
* Formatting & Linting - [https://github.com/jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
* Mason Null-ls Configuration - [https://github.com/jay-babu/mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim)
* Debugger - [https://github.com/mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
* Mason DAP Configuration - [https://github.com/jay-babu/mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim)
* Debugger UI - [https://github.com/rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
* Fuzzy Finder - [https://github.com/nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* Fuzzy Finder Syntax - [https://github.com/nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
* Git Integration - [https://github.com/lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
* Start Screen - [https://github.com/goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)
* Color Highlighting - [https://github.com/NvChad/nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
* Autopairs - [https://github.com/windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
* Terminal - [https://github.com/akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
* Commenting - [https://github.com/numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
* Indentation - [https://github.com/lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
* Keymaps Popup - [https://github.com/folke/which-key.nvim](https://github.com/folke/which-key.nvim)
* Smooth Escaping - [https://github.com/max397574/better-escape.nvim](https://github.com/max397574/better-escape.nvim)


### Examples 

https://www.reddit.com/r/neovim/comments/13wd1st/looking_for_some_configs_using_lazynvim_to_use_as/

## Troubleshooting

* Trouble installing telescope fzf.
  `Failed to run config for telescope-fzf-native.nvim`  
    * Run `cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim && make && cd -`.
    * This should be enough.
* Plugin names should not have extra commas, just the `.lua` one.
