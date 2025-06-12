-- ~/.config/nvim/lua/autocmds.lua

--[[
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup("MarkdownFolding", { clear = true })

autocmd("FileType", {
  group = "MarkdownFolding",
  pattern = "markdown",
  callback = function()
    -- Set foldmethod to 'expr' to use a custom expression for folding
    vim.opt_local.foldmethod = "expr"
    -- Use Treesitter's folding expression. This requires nvim-treesitter to be correctly set up.
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.folding.foldexpr()"
    vim.opt_local.foldnestmax = 10
    vim.opt_local.foldlevel = 1
  end,
})
--]]


-- Add any other custom autocmds here if you have any
