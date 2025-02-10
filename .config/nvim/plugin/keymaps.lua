local set = vim.keymap.set

set("n", "<leader>xf", "<cmd>source %<CR>", { desc = "Source current file" })
set("n", "<leader>xs", "<cmd>.lua<CR>", { desc = "Source current line" })
set("v", "<leader>xs", "<cmd>lua<CR>", { desc = "Source current selection" })

set("n", "<Esc>", "<cmd>nohlsearch<CR>")

set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open Mini.files" })

set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
