-- Builtin sources here https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  vim.notify("Couldn't load none-ls (aka null_ls)" .. null_ls, "error")
  return
end

null_ls.setup({
  debug = true,
  sources = {
    -- null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.codespell,

    -- Python
    null_ls.builtins.diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    -- null_ls.builtins.diagnostics.mypy,

    -- Lua
    null_ls.builtins.formatting.stylua,

    -- Javascript
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.biome,

    -- Misc
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.diagnostics.yamllint.with({
      args = { "--format", "parsable", "-d", "{extends: relaxed, rules: {line-length: {max: 180}}}", "-" },
    }),
  },
})
