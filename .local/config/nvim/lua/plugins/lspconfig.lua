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

        local telescope = require('telescope.builtin')

        vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = '[G]oto  [D]efinition' })
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { desc = '[G]oto  [R]references' })
        vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, { desc = '[G]oto  [I]mplementation' })
        vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = '[G]oto  [T]ype definition' })

        vim.keymap.set('n', '<leader>ss', telescope.lsp_document_symbols, { desc = '[S]earch [S]ymbols in current file' })
        vim.keymap.set('n', '<leader>sS', telescope.lsp_dynamic_workspace_symbols, { desc = '[S]earch [S]ymbols in current workspace' })

        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
        vim.keymap.set('n', '<leader>ht', vim.lsp.buf.hover, { desc = '[H]over [T]ip' })


        -- Highlight references of the word under your cursor
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

        -- Toggle inlay hints
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, { desc = '[T]oggle Inlay [H]ints' })
        end
      end,
    })

    -- NOTE: Installing and configuring lsp servers with mason and mason-lspconfig

    -- List of lsp servers to be installed with Mason
    local servers = {
      rust_analyzer = {},
      lua_ls = {},
      asm_lsp = {},
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
      ensure_installed = ensure_installed,
      automatic_installation = true,
    })
  end,
}
