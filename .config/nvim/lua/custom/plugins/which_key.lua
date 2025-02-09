return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = 250,
      icons = {
        mappings = vim.g.have_nerd_font,
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps",
      },
    },
  }
}
