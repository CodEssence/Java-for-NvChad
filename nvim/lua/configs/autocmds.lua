print("DEBUG: autocmds.lua loaded.")
-- Setup our JDTLS server any time we open up a java file
vim.cmd [[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'configs.jdtls'.setup_jdtls()
    augroup end
]]

