-- ~/.config/nvim/lua/plugins/java/cmp.lua

return {
  {
    "hrsh7th/nvim-cmp",
    -- The 'opts' function receives NvChad's default options for nvim-cmp.
    -- We modify these options directly.
    opts = function(_, opts)
      -- Ensure the 'experimental' table exists
      opts.experimental = opts.experimental or {}

      -- Explicitly set ghost_text to true
      opts.experimental.ghost_text = true

      -- You can add other cmp customizations here if needed,
      -- or merge them with NvChad's existing settings.
      -- For example, to ensure 'preview' and 'noselect' are in completeopt:
      -- opts.completion.completeopt = opts.completion.completeopt .. ",preview,noselect"

      -- NvChad usually sets preselect. If you want to be extra sure:
      -- opts.preselect = require("cmp.types").cmp.Preselect.Item

      -- Always return the modified options table
      return opts
    end,
  },
}

