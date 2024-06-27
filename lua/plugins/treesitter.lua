return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    ensure_installed = {
      'ninja',
      'python',
      'rst',
      'toml',
      'yaml',
      'json',
      'lua',
      'hcl',
      'sql',
      'dockerfile',
      'hcl',
      'go',
      'typescript',
      'html',
      'css',
      'javascript',
      'bash',
      'terraform',
      'markdown',
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
