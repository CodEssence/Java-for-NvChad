-- ~/.config/nvim/lua/configs/python-null-ls-sources.lua
-- Python-specific sources for none-ls.nvim (formatters and linters).

local null_ls = require("null-ls")

return {
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.mypy.with({
        extra_args = function()
            local virtual = os.getenv("VIRTUAL_ENV") or
                os.getenv("CONDA_PREFIX") or "/usr"
            return { "--python-executable", virtual .. "/bin/python3" }
        end,
    }),
    -- Add other Python formatters/linters here if desired.
}
