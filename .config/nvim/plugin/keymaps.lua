local set = vim.keymap.set

set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Source current line" })
set("v", "<leader>x", "<cmd>lua<CR>", { desc = "Source current selection" })

set("n", "<Esc>", "<cmd>nohlsearch<CR>")

set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

set("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Quickfix list next entry" })
set("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Quickfix list previous entry" })

set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Open Mini.files" })


set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
