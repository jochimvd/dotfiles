return {
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disable_mouse = false,
      disabled_filetypes = { "lazy", "mason", "minifiles" },
    },
    config = function(_, opts)
      require("hardtime").setup(opts)
      vim.keymap.set("n", "<leader>th", "<cmd>Hardtime toggle<CR>", { desc = "Toggle Hardtime" })
    end
  }
}
