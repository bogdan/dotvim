 -- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lua/lazy/lazy.nvim")

vim.cmd("source ~/.vim/vimrc")
-- Load all plugins from lua/plugins/
require("lazy").setup("plugins")
