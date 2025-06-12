-- ~/.config/nvim/lua/plugins/python/nvim-dap-python.lua
return {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        require("mason-nvim-dap").setup({
            ensure_installed = { "debugpy" },
        })
        local debugpy_path = require("mason-nvim-dap").get_install_path("debugpy")
            .. "/venv/bin/python"
        require("dap-python").setup(debugpy_path)
        vim.keymap.set("n", "<leader>dpr", function()
            require('dap-python').test_method()
        end, { desc = "[D]ebug [P]ython [R]un Test Method" })
    end,
}

