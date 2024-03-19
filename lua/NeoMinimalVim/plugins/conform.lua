return {
  {
    'stevearc/conform.nvim',
    config = function()
      local conform = require 'conform'

      conform.setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettierd', 'prettier' },
          javascriptreact = { 'prettierd', 'prettier' },
          typescript = { 'prettierd', 'prettier' },
          typescriptreact = { 'prettierd', 'prettier' },
          json = { 'prettierd', 'prettier' },
          markdown = { 'prettierd', 'prettier' },
          html = { 'htmlbeautifier' },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        lsp_fallback = true,
      }

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function(args)
          require('conform').format { bufnr = args.buf }
        end,
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>ll', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = 'Format file or range (in visual mode)' })
    end,
    opts = {},
  },
}
