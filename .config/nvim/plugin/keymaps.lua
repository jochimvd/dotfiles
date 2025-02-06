local set = vim.keymap.set

set("n", "<space><space>x", "<cmd>source %<CR>")
set("n", "<space>x", ":.lua<CR>")
set("v", "<space>x", ":lua<CR>")

set("n", "<M-j>", "<cmd>cnext<CR>")
set("n", "<M-k>", "<cmd>cprev<CR>")

set("n", "-", "<cmd>lua MiniFiles.open()<CR>")


set("t", "<esc><esc>", "<c-\\><c-n>")
