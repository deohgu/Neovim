return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

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
        -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('<leader>i', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- map(']e', vim.diagnostic.goto_next(), 'Next Diagnostic')
        -- map('[e', vim .diagnostic.goto_prev(), 'Previous Diagnostic')

        -- Open diagnostics hover window
        vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = 'Open Error Diagnostics Hover' })

        -- Navigate to next diagnostic
        vim.keymap.set('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true, desc = 'Next Error Diagnostic' })

        -- Navigate to previous diagnostic
        vim.keymap.set('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true, desc = 'Previous Error Diagnostic' })

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
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
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    vim.filetype.add {
      pattern = {
        ['.*/templates/.*%.yaml'] = 'helm',
      },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'workspace',
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
      tsserver = {},
      jsonls = {
        filetypes = { 'json', 'jsonc' },
        settings = {
          json = {
            -- Schemas https://www.schemastore.org
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
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
      'black',
      'isort',
      'flake8',
      'pyright',
      'tflint',
      'hadolint',
      'helm-ls',
      'dockerls',
      'markdownlint',
      'yamllint',
      'marksman',
      'rust_analyzer',
      'tsserver',
      'jsonls',
      'cssls',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- require('lspconfig').jsonls.setup {}

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
