return function(mode, key, result, opts)
  -- silent defaults to true
  opts = opts or { noremap = true, silent = true }

  vim.keymap.set(
    mode,
    key,
    result,
    opts
  )
end
