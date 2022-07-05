-- require("null-ls").setup({
--   sources = {
--     -- require("null-ls").builtins.formatting.stylua,
--     require("null-ls").builtins.diagnostics.eslint_d,
--     -- require("null-ls").builtins.completion.spell,
--   },
-- })

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- 公司會用的 prettier setting:
-- "--print-width 120", "--arrow-parens avoid", "--prose-wrap=preserve", "--trailing-comma=es5"
local sources = {
  -- 如果沒有引入 eslint 就先關掉
  -- diagnostics.eslint_d,
  formatting.prettier.with({
    extra_args = {
      "--single-quote","--print-width=120", "--prose-wrap=preserve", "--trailing-comma=es5"
    }
  }),
  formatting.stylua,
}

null_ls.setup({
  sources = sources,
  -- format on save
  -- https://www.youtube.com/watch?v=ryxRpKpM9B4
  -- on_attach = function(client)
  --   if client.resolved_capabilities.document_formatting then
  --     vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  --   end
  -- end
})

