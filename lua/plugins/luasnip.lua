return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")

      require("ultisnips_loader").load({
        paths = { vim.fn.expand("~/.vim/UltiSnips") },
      })

      vim.api.nvim_create_user_command("EditSnippets", function()
        local ft = vim.bo.filetype
        local path = vim.fn.expand("~/.vim/UltiSnips/" .. ft .. ".snippets")
        vim.cmd.edit(path)
      end, { desc = "Edit UltiSnips file for current filetype" })

      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
            "n",
            false
          )
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },
}
