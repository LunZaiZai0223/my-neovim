-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
      false
    )
  end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- https://www.reddit.com/r/neovim/comments/jy08md/multiple_languageserver_choose_format/
  -- 如果是特定的 lsp server 就不要用 lsp 內建的 format，而是用 null-ls 設定的
  if client.name == "tsserver" then                                                                             
    --   client.server_capabilities.document_formatting = false -- 0.7 and earlier
    client.resolved_capabilities.document_formatting = false
  end

  lsp_highlight_document(client)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

end

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Disable underline, it's very annoying
  underline = false,
  -- Enable virtual text, override spacing to 4
  virtual_text = { spacing = 4, prefix = ''},
  -- find more here: https://www.nerdfonts.com/cheat-sheet
  -- Use a function to dynamically turn signs off
  -- and on, using buffer local variables
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Diagnostic signs
local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(diagnostic_signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- luasnip setup
local luasnip = require ('luasnip')

-- lspkind
local lspkind = require('lspkind')

-- nvim-cmp setup
local cmp = require ('cmp')

-- spell cmp
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
  { name = 'path' },
  { name = 'buffer', keyword_length = 5},
  { name = "spell" },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      menu = {
        buffer = '[BUF]',
        nvim_lsp = '[LSP]',
        path = '[PATH]',
        spell = '[SPELL]',
      },
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

-- languags setup
-- NOTE: 如果遇到 LSP 錯誤就看/Users/liuweilun/.cache/nvim/lsp.log
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'cssls', 'emmet_ls', 'vuels', 'jsonls', 'angularls' }

-- for _, lsp in pairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
-- end

local project_library_path = "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules"
local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path, "node", "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules/@angular/language-server", "/Users/liuweilun/.nvm/versions/node/v16.14.0/lib/node_modules/typescript"}

-- angular setup 
-- NOTE: 需要特別設定 project_library_path 以及 cmd
-- ref.: https://www.reddit.com/r/neovim/comments/qtu5wa/cant_get_angular_language_server_work/
-- NOTE: angular typescript 目前無法正確地透過 lsp rename 需要重新寫 lsp config ...
-- ref.: https://github.com/neovim/nvim-lspconfig/issues/1836
require'lspconfig'.angularls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = cmd,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}


-- javascript and typescript setup
require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

-- css and scss setup
require'lspconfig'.cssls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

-- html setup
require'lspconfig'.emmet_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

-- vue setup
require'lspconfig'.vuels.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

-- json setup
require'lspconfig'.jsonls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

