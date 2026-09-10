return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      _G.toggle_diagnostic_qf = function()
        for _, win in ipairs(vim.fn.getwininfo()) do
          if win.quickfix == 1 then
            if vim.fn.getqflist({ title = 0 }).title == "Diagnostics" then
              vim.cmd("cclose")
            else
              vim.diagnostic.setqflist({ open = false })
            end
            return
          end
        end
        vim.diagnostic.setqflist()
      end

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<C-w>]", function()
          vim.cmd("split")
          vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "g]", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-'>", function()
          vim.fn.setqflist({})
          vim.lsp.buf.references()
        end, opts)
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<Leader>i", function()
          vim.lsp.buf.code_action({ context = { only = { "source.addMissingImports" } }, apply = true })
        end, opts)
      end

      vim.lsp.config("ts_ls", {
        on_attach = on_attach,
        init_options = {
          plugins = {
            {
              name = "typescript-svelte-plugin",
              location = vim.fn.getcwd() .. "/node_modules/typescript-svelte-plugin",
            },
          },
        },
      })
      vim.lsp.config("svelte", { on_attach = on_attach })
      vim.lsp.enable({ "ts_ls", "svelte" })

      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function()
          for _, win in ipairs(vim.fn.getwininfo()) do
            if win.quickfix == 1 then
              if vim.fn.getqflist({ title = 0 }).title == "Diagnostics" then
                vim.diagnostic.setqflist({ open = false })
              end
              return
            end
          end
        end,
      })
    end,
  },
}
