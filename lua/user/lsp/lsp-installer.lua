local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	 if server.name == "jsonls" then
	 	local jsonls_opts = require("user.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

  if server.name == "angularls" then
    -- angular lsp 需要特別設定，但暫時想不到其他方法，所以就直接先複寫
    -- ref.: https://www.reddit.com/r/neovim/comments/qtu5wa/cant_get_angular_language_server_work/
    local project_library_path = "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules"
    local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path, "node", "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules/@angular/language-server", "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules/typescript"}
    opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      cmd = cmd,
      on_new_config = function(new_config,new_root_dir)
        new_config.cmd = cmd
      end,
    }
  end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
