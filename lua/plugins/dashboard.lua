return {
	{
		"folke/snacks.nvim",
		opts = function(_, opts)
			local header_path = vim.fn.stdpath("config") .. "/lua/plugins/header.txt"
			local header = nil
			if vim.fn.filereadable(header_path) == 1 then
				local lines = vim.fn.readfile(header_path)
				for i, line in ipairs(lines) do
					lines[i] = line:gsub("\r$", "")
				end
				header = table.concat(lines, "\n")
			end

			opts.dashboard = opts.dashboard or {}
			opts.dashboard.preset = opts.dashboard.preset or {}
			if header and header ~= "" then
				opts.dashboard.preset.header = header
			end
		end,
	},
}
