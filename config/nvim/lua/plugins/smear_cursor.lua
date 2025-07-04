return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smear_cursor").setup({})
      require("smear_cursor").toggle() -- Disable on startup
    end,
    keys = {
      { "<leader>ts", function() require("smear_cursor").toggle() end, desc = "Toggle Smear Cursor" },
    },
  }
}
