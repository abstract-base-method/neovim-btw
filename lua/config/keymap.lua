-- kill the current buffer
vim.api.nvim_set_keymap('n', '<leader>kb', ':bd<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>kb!', ':bd!<CR>', { noremap = true, silent = true })

-- split vertically and open a new buffer to the right
vim.api.nvim_set_keymap('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true })

-- split horizontally and open a new buffer below
vim.api.nvim_set_keymap('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true })

-- Create custom key mappings for moving between splits
vim.api.nvim_set_keymap('n', '<leader><Right>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', { noremap = true, silent = true })


-- Check for the operating system
local is_linux = vim.fn.has('unix') == 1 and vim.fn.has('linux') == 1
local is_mac = vim.fn.has('unix') == 1 and vim.fn.has('macunix') == 1

-- system clipboard mappings
if is_linux then
	vim.api.nvim_set_keymap('v', '<leader>y', ':w !xclip -selection clipboard<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>p', ':r !xclip -o -selection clipboard<CR>', { noremap = true, silent = true })
end

if is_mac then
	vim.api.nvim_set_keymap('v', '<leader>y', ':w !pbcopy<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>p', ':r !pbpaste<CR>', { noremap = true, silent = true })
end

-- create keymaps for todo lookup
vim.keymap.set("n", "<leader>tt", ":TodoTelescope<CR>", { noremap = true, silent = true })

-- plugin keymaps
local gitsigns = require("gitsigns")
vim.keymap.set('n', '<leader>gs', gitsigns.preview_hunk, {})
vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line { full = true } end, {})
vim.keymap.set('n', '<leader>gsb', gitsigns.toggle_current_line_blame, {})

vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

vim.keymap.set('n', '<leader>fs', ":NvimTreeToggle<CR>", { silent = true, noremap = true })

local telescopebuiltin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", telescopebuiltin.find_files, {})
vim.keymap.set("n", "<leader>w", telescopebuiltin.buffers, {})
vim.keymap.set("n", "<leader>gg", telescopebuiltin.live_grep, {})
vim.keymap.set("n", "<leader>gr", telescopebuiltin.lsp_references, {})
vim.keymap.set("n", "<leader>gd", telescopebuiltin.lsp_definitions, {})
vim.keymap.set("n", "<leader>gt", telescopebuiltin.lsp_implementations, {})

-- tmux helper for persistent neovim
vim.api.nvim_set_keymap('n', '<leader>rr', ':lua os.exit(1)<CR>', { noremap = true, silent = true })
