local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

-- 公司會用的 prettier setting:
-- "--print-width 120", "--arrow-parens avoid", "--prose-wrap=preserve", "--trailing-comma=es5"
null_ls.setup {
  -- 如果沒有引入 eslint 就先關掉
  -- diagnostics.eslint_d,
  debug = false,
  sources = {
    -- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
    formatting.prettier.with({
      extra_args = {
        "--single-quote", "--print-width=120", "--prose-wrap=preserve", "--trailing-comma=es5", "--arrow-parens=avoid"
      }
    }),
  },
}
