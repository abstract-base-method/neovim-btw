-- the plugin that almost single handedly makes me neovim
return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			local builtin = require("telescope.builtin")
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"%.git/",
						"%node_modules/",
					},
					pickers = {
						find_files = {
							hidden = true,
						},
						buffers = {
							show_all_buffers = true,
							mappings = {
								i = {
									["<C-d>"] = "delete_buffer",
								},
								n = {
									["<C-d>"] = "delete_buffer",
								},
							},
						},
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
