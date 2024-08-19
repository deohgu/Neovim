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
      'go',
      'typescript',
      'html',
      'css',
      'javascript',
      'bash',
      'terraform',
      'markdown',
      'rust',
      -- Add the following parsers to match the health check
      'regex',
      'c',
      'vim',
      'vimdoc',
      'query',
      'markdown_inline',
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
