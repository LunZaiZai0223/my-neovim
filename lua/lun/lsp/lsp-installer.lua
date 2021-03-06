-- local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
-- if not status_ok then
-- 	return
-- end
--
--
-- local project_library_path = "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules"
-- local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path, "node", "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules/@angular/language-server", "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules/typescript"}
--
-- -- Register a handler that will be called for all installed servers.
-- -- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
-- 	local opts = {
-- 		-- on_attach = require("lua/lun/lsp").on_attach,
-- 		capabilities = require("lua/lun/lsp/handlers.lua").capabilities,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
-- 	}
--
--   local opts_angular = {
-- 		on_attach = require("./handlers.lua").on_attach,
-- 		capabilities = require("./handlers.lua").capabilities,
--     cmd = cmd,
--     on_new_config = function(new_config,new_root_dir)
--       new_config.cmd = cmd
--     end,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
--
-- 	 if server.name == "jsonls" then
-- 	 	local jsonls_opts = require("./settings/jsonls.lua")
-- 	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
-- 	 end
--
--   if server.name == "angularls" then
--     -- on_attach = require("./handlers.lua").on_attach,
--     -- capabilities = require("./handlers.lua").capabilities,
--     -- cmd = cmd,
--     -- on_new_config = function(new_config,new_root_dir)
--     --   new_config.cmd = cmd
--     -- end
-- 	 	opts = vim.tbl_deep_extend("force", opts_angular)
--   end
--
-- 	-- This setup() function is exactly the same as lspconfig's setup function.
-- 	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- 	server:setup(opts)
-- end)
