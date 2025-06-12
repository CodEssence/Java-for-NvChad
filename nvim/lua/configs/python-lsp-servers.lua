-- ~/.config/nvim/lua/configs/python-lsp-servers.lua
-- Python-specific LSP server configurations

local lspconfig = require("lspconfig")
-- Load your existing general LSP configuration for common settings.

local common_lsp_config_module = require("configs.lsp-config")

-- Use the on_attach and capabilities from your common LSP configuration.
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
    "pyright",
    "ruff_lsp",
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "python" },
        -- Add more pyright/ruff_lsp specific settings here if needed.
    })
end
