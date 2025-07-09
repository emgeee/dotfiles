-- Language Server Configuration
-- Use :LspInfo to view current status of various language servers
-- most of this config is ripped from https://github.com/kabouzeid/dotfiles/blob/master/nvim/lua/lsp-settings.lua

-- vim.lsp.set_log_level("debug")
-- check logs with :lua vim.cmd('vs'..vim.lsp.get_log_path())
-- :LspLog can help troubleshoot issues

-- Map :Format to vim.lsp.buf.formatting()
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format()
end, { desc = "Format the current file" })

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "× ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

-- LSP settings
local on_attach = function(_client, bufnr)
	local opts = function(desc)
		return { desc = desc, noremap = true, buffer = bufnr }
	end
	-- vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
	-- vim.keymap.set('n', 'gd', function () vim.lsp.buf.definition() end, opts)
	-- vim.keymap.set('n', 'gd', function () vsplit | vim.lsp.buf.definition() end, opts)
	-- vim.keymap.set('n', 'gy', function () vim.lsp.buf.type_definition() end, opts)
	-- vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)

	-- vim.keymap.set('n', 'gr', function () vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "grn", function()
		vim.lsp.buf.rename()
	end, opts("rename symbol (LSP)"))
	-- vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
	-- vim.keymap.set('n', '<C-k>', function () vim.lsp.buf.signature_help() end, opts)
	-- vim.keymap.set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
	-- vim.keymap.set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
	-- vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	-- vim.keymap.set('n', 'gca', function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts("goto previous error (diagnostics)"))
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts("goto next error (diagnostics)"))
	-- vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, opts)

	local bi = function()
		return require("telescope.builtin")
	end

	-- Mappings for Telescope
	vim.keymap.set("n", "gd", function()
		bi().lsp_definitions()
	end, opts("goto definition, same buffer (LSP)(Telescope)"))
	vim.keymap.set("n", "gD", function()
		bi().lsp_definitions({ jump_type = "vsplit" })
	end, opts("goto definition, vertical split (LSP)(Telescope)"))

	vim.keymap.set("n", "gs", function()
		bi().lsp_document_symbols()
	end, opts("show document symbols (LSP)(Telescope)"))
	vim.keymap.set("n", "gws", function()
		bi().lsp_workspace_symbols()
	end, opts("show workspace symbols (LSP)(Telescope)"))
	vim.keymap.set("n", "gr", function()
		bi().lsp_references()
	end, opts("show references (LSP)(Telescope)"))
	vim.keymap.set("n", "gy", function()
		bi().lsp_type_definitions()
	end, opts("show type definitions (LSP)(Telescope)"))
	vim.keymap.set("n", "gi", function()
		bi().lsp_implementations()
	end, opts("show implementations (LSP)(Telescope)"))
	vim.keymap.set("n", "gco", function()
		bi().lsp_outgoing_calls()
	end, opts("show outgoing calls (LSP)(Telescope)"))
	vim.keymap.set("n", "gci", function()
		bi().lsp_incoming_calls()
	end, opts("show incoming calls (LSP)(Telescope)"))

	-----------------------
	-- Mappings for lspsaga
	-----------------------
	vim.keymap.set("n", "K", function()
		require("lspsaga.hover"):render_hover_doc()
	end, opts("hover docs (lspsaga)"))

	vim.keymap.set("n", "<leader>K", function()
		require("lspsaga.hover"):render_hover_doc({ "++keep" })
	end, opts("hover docs (lspsaga)"))
	-- vim.keymap.set('n', 'grn', '<cmd>Lspsaga rename<CR>', opts)
	vim.keymap.set("n", "gca", "<cmd>Lspsaga code_action<CR>", opts("code action (lspsaga)"))
	vim.keymap.set("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>", opts("show line diagnostics (lspsaga)"))

	-- Format file
	vim.keymap.set("n", "<leader>ff", function()
		vim.lsp.buf.format()
	end, { desc = "Format file (LSP)" })

	-- highlights instances of the same word under the cursor
	require("illuminate").on_attach(_client)

	-- toggle inlayed types
	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) -- Default to true for current buffer
	vim.keymap.set("n", "<leader>st", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
	end, { desc = "toggle show types (LSP)" })
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
		"shfmt", -- format bash
		"luacheck",
		"xmlformatter",
		"taplo", -- TOML
		-- "rust-analyzer",
		"codelldb", -- VSCode lldb
		"cpptools", -- Needed for rust
	},
})

-- Mason-lspconfig helps bridge the gap between Mason and native LSP client
-- Install LSP clients with mason and then configure them to work with nvim-lspconfig
local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_status_ok then
	vim.notify("Couldn't load Mason-LSP-Config" .. mason_lspconfig, vim.log.levels.ERROR)
	return
end
mason_lspconfig.setup({
	automatic_enable = true,
})

-- cmp config -- we need to advertise to LSP servers additional features supported by the cmp complete plugin
local cmp_nvim_lsp_okay, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_okay then
	vim.notify("Couldn't load cmp_nvim_lsp" .. mason_lspconfig, vim.log.levels.ERROR)
	return
end
local capabilities = cmp_nvim_lsp.default_capabilities()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	vim.notify("Couldn't load LSP-Config" .. lspconfig, vim.log.levels.ERROR)
	return
end

local opts = {
	on_attach = on_attach,
	capabilities = capabilities,
}

lspconfig.rust_analyzer.setup({
  on_attach = function(client, bufrn)
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

-- Information for configuration various lsp servers: :h lspconfig-all
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- Note: mason-lspconfig v2.0.0 removed setup_handlers() function
-- LSP servers are now auto-enabled by default with automatic_enable = true
-- Manual server configuration below:

-- Default setup for most servers (previously handled by default handler)
local servers = {
	"bashls",
	"gopls",
	"ts_ls",
	"jsonls",
	"marksman",
	"vimls",
	"taplo",
}

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = opts.on_attach,
		capabilities = opts.capabilities,
	})
end

-- Lua LSP specific configuration
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

-- Pyright specific configuration
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

-- BasedPyright specific configuration
lspconfig.basedpyright.setup({
	on_attach = function(client, bufrn)
		-- client.resolved_capabilities.hover = false
		opts.on_attach(client, bufrn)
	end,
	capabilities = opts.capabilities,
	settings = {
		basedpyright = {
			-- typeCheckingMode = "standard",
			disableOrganizeImports = true, -- Use ruff instead
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
		python = {
			analysis = {
				-- Ignore all files for analysis to exclusively use Ruff for linting
				ignore = { "*" },
			},
		},
	},
})

-- Ruff LSP configuration
lspconfig.ruff.setup({
	on_attach = function(client, bufrn)
		-- From documentation:
		-- Note that if you're using Ruff alongside another LSP (like Pyright), you may want to defer to that LSP for certain capabilities, like textDocument/hover
		client.server_capabilities.hoverProvider = false

		opts.on_attach(client, bufrn)
	end,
	init_options = {
		settings = {
			-- Any extra CLI arguments for `ruff` go here.
			args = {},
		},
	},
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
