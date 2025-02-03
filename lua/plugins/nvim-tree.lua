-- gives a vs-code style file explorer for when I need that
return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 30,
				side = "right",
			}
		})
	end,
}
