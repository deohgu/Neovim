return {
  'RRethy/vim-illuminate',
  event = 'BufReadPost', -- Simplified event list
  opts = {
    delay = 300, -- Increase delay a bit for better performance
    large_file_cutoff = 1000, -- Lower threshold for "large" files
    large_file_overrides = {
      providers = { 'lsp' },
      delay = 500, -- Even longer delay for large files
    },
    -- Add min_count_to_highlight for performance
    min_count_to_highlight = 2, -- Only highlight if word appears multiple times
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
  end,
}
