return {
	{
		"eldritch-theme/eldritch.nvim",
		commit = "c9131a5a11f00a2f428f563a4eb2c4aeb680d963",
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "eldritch",
		},
	},
}
