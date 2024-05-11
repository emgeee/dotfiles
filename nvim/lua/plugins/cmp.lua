return {
  {
    --- https://github.com/hrsh7th/nvim-cmp
    "hrsh7th/nvim-cmp",
    -- requires a list of different sources
    dependencies = {
      {
        -- snippets engine
        "hrsh7th/vim-vsnip",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      "hrsh7th/cmp-vsnip",                   -- source for snippets
      "hrsh7th/cmp-nvim-lsp",                -- source for builtin lsp
      "hrsh7th/cmp-buffer",                  -- source for words in buffers
      "hrsh7th/cmp-path",                    -- source for file system path
      "hrsh7th/cmp-cmdline",                 -- source for vims cmd line
      "hrsh7th/cmp-nvim-lua",                -- nvim lua completion
      "petertriho/cmp-git",
      "onsails/lspkind.nvim",                -- adds vscode-like pictograms to complete menu
      "saecki/crates.nvim",                  -- Adds rust crates completions
    },
    event = { "InsertEnter", "CmdlineEnter" }, -- support lazy loading
    config = function()
      -- :CmpStatus -> Check the status of sources
      -- Note: nvim_lsp is loaded after the first insert
      --
      -- -- Comp setup
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      -- Set completeopt to have a better completion experience
      -- Needed for cmp
      vim.opt.completeopt = "menu,menuone,noselect"

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      cmp.setup({
        enabled = function()
          -- disable completion in comments
          local context = require("cmp.config.context")
          local disabled = false

          disabled = disabled or (vim.fn.reg_recording() ~= "")
          disabled = disabled or (vim.fn.reg_executing() ~= "")

          -- Disable in prompt
          disabled = disabled or (vim.api.nvim_get_option_value("buftype", { scope = "local" }) == "prompt")

          -- Disable in comments
          disabled = disabled or (context.in_treesitter_capture("comment") and vim.bo.filetype ~= "lua")

          return not disabled
        end,
        -- Configure sources, order of sources determines order in completion menu
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" }, -- For vsnip users.
          { name = "path" },
        }, {
          { name = "nvim_lua" },
          { name = "buffer" },
          { name = "crates" },
        }),
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- Down, up, C-n, C-p might not be needed here since the defaults could work?!
          ["<Down>"] = cmp.mapping(
            cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            { "i" }
          ),
          ["<Up>"] = cmp.mapping(
            cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            { "i" }
          ),
          ["<C-n>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(t("<Down>"), "n", true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
          }),
          ["<C-p>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(t("<Up>"), "n", true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
          }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 50,  -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
