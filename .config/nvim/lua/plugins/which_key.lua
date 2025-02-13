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
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.add({
        { "<leader>f",  group = "Find" },
        { "<leader>g",  group = "Git" },
        { "<leader>s",  group = "Search" },
        { "<leader>t",  group = "Toggle" },
        { "<leader>td", group = "Diagnostics" },
      })
    end,
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
