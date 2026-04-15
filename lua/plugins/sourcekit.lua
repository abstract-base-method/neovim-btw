return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local util = require("lspconfig.util")

      local function resolve_cmd()
        if vim.fn.executable("sourcekit-lsp") == 1 then
          return { "sourcekit-lsp" }
        end

        if vim.fn.executable("xcrun") == 1 then
          local found = vim.fn.systemlist({ "xcrun", "--find", "sourcekit-lsp" })[1]
          if found and found ~= "" and vim.fn.executable(found) == 1 then
            return { found }
          end
        end

        local xcode_path = "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"
        if vim.fn.executable(xcode_path) == 1 then
          return { xcode_path }
        end
      end

      local function root_dir(fname)
        local root = util.root_pattern("Package.swift", ".git")(fname)
        if root then
          return root
        end

        return util.search_ancestors(fname, function(dir)
          for _, pattern in ipairs({ "*.xcodeproj", "*.xcworkspace" }) do
            local match = vim.fn.glob(util.path.join(dir, pattern))
            if match ~= "" then
              return dir
            end
          end
        end) or util.path.dirname(fname)
      end

      local cmd = resolve_cmd()

      opts.servers = opts.servers or {}
      opts.servers.sourcekit = {
        mason = false,
        enabled = cmd ~= nil,
        cmd = cmd,
        filetypes = { "swift", "objective-c", "objective-cpp" },
        root_dir = root_dir,
        on_new_config = function(config)
          if not config.cmd or vim.fn.executable(config.cmd[1]) == 0 then
            config.enabled = false
          end
        end,
      }

      opts.setup = opts.setup or {}
      opts.setup.sourcekit = function(server, server_opts)
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)

        if server_opts.enabled ~= false and cmd then
          local filetypes = server_opts.filetypes or { "swift" }
          local started_roots = {}

          local function root_from_path(path)
            return server_opts.root_dir and server_opts.root_dir(path) or util.path.dirname(path)
          end

          local function find_roots_in_dir(dir)
            local roots = {}

            local function add(path)
              if path and path ~= "" then
                roots[path] = true
              end
            end

            if util.path.exists(util.path.join(dir, "Package.swift")) then
              add(dir)
            end

            for _, path in ipairs(vim.fn.glob(util.path.join(dir, "*/Package.swift"), false, true)) do
              add(util.path.dirname(path))
            end

            for _, path in ipairs(vim.fn.glob(util.path.join(dir, "*.xcodeproj"), false, true)) do
              add(util.path.dirname(path))
            end

            for _, path in ipairs(vim.fn.glob(util.path.join(dir, "*.xcworkspace"), false, true)) do
              add(util.path.dirname(path))
            end

            return roots
          end

          local function make_config(root)
            return vim.tbl_deep_extend(
              "force",
              {},
              opts.servers["*"] or {},
              server_opts,
              {
                name = server,
                root_dir = root,
                workspace_folders = { { uri = vim.uri_from_fname(root), name = root } },
              }
            )
          end

          local function start_for_root(root)
            if not root or root == "" then
              return
            end

            local existing = started_roots[root]
            if existing then
              local client = vim.lsp.get_client_by_id(existing)
              if client and not client.is_stopped() then
                return existing
              end
            end

            local config = make_config(root)
            if config.enabled == false or not config.cmd then
              return
            end

            local client_id = vim.lsp.start_client(config)
            if client_id then
              started_roots[root] = client_id
              return client_id
            end
          end

          local function maybe_attach(bufnr)
            if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
              return
            end

            if not vim.tbl_contains(filetypes, vim.bo[bufnr].filetype) then
              return
            end

            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root = root_from_path(fname)
            local client_id = start_for_root(root)

            if client_id then
              vim.lsp.buf_attach_client(bufnr, client_id)
            end
          end

          vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function(event)
              maybe_attach(event.buf)
            end,
          })

          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            maybe_attach(bufnr)
          end

          local function start_for_cwd()
            local cwd = vim.fn.getcwd()
            local roots = find_roots_in_dir(cwd)

            if vim.tbl_isempty(roots) then
              local fallback = root_from_path(cwd)
              if fallback and fallback ~= "" then
                roots[fallback] = true
              end
            end

            for root in pairs(roots) do
              start_for_root(root)
            end
          end

          vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
            callback = start_for_cwd,
          })

          start_for_cwd()
        end

        return true
      end

      return opts
    end,
  },
}
