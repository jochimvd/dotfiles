local set = vim.keymap.set

set("n", "<leader>xf", "<cmd>source %<CR>", { desc = "Source current file" })
set("n", "<leader>xs", "<cmd>.lua<CR>", { desc = "Source current line" })
set("v", "<leader>xs", "<cmd>lua<CR>", { desc = "Source current selection" })

set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
set("n", "-", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", { desc = "Open Mini.files" })
set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected code down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected code up" })
