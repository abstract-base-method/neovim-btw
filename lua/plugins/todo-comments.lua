-- make todo comments just a little bit nicer to view
return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = true,
		sign_priority = 8,
		keywords = {
			FIX = {
				icon = " ",
				color = "error",
				alt = { "FIXME", "fixme", "BUG", "bug", "FIXIT", "fixit", "ISSUE", "issue" },
			},
			TODO = { icon = " ", color = "info", alt = { "todo" } },
			HACK = { icon = " ", color = "warning", alt = { "hack" } },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "warn", "warning" } },
			PERF = { icon = " ", alt = { "PERF", "perf", "PERFORMANCE", "performance", "OPTIMIZE", "optimize" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO", "NOTE", "note" } },
			TEST = { icon = "⏲ ", color = "test", alt = { "TESTING" } },
		},
		gui_style = {
			fg = "NONE",
			bg = "BOLD",
		},
	}
}
