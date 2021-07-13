
return function(mode, key, result, opts)
  -- silent defaults to true
  opts = opts or {noremap = true, silent=true}

  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    opts
  )
end

