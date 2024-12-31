return {
  -- Mason package manager configuration (loads immediately)
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- Mason tool installer configuration (loads immediately to install servers/tools at startup)
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- Formatters and linters only
          'stylua',
          'black',
          'isort',
          'flake8',
          'tflint',
          'hadolint',
          'markdownlint',
          'yamllint',
          'marksman',
        },
        auto_update = true, -- Automatically update installed tools
        run_on_start = true, -- Run installation on startup
      }
    end,
  },

  -- LSP configurations (lazy-loaded on buffer read or new file)
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim', -- Ensure mason is loaded before lspconfig
      'williamboman/mason-lspconfig.nvim',
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- Create an autocommand for LSP attachment
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Key mappings for LSP functionality
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', function()
            require('telescope.builtin').lsp_references {
              fname_width = 100,
              show_line = false,
              initial_mode = 'normal',
            }
          end, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('gt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>fs', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>fS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rc', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>i', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Diagnostic key mappings
          vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = 'Open Error Diagnostics Hover' })
          vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true, desc = 'Next Error Diagnostic' })
          vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true, desc = 'Previous Error Diagnostic' })

          -- Highlight references under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints if supported
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint(event.buf, nil)
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Filetype overrides
      vim.filetype.add {
        pattern = {
          ['.*/templates/.*%.yaml'] = 'helm',
        },
      }

      -- Capabilities for LSP servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- LSP server configurations
      local servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
              },
            },
          },
        },
        terraformls = {},
        yamlls = {},
        helm_ls = {},
        dockerls = {},
        docker_compose_language_service = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        rust_analyzer = {},
        ts_ls = {},
        jsonls = {
          filetypes = { 'json', 'jsonc' },
          settings = {
            json = {
              schemas = {
                {
                  fileMatch = { 'package.json' },
                  url = 'https://json.schemastore.org/package.json',
                },
                {
                  fileMatch = { 'tsconfig*.json' },
                  url = 'https://json.schemastore.org/tsconfig.json',
                },
                {
                  fileMatch = {
                    '.prettierrc',
                    '.prettierrc.json',
                    'prettier.config.json',
                  },
                  url = 'https://json.schemastore.org/prettierrc.json',
                },
                {
                  fileMatch = { '.eslintrc', '.eslintrc.json' },
                  url = 'https://json.schemastore.org/eslintrc.json',
                },
                {
                  fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
                  url = 'https://json.schemastore.org/babelrc.json',
                },
                {
                  fileMatch = { 'lerna.json' },
                  url = 'https://json.schemastore.org/lerna.json',
                },
                {
                  fileMatch = { 'now.json', 'vercel.json' },
                  url = 'https://json.schemastore.org/now.json',
                },
                {
                  fileMatch = {
                    '.stylelintrc',
                    '.stylelintrc.json',
                    'stylelint.config.json',
                  },
                  url = 'http://json.schemastore.org/stylelintrc.json',
                },
              },
            },
          },
        },
        cssls = {},
        angularls = {
          -- Angular Language Service configuration
        },
      }

      -- Setup mason-lspconfig to automatically setup LSP servers
      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers), -- Use LSP server names here

        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
