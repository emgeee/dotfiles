-- Language Server Configuration
-- Use :LspInfo to view current status of various language servers
-- most of this config is ripped from https://github.com/kabouzeid/dotfiles/blob/master/nvim/lua/lsp-settings.lua

-- vim.lsp.set_log_level("debug")
-- check logs with :lua vim.cmd('vs'..vim.lsp.get_log_path())

-- Map :Format to vim.lsp.buf.formatting()
vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format()
end, {})

-- LSP settings
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- require('utils.callbacks')

  local opts = { noremap = true, buffer = bufnr }
  -- vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  -- vim.keymap.set('n', 'gd', function () vim.lsp.buf.definition() end, opts)
  -- vim.keymap.set('n', 'gd', function () vsplit | vim.lsp.buf.definition() end, opts)
  -- vim.keymap.set('n', 'gy', function () vim.lsp.buf.type_definition() end, opts)
  -- vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)

  -- vim.keymap.set('n', 'gr', function () vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "grn", function()
    vim.lsp.buf.rename()
  end, opts)
  -- vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set('n', '<C-k>', function () vim.lsp.buf.signature_help() end, opts)
  -- vim.keymap.set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
  -- vim.keymap.set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  -- vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  -- vim.keymap.set('n', 'gca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next()
  end, opts)
  -- vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, opts)

  -- Mappings for Telescope
  vim.keymap.set("n", "gd", function()
    require("telescope.builtin").lsp_definitions()
  end, opts)
  vim.keymap.set("n", "gD", function()
    require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
  end, opts)
  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
  end, opts)
  vim.keymap.set("n", "gy", function()
    require("telescope.builtin").lsp_type_definitions()
  end, opts)
  vim.keymap.set("n", "gi", function()
    require("telescope.builtin").lsp_implementations()
  end, opts)
  vim.keymap.set("n", "gco", function()
    require("telescope.builtin").lsp_outgoing_calls()
  end, opts)
  vim.keymap.set("n", "gci", function()
    require("telescope.builtin").lsp_incoming_calls()
  end, opts)

  -- Mappings for lspsaga
  vim.keymap.set("n", "K", function()
    require("lspsaga.hover"):render_hover_doc()
  end, opts)
  -- vim.keymap.set('n', 'grn', '<cmd>Lspsaga rename<CR>', opts)
  vim.keymap.set("n", "gca", "<cmd>Lspsaga code_action<CR>", opts)
  vim.keymap.set("n", "<leader>ff", function()
    vim.lsp.buf.format()
  end, opts)

  require("illuminate").on_attach(_client)
end

--  Small plugin to ensure various formatters are installed
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua-language-server",
    "vim-language-server",
    "gopls",
    "typescript-language-server",
    "json-lsp",
    "bash-language-server",
    "marksman", -- Markdown
    "shfmt",  -- format bash
    "luacheck",
    "xmlformatter",
    "rust-analyzer",
  },
})

-- Mason-lspconfig helps bridge the gap between Mason and native LSP client
local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_status_ok then
  vim.notify("Couldn't load Mason-LSP-Config" .. mason_lspconfig, "error")
  return
end
mason_lspconfig.setup({})

-- cmp config -- we need to advertise to LSP servers additional features supported by the cmp complete plugin
local cmp_nvim_lsp_okay, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_okay then
  vim.notify("Couldn't load cmp_nvim_lsp" .. mason_lspconfig, "error")
  return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
    lspconfig[server_name].setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      on_attach = opts.on_attach,
      capabilities = opts.capabilities,
      settings = {
        Lua = {
          -- Tells Lua that a global variable named vim exists to not have warnings when configuring neovim
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
  ["pyright"] = function()
    lspconfig.pyright.setup({
      on_attach = function(client, bufrn)
        -- client.resolved_capabilities.hover = false
        opts.on_attach(client, bufrn)
      end,
      capabilities = opts.capabilities,
      settings = {
        pyright = { autoImportCompletion = true },
        python = {
          analysis = {
            autoSearchPaths = true,
            -- Disable strict type checking
            typeCheckingMode = "off",
          },
        },
      },
    })
  end,
  ["basedpyright"] = function()
    lspconfig.basedpyright.setup({
      on_attach = function(client, bufrn)
        -- client.resolved_capabilities.hover = false
        opts.on_attach(client, bufrn)
      end,
      capabilities = opts.capabilities,
      settings = {
        {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
    })
  end,
  ["jedi_language_server"] = function()
    lspconfig.jedi_language_server.setup({
      on_attach = function(client, bufrn)
        -- client.resolved_capabilities.hover = false
        opts.on_attach(client, bufrn)
      end,
      capabilities = opts.capabilities,
      settings = {},
    })
  end,
  ["rust_analyzer"] = function()
    lspconfig.rust_analyzer.setup({
      on_attach = function(client, bufrn)
        -- client.resolved_capabilities.hover = false
        opts.on_attach(client, bufrn)
      end,
      capabilities = opts.capabilities,
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
          },
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
        },
      },
    })
  end,
})

-- Specific to scala metals

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    local metals_config = require("metals").bare_config()

    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    }

    metals_config.capabilities = capabilities
    metals_config.on_attach = on_attach
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
