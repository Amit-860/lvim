local plugins = {
  -- THEMES
  { 'shaunsingh/nord.nvim' },
  { "EdenEast/nightfox.nvim" },
  { 'sainnhe/edge' },
  {
    'catppuccin/nvim',
    config = function()
      require("catppuccin").setup({

        flavour = "macchiato",
        transparent_background = true,
        term_colors = true,
      })
    end
  },
  { "rebelot/kanagawa.nvim" },
  { 'bluz71/vim-nightfly-colors' },
  { 'mhartington/oceanic-next' },
  { 'rockerBOO/boo-colorscheme-nvim' },
  { 'shaunsingh/moonlight.nvim' },
  { 'Shatur/neovim-ayu' },
  { 'projekt0n/github-nvim-theme', },
  { 'sainnhe/everforest' },
  { 'sainnhe/gruvbox-material' },
  {
    'navarasu/onedark.nvim',
    config = function()
      local colors = {
        black = "#000000",
        bg_d = '#0a0d11',
        bg0 = '#101317',
        bg1 = '#13161a',
        bg2 = "#171b20",
        bg3 = "#1b1f25",
        ColorColumn = "#43262a",
        Whitespace = "#262a30",
        IndentBlanklineSpaceChar = "#262a30",
        FloatBorder = "#101317",
        NvimTreeIndentMarker = "#262a30",
      }
      local ts_colors = {
        white = "#ffffff",
        yellow = "#cfcf60",
        red = "#af3030",
        green = "#303fa0",
        darker_black = "#070a0e",
        black = '#0a0d11',
        black2 = "#171b20",
      }
      require('onedark').setup({
        style = "darker",
        colors = colors,
        highlights = {
          ColorColumn = { bg = colors.ColorColumn },
          Whitespace = { fg = colors.Whitespace },
          IndentBlanklineSpaceChar = { fg = colors.IndentBlanklineSpaceChar },
          FloatBorder = { bg = colors.FloatBorder },
          NvimTreeIndentMarker = { fg = colors.NvimTreeIndentMarker },

          TelescopeBorder = { fg = ts_colors.darker_black, bg = ts_colors.darker_black, },
          TelescopeNormal = { bg = ts_colors.darker_black },
          TelescopeSelection = { bg = ts_colors.black2, fg = ts_colors.white },
          TelescopePromptTitle = { fg = ts_colors.white, bg = ts_colors.red, },
          TelescopePromptBorder = { fg = ts_colors.black2, bg = ts_colors.black2, },
          TelescopePromptNormal = { fg = ts_colors.white, bg = ts_colors.black2, },

          TelescopePromptPrefix = { fg = ts_colors.red, bg = ts_colors.black2, },
          TelescopePreviewTitle = { fg = ts_colors.white, bg = ts_colors.green, },
          TelescopePreviewBorder = { fg = ts_colors.darker_black, bg = ts_colors.darker_black, },
          TelescopeResultsTitle = { fg = ts_colors.black, bg = ts_colors.black, },
          TelescopeResultsNormal = { bg = ts_colors.black, },
          TelescopeResultsBorder = { fg = ts_colors.black, bg = ts_colors.black, },
          TelescopeResultsDiffAdd = { fg = ts_colors.green, },
          TelescopeResultsDiffChange = { fg = ts_colors.yellow, },
          TelescopeResultsDiffDelete = { fg = ts_colors.red, },
        }
      })
      -- require('onedark').load()
    end
  },
  { 'https://gitlab.com/__tpb/monokai-pro.nvim' },

  -- Paste Theme Above
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "tpope/vim-surround", },
  { "p00f/nvim-ts-rainbow", },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup({
        keywords = {
          TAG = { icon = "🏷", color = "#7aa2f7", alt = { 'MARK' } },
        },
      })
    end,
  },
  { "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup({
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true,
      })
    end,
  },
  { "wincent/scalpel", },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      local hop = require("hop")
      hop.setup()

      vim.keymap.set('', 't', function()
        hop.hint_char1({ current_line_only = true, })
      end, { silent = true })
      vim.keymap.set('v', 't', function()
        hop.hint_char1({ current_line_only = true, })
      end, { silent = true })

      vim.keymap.set('', 'f', function()
        hop.hint_char1() -- hint_offset = 1
      end, { silent = true })
      vim.keymap.set('v', 'f', function()
        hop.hint_char1()
      end, { silent = true })

      vim.api.nvim_set_keymap('', "F", ":HopChar2<cr>", { silent = true })
      vim.keymap.set('v', 'F', function()
        hop.hint_char2({})
      end, { silent = true })

      -- vim.api.nvim_set_keymap("n", "f", ":HopChar1<cr>", { silent = true })
      -- vim.keymap.set('v', 'f', function()
      --   hop.hint_char1({})
      -- end, { silent = true })

      -- vim.api.nvim_set_keymap('', "F", ":HopPattern<cr>", { silent = true })
      -- vim.keymap.set('v', 'F', function()
      --   hop.hint_patterns({})
      -- end, { silent = true })

      -- vim.api.nvim_set_keymap('', "t", ":HopLine<cr>", { silent = true })
      -- vim.keymap.set('v', 't', function()
      --   hop.hint_lines({})
      -- end, { silent = true })

    end,
  },
  { "mbbill/undotree", },
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup({})
    end,
  },
  {
    "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 28,
          win_vheight = 28,
          delay_syntax = 80,
          border_chars = { "|", "|", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })

    end,
  },
  { "gbrlsnchs/telescope-lsp-handlers.nvim" },
  { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".on_attach()
      require "lsp_signature".setup()
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    config = function()
      require 'refactoring'.setup({
        prompt_func_return_type = {
          go = true,
          cpp = true,

          c = true,
          java = true,
          python = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
          python = true,
        },
      })
      -- remap j to open the Telescope refactoring menu in visual mode
      vim.api.nvim_set_keymap(
        "v",
        "<F12>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        { noremap = true }
      )
      -- You can also use below = true here to to change the position of the printf
      -- statement (or set two remaps for either one). This remap must be made in normal mode.
      vim.api.nvim_set_keymap(
        "n",
        "<F12>rv",
        ":lua require('refactoring').debug.printf({below = false})<CR>",
        { noremap = true }
      )
      -- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
      vim.api.nvim_set_keymap("n", "<F12><F12>p", ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
        { noremap = true })
      -- Remap in visual mode will print whatever is in the visual selection
      vim.api.nvim_set_keymap("v", "<F12><F12>p", ":lua require('refactoring').debug.print_var({})<CR>",
        { noremap = true })
      -- Cleanup function: this remap should be made in normal mode
      vim.api.nvim_set_keymap("n", "<F12><F12>P", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
    end
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk", }, -- a table with mappings to use
        timeout = 300, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
        -- example(recommended)
        -- keys = function()
        --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
        -- end,
      })
    end,
  },
  { 'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
    end
  },
  { 'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },
  { 'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup({})
    end
  },
  {
    "echasnovski/mini.map",
    branch = "stable",
    config = function()
      require('mini.map').setup()
      local map = require('mini.map')
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.gitsigns(),
          map.gen_integration.diagnostic({
            error = 'DiagnosticFloatingError',
            warn  = 'DiagnosticFloatingWarn',
            info  = 'DiagnosticFloatingInfo',
            hint  = 'DiagnosticFloatingHint',
          }),
        },
        symbols = {
          encode = map.gen_encode_symbols.dot('3x2'),
        },
        window = {
          side = 'right',
          width = 16, -- set to 1 for a pure scrollbar :)
          winblend = 0,
          show_integration_count = false,
        },
      })
    end
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  },
  { "nvim-neorg/neorg",
    run = ":Neorg sync-parsers", -- This is the important bit!
    config = function()
      local keybinds = require("neorgKeybindings")
      require("neorg").setup {
        -- configuration here
        load = {
          ["core.defaults"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                home = "~/notes/home",
              },
              default_workspace = "home",
            }
          },
          ["core.norg.concealer"] = {},
          ["core.norg.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          -- ["core.gtd.base"] = {
          --   config = { -- Note that this table is optional and doesn't need to be provided
          --     -- Configuration here
          --     workspace = "work"
          --   }
          -- },
          ["core.keybinds"] = {
            config = keybinds
          }
        }
      }
    end, },
  {
    "nvim-telescope/telescope-dap.nvim",
    config = function()
    end
  },
  { 'f3fora/cmp-spell' },
  { 'folke/noice.nvim',
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
          },
          hover = {
            enabled = false,
          }
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
    requires = { "MunifTanjim/nui.nvim", }
  },
  { "MunifTanjim/nui.nvim", },
  { 'gboncoffee/run.lua', },
  {
    "folke/lsp-colors.nvim",
    event = "BufRead",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "lua" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup({
        position = 'left',
        autofold_depth = 2,
      })
    end
  },
  {
    'MattesGroeger/vim-bookmarks',
    config = function()
    end
  },
  { 'tom-anders/telescope-vim-bookmarks.nvim' },
  { 'ThePrimeagen/git-worktree.nvim',
    config = function()
      local Worktree = require("git-worktree")
      Worktree.setup({})
      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Switch then
          print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
        end
      end)
    end
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      require('glance').setup({
        height = 28,
        border = {
          enable = true, -- Show window borders. Only horizontal borders allowed
          top_char = '―',
          bottom_char = '―',
        },
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  { 'anuvyklack/fold-preview.nvim',
    requires = 'anuvyklack/keymap-amend.nvim',
    config = function()
      require('fold-preview').setup()
    end
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      -- vim.diagnostic.config({ virtual_text = false, })
      vim.diagnostic.config({ virtual_lines = false, })
      -- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
      local flag = true
      vim.keymap.set(
        "",
        "<F12>L",
        function()
          if flag then
            vim.diagnostic.config({ virtual_text = false, })
            vim.diagnostic.config({ virtual_lines = true, })
          else
            vim.diagnostic.config({ virtual_text = true, })
            vim.diagnostic.config({ virtual_lines = false, })
          end
          flag = not flag
        end,
        -- require("lsp_lines").toggle,
        { desc = "Toggle lsp_lines" }
      )
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        -- optional configuration
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        refactor = {
          highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
          },
          highlight_current_scope = { enable = false },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "grr",
            },
          },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gtd",
              list_definitions = "gtD",
              list_definitions_toc = "gO",
              goto_next_usage = "<C-]>",
              goto_previous_usage = "<C-[>",
            },
          },
        },
      }
    end
  },
  {
    'm-demare/attempt.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      local attempt = require('attempt')
      attempt.setup()

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts = vim.tbl_extend('force', { silent = true }, opts)
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', '<tab>nn', attempt.new_select, { desc = 'new attempt select' }) -- new attempt, selecting extension
      map('n', '<tab>ni', attempt.new_input_ext, { desc = 'new attempt input' }) -- new attempt, inputing extension
      map('n', '<tab>nr', attempt.run, { desc = 'run attempt' }) -- run attempt
      map('n', '<tab>nd', attempt.delete_buf, { desc = 'delete attempt buffer' }) -- delete attempt from current buffer
      map('n', '<tab>nc', attempt.rename_buf, { desc = 'rename attempt buffer' }) -- rename attempt from current buffer
      map('n', '<tab>nl', ':Telescope attempt<cr>', { desc = 'search through attemps' }) -- search through attempts
    end
  },
  { 'bennypowers/nvim-regexplainer',
    config = function()
      require 'regexplainer'.setup(
        {
          auto = true,
          filetypes = {
            'html',
            'js',
            'cjs',
            'mjs',
            'ts',
            'jsx',
            'tsx',
            'cjsx',
            'mjsx',
          },
        }
      )
      require 'regexplainer'.show {
        display = 'popup',
        popup = {
          border = {
            padding = { 1, 1 },
            style = 'single',
          },
        },
      }
    end,
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'MunifTanjim/nui.nvim',
    }
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup({ useDefaultKeymaps = true })
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', },
  { 'nvim-treesitter/playground' }

  -- Paste Plugin Above
}

return plugins
