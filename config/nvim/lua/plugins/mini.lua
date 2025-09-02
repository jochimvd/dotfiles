return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.statusline").setup()
      require("mini.git").setup()
      require("mini.diff").setup({
        view = {
          signs = { add = "│", delete = "│", change = "│" },
        }
      })
      require("mini.icons").setup()
      require("mini.pick").setup()
      require("mini.files").setup({
        windows = {
          preview = true
        }
      })
    end
  }
}
