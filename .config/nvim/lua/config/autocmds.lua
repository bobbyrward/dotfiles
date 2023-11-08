-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup("local_config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "python",
    "go",
    "make",
    "rust",
  },
  callback = function(_)
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true
  end,
})
