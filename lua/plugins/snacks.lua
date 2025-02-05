return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = {
				enabled = true,
				layout = {
					layout = {
						position = "right",
					},
				},
			},
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		keys = {
			{ "<leader>sf", function() Snacks.picker.files() end,               desc = "Find files" },
			{ "<leader>sb", function() Snacks.picker.buffers() end,             desc = "Find buffer" },
			{ "<leader>sg", function() Snacks.picker.grep() end,                desc = "Search Grep" },
			{ "<leader>fs", function() Snacks.picker.explorer() end,            desc = "file explorer" },
			{ "<leader>gd", function() Snacks.picker.lsp_definitions() end,     desc = "LSP Definitions" },
			{ "<leader>gD", function() Snacks.picker.lsp_declarations() end,    desc = "LSP Declarations" },
			{ "<leader>gr", function() Snacks.picker.lsp_definitions() end,     desc = "LSP References" },
			{ "<leader>gI", function() Snacks.picker.lsp_implementations() end, desc = "LSP Implementations" },
			{ "<leader>z",  function() Snacks.zen() end,                        desc = "Toggle Zen Mode" },
			{ "<leader>Z",  function() Snacks.zen.zoom() end,                   desc = "Toggle Zoom" },
			{ "<leader>.",  function() Snacks.scratch() end,                    desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end,             desc = "Select Scratch Buffer" },
			{ "<leader>n",  function() Snacks.notifier.show_history() end,      desc = "Notification History" },
			{ "<leader>bd", function() Snacks.bufdelete() end,                  desc = "Delete Buffer" },
			{ "<leader>gB", function() Snacks.gitbrowse() end,                  desc = "Git Browse",                  mode = { "n", "v" } },
			{ "<leader>gb", function() Snacks.git.blame_line() end,             desc = "Git Blame Line" },
			{ "<leader>gf", function() Snacks.lazygit.log_file() end,           desc = "Lazygit Current File History" },
			{ "<leader>gg", function() Snacks.lazygit() end,                    desc = "Lazygit" },
			{ "<leader>gl", function() Snacks.lazygit.log() end,                desc = "Lazygit Log (cwd)" },
			{ "<leader>un", function() Snacks.notifier.hide() end,              desc = "Dismiss All Notifications" },
			{ "<leader>t",  function() Snacks.terminal() end,                   desc = "Toggle Terminal" },
			{ "<c-_>",      function() Snacks.terminal() end,                   desc = "which_key_ignore" },
			{ "]]",         function() Snacks.words.jump(vim.v.count1) end,     desc = "Next Reference",              mode = { "n", "t" } },
			{ "[[",         function() Snacks.words.jump(-vim.v.count1) end,    desc = "Prev Reference",              mode = { "n", "t" } },
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			}
		},
	}
}
