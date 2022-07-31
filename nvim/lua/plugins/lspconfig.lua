-- Language Server Configuration
-- Use :LspInfo to view current status of various language servers
-- most of this config is ripped from https://github.com/kabouzeid/dotfiles/blob/master/nvim/lua/lsp-settings.lua


-- vim.lsp.set_log_level("debug")
-- check logs with :lua vim.cmd('vs'..vim.lsp.get_log_path())

-- LSP settings
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- require('utils.callbacks')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
 
  -- Map :Format to vim.lsp.buf.formatting()
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

-- Mason config
-- Mason is a tool for managing and installing LSP clients, linters, formatters etc
-- Installs clients to directory :lua print(vim.fn.stdpath("data"))
-- Full list of language servers: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require("mason").setup()

--  Small plugin to ensure various formatters are installed
require'mason-tool-installer'.setup({
  ensure_installed={
    "lua-language-server",
    "yaml-language-server",
    "vim-language-server",
    "gopls",
    "pyright",
    "typescript-language-server",
    "json-lsp",
    "bash-language-server",
    "marksman", -- Markdown
    "shfmt", -- format bash
    "luacheck",
  }
})

-- Mason-lspconfig helps bridge the gap between Mason and native LSP client
local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_status_ok then
  vim.notify("Couldn't load Mason-LSP-Config" .. mason_lspconfig, "error")
  return
end
mason_lspconfig.setup({})


-- cmp config -- we need to advetise to LSP servers additional features supported by the cmp complete plugin
local cmp_nvim_lsp_okay, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_okay then
  vim.notify("Couldn't load cmp_nvim_lsp" .. mason_lspconfig, "error")
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)


local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.notify("Couldn't load LSP-Config" .. lspconfig, "error")
  return
end

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- Default handler (optional)
    lspconfig[server_name].setup {
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
    }
  end,

  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,

      settings = {
        Lua = {
          -- Tells Lua that a global variable named vim exists to not have warnings when configuring neovim
          diagnostics = {
            globals = { "vim" },
          },

          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,

  ["pyright"] = function()
    lspconfig.pyright.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,

      settings = {
        python = {
          analysis = {
            -- Disable strict type checking
            typeCheckingMode = "off"
          }
        }
      },
    })
  end,
})
