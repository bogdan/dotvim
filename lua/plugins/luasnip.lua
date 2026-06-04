return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")

      require("luasnip.loaders.from_snipmate").load({
        paths = { vim.fn.expand("~/.vim/snippets") },
      })

      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("typescriptreact", { "javascript" })
      ls.filetype_extend("svelte", { "typescript", "javascript" })
      require("luasnip.loaders.from_lua").load({
        paths = { vim.fn.expand("~/.vim/snippets") },
      })

      vim.api.nvim_create_user_command("EditSnips", function(cmd)
        local ft = cmd.args ~= "" and cmd.args or vim.bo.filetype
        local path = vim.fn.expand("~/.vim/snippets/" .. ft .. ".snippets")
        vim.cmd.split(path)
      end, {
        nargs = "?",
        complete = function()
          local files = vim.fn.glob(vim.fn.expand("~/.vim/snippets/*.snippets"), false, true)
          return vim.tbl_map(function(f) return vim.fn.fnamemodify(f, ":t:r") end, files)
        end,
      })

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
