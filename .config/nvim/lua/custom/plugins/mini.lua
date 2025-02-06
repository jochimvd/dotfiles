return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.statusline").setup()
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
