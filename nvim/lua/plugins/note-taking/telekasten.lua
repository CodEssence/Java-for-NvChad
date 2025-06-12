  -- telekasten.nvim for linking and Zettelkasten features
return {
  {
    "renerocksai/telekasten.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    -- *** ADD THIS LINE ***
    cmd = { "Telekasten" }, -- Load telekasten when its commands are used
    -- Keep `lazy = true` (which is default for plugins not specified with `event` or `ft` etc.)
    -- and define `keys` as follows:
    keys = {
      -- Use <cmd> or explicit vim.cmd for more robust lazy loading with keys
      {"<leader>kn", "<cmd>Telekasten new_note<CR>", desc = "Telekasten: New Note", mode = "n"},
      {"<leader>kf", "<cmd>Telekasten find_notes<CR>", desc = "Telekasten: Find Notes", mode = "n"},
      {"<leader>kb", "<cmd>Telekasten show_backlinks<CR>", desc = "Telekasten: Show Backlinks", mode = "n"},
      {"<leader>kd", "<cmd>Telekasten goto_today<CR>", desc = "Telekasten: Daily Note", mode = "n"},
      {"<leader>kl", "<cmd>Telekasten insert_link<CR>", desc = "Telekasten: Insert Link", mode = "n"},
      {"<leader>kc", "<cmd>Telekasten show_calendar<CR>", desc = "Telekasten: Calendar", mode = "n"},
      -- Note: `buffer = true` was causing an issue previously. For a general
      -- link follower, it's often better without `buffer = true` unless you have
      -- very specific buffer-local mappings.
    },
    config = function()
      -- The config function ensures the setup happens when the plugin loads
      require("telekasten").setup({
        home = vim.fn.expand("~/notes"), -- *** IMPORTANT: SET YOUR NOTES DIRECTORY HERE ***
        auto_set_title = true,
        completion_auto_create_note = true,
        follow_link_in_browser = false,
        daily_note_template = "%Y-%m-%d",
        auto_set_filetype = false, -- *** ADD THIS LINE ***
      })
    end,
  },
}

