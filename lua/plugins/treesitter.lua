-- code highlighting and formatting
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			ensure_intalled = "maintained",
			highlight = { enable = true },
			indent = { enable = true },
			fold = { enable = true },
		})
	end
}
