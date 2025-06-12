-- Updated config --

-- ~/.config/nvim/lua/plugins/init.lua

-- Create an empty table to hold all plugin specifications
local plugins = {}

-- Helper function to extend the 'plugins' table with configurations from other files
local function extend_plugins(t)
  for _, v in ipairs(t) do
    table.insert(plugins, v)
  end
end

--- Load existing plugins from your original init.lua directly into the 'plugins' table ---

-- These are the plugins you had directly listed in your original init.lua.
-- Add them to the 'plugins' table here.
table.insert(plugins, {
  "stevearc/conform.nvim",
  -- event = 'BufWritePre', -- uncomment for format on save
  opts = require "configs.conform",
})

table.insert(plugins, {
  "neovim/nvim-lspconfig",
  config = function()
    require "configs.lspconfig"
  end,
})

-- Uncomment and add other plugins you had directly here, for example:
-- table.insert(plugins, { import = "nvchad.blink.lazyspec" })

-- table.insert(plugins, {
--   "nvim-treesitter/nvim-treesitter",
--   opts = {
--     ensure_installed = {
--       "vim", "lua", "vimdoc",
--       "html", "css"
--     },
--     -- Ensure folding is enabled if you plan to use Treesitter folding
--     folding = { enable = true },
--   },
-- })


-- Add Mason and Mason-LSPConfig here
--
-- Edit: I moved the configs over to plugins/java/lsp-config.lua file.
--
--[[
table.insert(plugins, {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      -- Add any global mason settings here if needed
      -- e.g., ensure that the "bin" directory is in your system PATH
    })
  end
})

table.insert(plugins, {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "jdtls",           -- Ensure JDTLS is always installed by Mason
        "lua_ls",          -- Ensure Lua LS is installed
        "cssls",           -- Ensure CSS LS is installed
        "html"             -- Ensure HTML LS is installed
      },
      -- Automatically setup lspconfig for servers installed by mason
      automatic_installation = true,
    })
  end
})
--]]

--- Load plugins from different groups (your new structure) ---

-- Load plugins from the 'note-taking' group
extend_plugins(require("plugins.note-taking.telekasten"))
extend_plugins(require("plugins.note-taking.render-markdown"))

-- Load plugins from the 'java' development group
extend_plugins(require("plugins.java.treesitter"))
extend_plugins(require("plugins.java.lsp-config"))
extend_plugins(require("plugins.java.nvim-dap"))
extend_plugins(require("plugins.java.springboot-nvim"))
extend_plugins(require("plugins.java.none-ls"))
extend_plugins(require("plugins.java.cmp"))
-- extend_plugins(require("plugins.java.nvim-java"))

--- New Python Plugin Calls ---
-- These lines integrate your new Python-specific plugin configurations.
 extend_plugins(require("plugins.python.lspconfig"))
 extend_plugins(require("plugins.python.null-ls"))
 extend_plugins(require("plugins.python.nvim-dap-python"))
-- Add any other Python-specific plugin files here if you create them.

-- Add more groups as you create them, for example:
-- extend_plugins(require("plugins.utility.harpoon"))
-- extend_plugins(require("plugins.lsp.nvim-lspconfig"))

-- Finally, return the combined list of all plugin specifications for lazy.nvim to process
return plugins




--------------------------------------------------------------------------------------------------
-- This is the default init.lua content for a backup --

--[[
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

}

]]
-----------------------------------------------------------------------



