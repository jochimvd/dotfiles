-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup('wrap_spell', { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})



-- Enable relative line numbers only in normal mode
local numbertoggle = vim.api.nvim_create_augroup("number_toggle", { clear = true })

-- enable relative numbers when entering a buffer/window or leaving insert mode
vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
  {
    group = numbertoggle,
    pattern = "*",
    callback = function()
      if vim.wo.number and vim.fn.mode() ~= "i" then
        -- buffnr
        vim.wo.relativenumber = true
      end
    end,
  }
)

-- disable relative numbers when leaving a buffer/window or entering insert mode
vim.api.nvim_create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
  {
    group = numbertoggle,
    pattern = "*",
    callback = function()
      if vim.wo.number then
        vim.wo.relativenumber = false
      end
    end,
  }
)

