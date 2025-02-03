return {
	{
		"eldritch-theme/eldritch.nvim",
		version = "adedead3423c58cc2e2ebf30001fe4055ad0e416", -- specifying the commit hash to pin the version
		lazy = false,
		priority = 1000,                                    -- make sure to load this before all the other start plugins
		config = function()
			require("eldritch").setup({
				palette = "default",
				transparent = true,
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme eldritch]])
		end,
	},

}
