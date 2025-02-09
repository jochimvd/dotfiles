return {
  {
    "sphamba/smear-cursor.nvim",
    config = function()
      require("smear_cursor").setup({})
      require("smear_cursor").toggle() -- Disables on startup
      vim.keymap.set("n", "<leader>ts", function()
        require("smear_cursor").toggle()
      end, { desc = "[T]oggle [S]mear Cursor" })
    end
  }
}
