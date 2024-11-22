-- if `opts` is specified, it is passed to the `require(<plugin>).setup(opts)` automatically
-- if `config` function is set, `opts` is passed as the second param so you must call setup() manually
-- Ex:
-- config = function(_, opts)
--     ...
-- end

return {
  { "nvim-lua/plenary.nvim" },
  {
    "famiu/bufdelete.nvim",
    config = function()
      vim.keymap.set("n", "<leader>bd", function()
        require("bufdelete").bufdelete(0)
      end, { noremap = true, silent = true, desc = "Buffer delete (preserve layout)" })
    end,
  },
  {
    --- https://github.com/folke/neodev.nvim
    "folke/neodev.nvim",
    opts = {
      library = { plugins = { "neotest" }, types = true },
    },
  },
  {
    "jdhao/better-escape.vim",
    event = "InsertEnter",
    config = function()
      vim.g.better_escape_interval = 300
      vim.g.better_escape_shortcut = { "jk" }
    end,
  },

  -- better quickfix window
  {
    --- https://github.com/kevinhwang91/nvim-bqf
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- Mason config
  -- Mason is a tool for managing and installing LSP clients, linters, formatters etc
  -- Installs clients to directory :lua print(vim.fn.stdpath("data"))
  -- Full list of language servers: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
  {
    "williamboman/mason.nvim",
    opts = {
      -- Use the tools on PATH before using any installed by Mason.
      -- This should allow neovim to use the same rust-analyzer binary that's managed via rustup
      -- which should mean rust doesn't need to constantly build/recompile when switching between them
      PATH = "append",
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "williamboman/mason-lspconfig.nvim",
      "RRethy/vim-illuminate", -- illuminate works under the cursor
      "scalameta/nvim-metals", -- Scala metals integration
      "hrsh7th/nvim-cmp",      -- Specify completion engine
    },
    config = function()
      require("pluginConfigs.lspconfig")
    end,
  },

  -- Works by combining inputs from different sources to generate autocomplete

  -- Support for linters
  -- none-ls is fork of null-ls (which was deprecated). They didn't change the name
  -- of the package though so everything is imported as 'null-ls'.
  -- This package provides a way to hook in various formatters, linters etc into
  -- neovim's LSP system. This is only needed for plugins/tools that aren't themselves
  -- an lsp server
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("pluginConfigs.null-ls-config")
    end,
  },

  -- Open diagnostic pane with :Trouble
  -- Trouble can also do this - :Trouble symbols
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Project Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {},
  },

  -- mostly used for a pretty LSP hover functionality
  -- hotkeys specified in lspconfig.lua
  -- Note: the plugin seems really powerful
  {
    -- "nvimdev/lspsaga.nvim",
    "emgeee/lspsaga.nvim",
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
      })
      require("lspsaga").setup({
        lightbulb = {
          -- enable = false,
          sign = false,
        },
        -- Currently using dropbar plugin stead
        -- symbol_in_winbar = {
        -- 	enable = false,
        -- },
        implement = {
          enable = false,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- vim.notify backend
  {
    --- https://github.com/j-hui/fidget.nvim
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        override_vim_notify = true,
        window = {
          winblend = 0,
        },
      },
      logger = {
        level = vim.log.levels.INFO,
      },
    },
  },

  -- Add indentation guides even on blank lines
  {
    --- https://github.com/lukas-reineke/indent-blankline.nvim
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    event = "BufRead",
    config = function()
      require("ibl").setup({
        indent = { char = "┊" },
        exclude = {
          filetypes = { "help", "terminal", "dashboard", "lazy" },
          buftypes = { "terminal", "nofile" },
        },
        scope = { show_start = true },
      })
    end,
  },

  --
  -- MISC
  --

  -- Hack
  {
    --- https://github.com/stevearc/stickybuf.nvim
    "stevearc/stickybuf.nvim",
    opts = {},
  },

  -- Intelligently set the root directory
  "airblade/vim-rooter",

  -- surround things
  "tpope/vim-surround",
  "tpope/vim-repeat",

  -- Enable editorconfig in vim
  "editorconfig/editorconfig-vim",

  -- Comment plugin
  {
    --- https://github.com/numToStr/Comment.nvim
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring", -- Required for ts/tsx support
    },
    config = function()
      local opts = {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

        ---LHS of toggle mappings in NORMAL mode
        toggler = {},

        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {},
        extra = {},
      }
      if vim.g.neovide then
        opts.toggler.line = "<C--><C-->"
        opts.toggler.block = "<C-->i"
        opts.opleader.line = "<C--><C-->"
        opts.opleader.block = "<C-->i"
      else
        opts.toggler.line = "<C-_><C-_>"
        opts.toggler.block = "<C-_>i"
        opts.opleader.line = "<C-_><C-_>"
        opts.opleader.block = "<C-_>i"
      end
      require("Comment").setup(opts)
    end,
  },

  {
    --- https://github.com/windwp/nvim-autopairs
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        disable_filetype = { "TelescopePrompt", "vim" },
      })
    end,
  },

  -- Syntax highlighting for kitty config file
  {
    "fladson/vim-kitty",
    ft = "kitty",
  },

  {
    --- https://github.com/davidmh/mdx.nvim
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },

  -- Lua replit run :Luadev
  { "bfredl/nvim-luadev",   cmd = "Luadev" },

  -- Testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rust"),
        },
      })
    end,
  },
}
