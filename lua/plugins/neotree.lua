return {
	"folke/snacks.nvim",
	---@module "snacks"
	---@class snacks.Config
	opts = {
		picker = {
			sources = {
				explorer = {
					hidden = true,
					ignored = false,
					layout = { layout = { position = "right" } },
				},
			},
		},
	},
}
