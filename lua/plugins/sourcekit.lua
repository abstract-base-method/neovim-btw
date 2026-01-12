return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          cmd = { "xcrun", "sourcekit-lsp" },
          filetypes = { "swift", "objective-c", "objective-cpp" },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("Package.swift", ".git")(fname) or util.path.dirname(fname)
          end,
        },
      },
    },
  },
}
