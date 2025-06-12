-- File: ~/.config/nvim/lua/configs/nvim-java.lua
--[[
local config = require('nvchad.configs.lspconfig')
local on_attach = config.on_attach
local capabilities = config.capabilities

require('java').setup({})

require('lspconfig').jdtls.setup({
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-22",
                        path = "/usr/lib/jvm/jdk-22-oracle-x64",
                        default = true,
                    },
                },
            },
        },
    },
    on_attach = function(client, bufnr)
        require('java').dap.on_attach(client, bufnr)
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    filetypes = { 'java' },
})
]]
