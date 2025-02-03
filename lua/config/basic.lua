-- generic defaults for me
vim.opt.number = true
vim.opt.spell = true
vim.opt.title = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- controversial I know
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- scroll like vs code
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.wo.smoothscroll = true

-- Set folding method to 'expr' (expression)
vim.o.foldmethod = 'expr'
-- Set fold expression to use Treesitter for folding
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
-- Optional: Customize fold settings
vim.o.foldenable = false -- Enable folding by default
vim.o.foldlevel = 99
-- Optional: Automatically fold in certain filetypes
vim.cmd [[
  autocmd FileType * setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
]]
vim.lsp.inlay_hint.enable(true)
