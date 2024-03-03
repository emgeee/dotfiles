-- Builtin sources here https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
require("null-ls").setup({
  debug = true,
  sources = {
    require("null-ls").builtins.completion.spell,
    -- require("null-ls").builtins.diagnostics.write_good,
    require("null-ls").builtins.diagnostics.codespell,
    -- Python
    require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.isort,
    require("null-ls").builtins.diagnostics.flake8,
    -- require("null-ls").builtins.diagnostics.mypy,
    -- require("null-ls").builtins.diagnostics.pydocstyle,
    -- require("null-ls").builtins.diagnostics.pylint.with({
    --   extra_args={"--disable=C0111"}
    -- }),
    -- Lua
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.diagnostics.luacheck.with({
      extra_args={"--globals vim"},
    }),
    --
    require("null-ls").builtins.formatting.gofmt,
    require("null-ls").builtins.formatting.shfmt,
    require("null-ls").builtins.formatting.fixjson,
    require("null-ls").builtins.code_actions.eslint_d,
    require("null-ls").builtins.formatting.prettierd,
    require("null-ls").builtins.diagnostics.yamllint.with({
      args={ "--format", "parsable", "-d", "{extends: relaxed, rules: {line-length: {max: 180}}}", "-"},
    }),
  },
})