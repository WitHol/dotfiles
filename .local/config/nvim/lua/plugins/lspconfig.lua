return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    require('mason').setup({})
    require('mason-tool-installer').setup({
      ensure_installed = {
        'lua-language-server',
        'rust-analyzer'
      }
    })

    vim.lsp.config('lua_ls', {})
    vim.lsp.enable('lua_ls')

    vim.lsp.config('rust_analyzer', {})
    -- vim.lsp.enable('rust_analyzer')

    -- vim.print("lsp-configured")

    -- Keymaps, hightlights and all that stuff
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local telescope = require('telescope.builtin')
        local map = function(keymap, action, description)
          vim.keymap.set('n', keymap, action, { desc = description })
        end

        map('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>gd', telescope.lsp_definitions, '[G]oto  [D]efinition')
        map('<leader>gr', telescope.lsp_references, '[G]oto  [R]references')
        map('<leader>gi', telescope.lsp_implementations, '[G]oto  [I]mplementation')
        map('<leader>gt', telescope.lsp_type_definitions, '[G]oto  [T]ype definition')

        map('<leader>ss', telescope.lsp_document_symbols, '[S]earch [S]ymbols in current file')
        map('<leader>sS', telescope.lsp_dynamic_workspace_symbols, '[S]earch [S]ymbols in current workspace')

        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('<leader>ht', vim.lsp.buf.hover, '[H]over [T]ip')


        -- Highlight references of the word under your cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          vim.keymap.set('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, { desc = '[T]oggle Inlay [H]ints' })
        end
      end,
    })
  end
}
