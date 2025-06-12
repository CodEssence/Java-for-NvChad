  -- render-markdown.nvim for enhanced Markdown rendering
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "markdown", "quarto" },
    opts = {
      enabled = true,
      render_modes = { "n", "c", "t" },
      anti_conceal = { enabled = true },
      max_file_size = 10.0,
    },
  },
}
