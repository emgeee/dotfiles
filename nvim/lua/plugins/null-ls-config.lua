-- Builtin sources here https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.completion.spell,
    -- require("null-ls").builtins.diagnostics.write_good,
    require("null-ls").builtins.diagnostics.codespell,
    -- Python
    require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.isort,
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

  },
})
