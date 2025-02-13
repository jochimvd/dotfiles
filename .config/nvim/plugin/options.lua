local opt = vim.opt

opt.showmode = false

opt.inccommand = "split"
opt.smartcase = true
opt.ignorecase = true

opt.updatetime = 250

opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.scrolloff = 10

opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.shada = { "'10", "<0", "s10", "h" }

opt.swapfile = false

opt.wrap = true
opt.linebreak = true

opt.tabstop = 4
opt.shiftwidth = 4

opt.numberwidth = 3
opt.signcolumn = "yes:1"
opt.statuscolumn = "%l%s"
