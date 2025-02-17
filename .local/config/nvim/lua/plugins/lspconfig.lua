return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)

        -- NOTE: Configuration of LSP keymaps

        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local telescope = require('telescope.builtin')

        map('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>gd', telescope.lsp_definitions, '[G]oto [D]efinition')
        map('<leader>gr', telescope.lsp_references, '[G]oto [R]eferences')
        map('<leader>gi', telescope.lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>gt', telescope.lsp_type_definitions, 'Goto [T]ype definition')

        -- Fuzzy find all the symbols in the current file/workspace
        map('<leader>ss', telescope.lsp_document_symbols, '[S]earch [S]ymbols in current file')
        map('<leader>sS', telescope.lsp_dynamic_workspace_symbols, '[S]earch [S]ymbols in current workspace')

        -- Rename a symbol under the cursor
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

        -- Show a tip about the hovered word
        map('<leader>ht', vim.lsp.buf.hover, '[H]over [T]ip')


        -- NOTE: Highlight references of the word under your cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

        -- NOTE: Toggle inlay hints
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- NOTE: Diagnostic symbols in the sign column (gutter)
    if vim.g.have_nerd_font then
      local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config { signs = { text = diagnostic_signs } }
    end


    -- NOTE: Installing and configuring lsp servers with mason and mason-lspconfig

    -- List of lsp servers to be installed with Mason
    local servers = {
      rust_analyzer = {},
      lua_ls = {},
    }

    -- Variable holding the capabilities of lsp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Putting the configuration of servers and capabilities to practice
    local ensure_installed = vim.tbl_keys(servers or {})
    require('mason').setup()
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
    require('mason-lspconfig').setup({
      -- We add a handler to configure lsp capabilities for each server
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
      automatic_installation = true,
    })
  end,
}
