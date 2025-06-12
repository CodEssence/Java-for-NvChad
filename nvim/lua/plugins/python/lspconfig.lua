-- ~/.config/nvim/lua/plugins/python/lspconfig.lua
return {
    "neovim/nvim-lspconfig",
    ft = "python",
    config = function()
        require("configs.python-lsp-servers")
    end,
}

