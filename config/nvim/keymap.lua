vim.g.mapleader = " "

local telescope = require("telescope.builtin")
local neogit = require("neogit")

vim.keymap.set("n", "<leader>f", telescope.find_files, { noremap=true, silent=true, })
vim.keymap.set("n", "<leader>p", "\"_dP", { noremap=true, silent=true, })
vim.keymap.set("n", "<leader>q", vim.cmd.qa, { noremap=true, silent=true, })
vim.keymap.set("n", "<leader>gc", function() neogit.open({ "commit" }) end, { noremap=true, silent=true, })
vim.keymap.set("n", "<leader>ga", function() neogit.open({ "stash" }) end, { noremap=true, silent=true, })
vim.keymap.set("n", "<leader>gf", function() neogit.open({ "fetch" }) end, { noremap=true, silent=true, })
vim.keymap.set("n", "<leader>gd", function() neogit.open({ "diff" }) end, { noremap=true, silent=true, })

vim.cmd([[
set completeopt=menuone,noinsert,noselect
highlight! default link CmpItemKind CmpItemMenuDefault
]])
