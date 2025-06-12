-- ~/.config/nvim/lua/plugins/python/null-ls.lua
return {
    "nvimtools/none-ls.nvim",
    ft = { "python" },
    opts = function(_, opts)
        opts.sources = vim.list_extend(opts.sources or {},
            require("configs.python-null-ls-sources"))
        -- Uncomment below for auto-format on save for Python files
        -- local augroup = vim.api.nvim_create_augroup("PythonAutoFormat",
        --     { clear = true })
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --     group = augroup,
        --     buffer = bufnr,
        --     callback = function()
        --         vim.lsp.buf.format({ async = true })
        --     end,
        -- })
        return opts
    end,
    config = function(_, opts)
        require("null-ls").setup(opts)
        -- Optional: Python-specific formatting keymap (if different from
        -- global <leader>cf)
        -- vim.keymap.set("n", "<leader>fp", vim.lsp.buf.format,
        --     { desc = "[F]ormat [P]ython Code" })
    end,
}

