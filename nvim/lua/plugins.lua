return {
  --
  -- UI pluginConfigs
  --
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      --Set colorscheme (order is important here)
      vim.o.termguicolors = true

      require("tokyonight").setup({
        style = "night",
      })
      require("tokyonight").load()
    end,
  },
  -- {
  --   "navarasu/onedark.nvim",
  --   priority = 1000,
  --   config = function()
  --     --Set colorscheme (order is important here)
  --     vim.o.termguicolors = true
  --     vim.g.onedark_terminal_italics = 2
  --
  --     require("onedark").setup({
  --       style = "deep",
  --     })
  --     require("onedark").load()
  --   end,
  -- },

  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",

  -- Git commands in nvim
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  {
    "jdhao/better-escape.vim",
    event = "InsertEnter",
    config = function()
      vim.g.better_escape_interval = 300
      vim.g.better_escape_shortcut = { "jk" }
    end,
  },

  -- better quickfix window
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  -- Treesitter
  -- Rune :TSUpdate to update language definitions
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require("pluginConfigs.treesitter")
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "RRethy/nvim-treesitter-textsubjects" },
  { "nvim-treesitter/playground" },

  -- Mason config
  -- Mason is a tool for managing and installing LSP clients, linters, formatters etc
  -- Installs clients to directory :lua print(vim.fn.stdpath("data"))
  -- Full list of language servers: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
  {
    "williamboman/mason.nvim",
    config = true,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "williamboman/mason-lspconfig.nvim",
      "RRethy/vim-illuminate", -- illuminate works under the cursor
      "scalameta/nvim-metals", -- Scala metals integration
    },
    config = function()
      require("pluginConfigs.lspconfig")
    end,
  },

  -- Works by combining inputs from different sources to generate autocomplete
  {
    "hrsh7th/nvim-cmp",
    -- requires a list of different sources
    dependencies = {
      {
        -- snippets engine
        "hrsh7th/vim-vsnip",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      "hrsh7th/cmp-vsnip", -- source for snippets
      "hrsh7th/cmp-nvim-lsp", -- source for builtin lsp
      "hrsh7th/cmp-buffer", -- source for words in buffers
      "hrsh7th/cmp-path", -- source for file system path
      "hrsh7th/cmp-cmdline", -- source for vims cmd line
      "hrsh7th/cmp-nvim-lua", -- nvim lua completion
      "onsails/lspkind.nvim", -- adds vscode-like pictograms to complete menu
    },
    config = function()
      require("pluginConfigs.cmp-config")
    end,
  },

  -- Support for linters
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("pluginConfigs.null-ls-config")
    end,
  },

  -- Open diagnostic pane with :Trouble
  {
    "folke/trouble.nvim",
    config = true,
    cmd = "Trouble",
  },

  -- UI to select things (files, grep results, open buffers...)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" },
      { "junegunn/fzf" },
    },
    config = function()
      require("pluginConfigs.telescope-config")
    end,
  },

  -- mostly used for a pretty LSP hover functionality
  -- hotkeys specified in lspconfig.lua
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = true,
  },

  { "mileszs/ack.vim" },

  --
  -- Session management
  --
  {
    "rmagatti/auto-session",
    config = true,
  },
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session" },
    config = true,
  },

  -- Status line plugin
  {
    "hoob3rt/lualine.nvim",
    config = function()
      require("pluginConfigs.lualine-config")
    end,
  },

  -- file tree
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("pluginConfigs.tree-config")
    end,
  },

  -- :SymbolsOutline to open window
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        keymaps = {
          close = { "q" }, -- Keep pressing esc by accident so unbind it
        },
      })

      vim.api.nvim_create_user_command("Outline", "SymbolsOutline", {})
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { noremap = true })
    end,
  },

  -- Add indentation guides even on blank lines
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup({
        char = "┊",
        buftype_exclude = { "terminal", "nofile" },
        filetype_exclude = { "help", "terminal", "dashboard", "lazy" },
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },

  -- Add git related info in the signs columns and popups
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = true,
  },

  --
  -- Navigation
  --
  {
    "https://gitlab.com/yorickpeterse/nvim-window.git",
    config = function()
      require("pluginConfigs.window-config")
    end,
  },

  -- Automatic tags management
  -- {
  --   'ludovicchabant/vim-gutentags',
  --   config=function()
  --     require('pluginConfigs.gutentags')
  --   end
  -- },

  --
  -- MISC
  --

  -- Hack
  {
    "stevearc/stickybuf.nvim",
    config = function()
      require("stickybuf").setup({
        -- filetype = {
        --   outline = "filetype",
        -- },
      })
    end,
  },

  -- Intelligently set the root directory
  "airblade/vim-rooter",

  -- surround things
  "tpope/vim-surround",
  "tpope/vim-repeat",

  -- Enable editorconfig in vim
  "editorconfig/editorconfig-vim",

  -- Comment plugin
  "tomtom/tcomment_vim",
  -- Press <c-_><c-_> to comment lines
  -- Press <c-_>i for inline commenting

  {
    "windwp/nvim-autopairs",
    config = function()
      require("pluginConfigs.autopairs")
    end,
  },

  {
    "fatih/vim-go",
    ft = "go",
    config = function()
      require("pluginConfigs.go-config")
    end,
  },

  -- Syntax highlighting for kitty config file
  {
    "fladson/vim-kitty",
    ft = "kitty",
  },

  -- Lua replit run :Luadev
  { "bfredl/nvim-luadev", cmd = "Luadev" },
}
