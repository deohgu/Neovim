return {

  -- 1) Mason package manager configuration (loads immediately)
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  -- 2) Mason tool installer configuration (for installing CLI tools at startup)
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylua',
          'tflint',
          'hadolint',
          'markdownlint',
          'yamllint',
          'marksman',
          'eslint-lsp',
          'prettier',
          'black',
          'ruff',
        },
        auto_update = true,
        run_on_start = true,
      }
    end,
  },

  -- 3) LSP configurations (lazy-loaded on buffer read or new file)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
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

          if client and client.name == 'eslint' then
            -- Create an autocmd to run ESLint autofix on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              command = 'EslintFixAll',
            })
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
      capabilities = require('blink.cmp').get_lsp_capabilities()

      -- LSP server configurations
      local servers = {
        -- Python
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

        -- Terraform
        terraformls = {},

        -- YAML
        yamlls = {},

        -- Helm
        helm_ls = {},

        -- Docker
        dockerls = {},
        docker_compose_language_service = {},

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },

        -- Rust
        rust_analyzer = {},

        -- JSON
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

        -- CSS
        cssls = {},

        -- Angular
        angularls = {
          -- Angular Language Service configuration
        },

        -- TypeScript / JavaScript
        ts_ls = {
          -- Only code-intelligence settings; no ESLint references
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              suggest = {
                completeFunctionCalls = true,
              },
              preferences = {
                importModuleSpecifier = 'non-relative',
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
          init_options = {
            preferences = {
              importModuleSpecifierPreference = 'non-relative',
              importModuleSpecifierEnding = 'minimal',
            },
          },

          eslint = {
            settings = {
              run = 'onSave',
              format = { enable = true },
            },
            -- If you want to use eslint for formatting too:
            on_attach = function(client, bufnr)
              -- This ensures eslint can also format the code
              client.server_capabilities.documentFormattingProvider = true
            end,
          },
        },
      }

      -- Setup mason-lspconfig to automatically setup LSP servers
      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers), -- Use LSP server names here
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            -- Check if the server exists in lspconfig
            if require('lspconfig')[server_name] then
              require('lspconfig')[server_name].setup(server)
            else
              vim.notify("LSP server '" .. server_name .. "' not found in lspconfig", vim.log.levels.WARN)
            end
          end,
        },
      }
    end,
  },
}
