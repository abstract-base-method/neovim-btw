return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			{
				"folke/snacks.nvim",
				opts = function(_, opts)
					opts.input = opts.input or {}
					opts.picker = opts.picker or {}
					opts.terminal = opts.terminal or {}
					return opts
				end,
			},
		},
		config = function()
			local opencode = require("opencode")

			vim.g.opencode_opts = vim.g.opencode_opts or {}
			vim.o.autoread = true

			local map = vim.keymap.set

			map({ "n", "x" }, "<C-a>", function()
				opencode.ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })

			map({ "n", "x" }, "<C-x>", function()
				opencode.select()
			end, { desc = "Execute opencode action…" })

			map({ "n", "t" }, "<C-.>", function()
				opencode.toggle()
			end, { desc = "Toggle opencode" })

			map({ "n", "x" }, "go", function()
				return opencode.operator("@this ")
			end, { expr = true, desc = "Add range to opencode" })

			map("n", "goo", function()
				return opencode.operator("@this ") .. "_"
			end, { expr = true, desc = "Add line to opencode" })

			map("n", "<S-C-u>", function()
				opencode.command("session.half.page.up")
			end, { desc = "opencode half page up" })

			map("n", "<S-C-d>", function()
				opencode.command("session.half.page.down")
			end, { desc = "opencode half page down" })

			map("n", "+", "<C-a>", { desc = "Increment", noremap = true })
			map("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
		end,
	},
}
