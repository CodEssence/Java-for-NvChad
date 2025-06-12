-- = nvim-java plugin setup =
--[[
return {
    'nvim-java/nvim-java',
    lazy = false,
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      },
    },
    config = function()
      require('configs.java')
    end,
  }
]]

----------------------------------------------------------------------------------

-- == Backup configurations ==


--== nvim-java plugin setup ==
--[[

return {
  -- Main nvim-java plugin definition
  "nvim-java/nvim-java",
  lazy = false, -- Load immediately on startup for LSP functionality.

  -- List all necessary dependencies for nvim-java to function properly.
  -- Lazy.nvim ensures these are installed and loaded before configuring nvim-java.
  dependencies = {
    -- Core nvim-java components and utilities
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "MunifTanjim/nui.nvim",    -- UI library often used by nvim-java's features

    -- LSP and Debugging infrastructure
    "neovim/nvim-lspconfig", -- Core plugin for Language Server Protocol client setup
    "mfussenegger/nvim-dap",   -- Debug Adapter Protocol client
    "rcarriga/nvim-dap-ui",   -- Provides a graphical user interface for nvim-dap

    -- Mason for automatic tool installation (JDTLS, Java-Debug, etc.)
    {
      "williamboman/mason.nvim",
      opts = {
        -- Add nvim-java's custom registry to Mason for Java-specific tools
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry", -- Mason's default registry
        },
      },
    },

    -- Enhance coding experience
    "nvim-treesitter/nvim-treesitter", -- Required for robust Java syntax parsing and highlighting
    "hrsh7th/nvim-cmp",                -- For advanced autocompletion integration (if used)
  },

  -- Configuration function: This runs when nvim-java is loaded.
  config = function()
      print("--- nvim-java config function started! ---") -- Add this line
    -- 1. Setup nvim-java itself: This initializes the plugin and registers its commands.
    -- It should be called BEFORE lspconfig.jdtls.setup for proper integration.
    require("java").setup({
      -- Optional: Define custom project root markers beyond standard ones (e.g., specific build files)
      -- root_markers = { "settings.gradle", "pom.xml", "build.gradle", ".git" },

      -- Crucial: Ensure Mason registry for nvim-java tools is active for auto-installation.
      mason = {
        registries = {
          'github:nvim-java/mason-registry',
        },
      },
      -- Optional: Set logging level for debugging nvim-java's internal operations.
      -- log_level = vim.log.levels.INFO, -- Set to DEBUG for more verbose logs
    })

    -- 2. Setup JDTLS (Java Development Tools Language Server) via nvim-lspconfig.
    require("lspconfig").jdtls.setup({
      -- Essential: Configure your Java JDK runtimes for JDTLS to find and use.
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-22",                              -- Name matching your JDK version
                path = "/usr/lib/jvm/jdk-22-oracle-x64",        -- Absolute path to your Oracle JDK 22
                default = true,                                 -- Designate this as the primary JDK for JDTLS
              },
              -- Add other JDK versions here if you need to switch between them:
              -- { name = "JavaSE-17", path = "/path/to/jdk-17", },
            },
          },
        },
      },

      -- Crucial: `on_attach` callback function.
      -- This runs every time the JDTLS client successfully attaches to a Java buffer.
      on_attach = function(client, bufnr)
        -- Integrate nvim-java's debugging (DAP) capabilities.
        require('java').dap.on_attach(client, bufnr)

        -- Call NvChad's general LSP on_attach function to apply common keymaps
        -- and other configurations shared across all LSP servers.
        if require("plugins.configs.lspconfig").on_attach then
          require("plugins.configs.lspconfig").on_attach(client, bufnr)
        end
      end,

      -- `capabilities`: Defines the features your LSP client (Neovim) supports.
      -- NvChad's `lspconfig` setup usually provides enhanced capabilities (e.g., for `nvim-cmp`).
      capabilities = require("plugins.configs.lspconfig").capabilities,

      -- `filetypes`: Tells `lspconfig` to activate JDTLS specifically for Java files.
      filetypes = { "java" },
    })

    -- Optional: Ensure Tree-sitter is configured for Java.
    -- Only necessary if your global Tree-sitter setup doesn't already ensure 'java'
    -- is installed and highlighting/indentation are enabled.
    -- You can remove this block if your global setup handles it.
    -- require("nvim-treesitter.configs").setup {
    --   ensure_installed = { "java" },
    --   highlight = { enable = true },
    --   indent = { enable = true },
    -- }

    -- Optional: Basic nvim-dap-ui setup if you installed nvim-dap-ui
    -- require("dapui").setup({
    --   -- Your dap-ui configuration options here
    -- })

  end, -- End of config function

  -- Ensure the plugin loads when a Java file is opened (redundant with lazy=false, but good for clarity)
  ft = { 'java' },
}

--]]



----------------------------------------------------------------------------------


