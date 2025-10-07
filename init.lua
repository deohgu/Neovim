-- Performance optimizations
vim.loader.enable() -- Enable bytecode cache (Neovim >= 0.9)

-- Disable unused built-in plugins
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'spellfile_plugin',
  'matchit',
  'matchparen',
  'tutor_mode_plugin',
  'remote_plugins',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set the Python provider to use the dedicated Neovim environment
vim.g.python3_host_prog = vim.fn.expand '~/neovim_env/bin/python'

-- Optional: Disable Python 2 provider
vim.g.loaded_python_provider = 0

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- [[ Setting options ]]

vim.o.backup = false -- Never backed up
vim.o.autoread = true
vim.opt.swapfile = false

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

vim.opt.wrapmargin = 10 -- Start wrapping 2 characters before the edge of the screen
vim.opt.colorcolumn = '100' -- Optional visual guide

vim.opt.wrap = true
vim.opt.linebreak = false
vim.opt.breakindent = true
vim.opt.showbreak = '>> '
vim.opt.textwidth = 80

-- Save undo history
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 100

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- [[ Basic Keymaps ]]

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Change inner word without yanking
vim.keymap.set('n', 'ciw', '"_ciw', { desc = 'Change inner word without yanking' })

-- Open diagnostics hover window
-- TODO: Not working
-- vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = 'Open Error Diagnostics Hover' })

-- Navigate to next diagnostic
-- TODO: Not working
-- vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true, desc = 'Next Error Diagnostic' })

-- Navigate to previous diagnostic
-- TODO: Not working
-- vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true, desc = 'Previous Error Diagnostic' })

-- Stays in visual mode after indent
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- Exit insert mode without pressing esc?
-- vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Relative jumping mappings
vim.api.nvim_set_keymap('n', 'J', '5j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '5k', { noremap = true, silent = true })

local function copy_relative_path()
  -- Find the project root by looking for a .git directory, searching upward
  -- You could add other markers here, like: { '.git', 'package.json' }
  local root = vim.fs.find({ '.git' }, { upward = true, path = vim.fn.expand '%:p:h' })[1]

  if not root then
    vim.notify('Project root (.git) not found.', vim.log.levels.WARN)
    return
  end

  -- Get the parent directory of the found marker (e.g., of the '.git' folder)
  local root_dir = vim.fn.fnamemodify(root, ':h')

  -- Get the full path of the current file
  local file_path = vim.fn.expand '%:p'

  -- Calculate the relative path by removing the root directory part
  -- The +2 accounts for the directory separator '/'
  local relative_path = string.sub(file_path, #root_dir + 2)

  -- Copy the path to the system clipboard and notify the user
  vim.fn.setreg('+', relative_path)
  vim.notify('Copied relative path: ' .. relative_path)
end

local function copy_absolute_path()
  -- The '%:p' modifier expands to the full absolute path
  local path = vim.fn.expand '%:p'

  -- Copy the path to the system clipboard and notify the user
  vim.fn.setreg('+', path)
  vim.notify('Copied absolute path: ' .. path)
end

vim.keymap.set('n', '<leader>p', copy_relative_path, { desc = 'Copy relative src file path' })
vim.keymap.set('n', '<leader>P', copy_absolute_path, { desc = 'Copy absolute root file path' })

-- [[ Basic Autocommands ]]
--
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Disable netrw as using mini.files
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { import = 'plugins' },
}, {
  rocks = {
    enabled = false,
  },
})
