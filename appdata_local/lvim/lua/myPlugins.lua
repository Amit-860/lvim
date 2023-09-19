local plugins = {
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = false,
            terminal_color = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent"
            }
        },
    },
    {
        "kylechui/nvim-surround",
        event = "BufRead",
        -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
        version = "main",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup({
                keywords = {
                    TAG = {
                        icon = "🏷",
                        color = "#7aa2f7",
                        alt = { "MARK" },
                    },
                },
            })
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
    { "wincent/scalpel" },
    { "gbrlsnchs/telescope-lsp-handlers.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup({
                mapping = { "jk" },        -- a table with mappings to use
                timeout = 500,             -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = false, -- clear line after escaping if there is only whitespace
                keys = "<Esc>",            -- keys used for escaping, if it is a function will use the result everytime
            })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        event = "LspAttach",
        config = function()
            require("dap-python").setup("~/scoop/apps/python/current/python")
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        event = "LspAttach",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        event = "LspAttach",
        config = function() end,
    },
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("harpoon").setup({})
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "romgrk/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true, -- Throttles plugin updates (may improve performance)
                max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
                patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                    default = { "class", "function", "method" },
                },
            })
        end,
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        config = function()
            require("various-textobjs").setup({
                useDefaultKeymaps = true,
            })
        end,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    {
        "wellle/targets.vim",
        envent = "BufRead"
    },
    {
        "folke/trouble.nvim",
        event = "LspAttach",
        cmd = "TroubleToggle",
        opts = {
            height = 14,
        },
    },
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    {
        "ckolkey/ts-node-action",
        dependencies = { "nvim-treesitter" },
        Lazy = 'VeryLazy',
        event = 'LspAttach',
        opts = {},
    },
    {
        "tpope/vim-repeat",
        event = "BufRead",
    },
    -- {
    --     "folke/noice.nvim",
    --     -- cond = not vim.g.neovide,
    --     event = "VeryLazy",
    --     opts = {},
    --     dependencies = { "MunifTanjim/nui.nvim" },
    --     config = function()
    --         require("noice").setup({
    --             lsp = {
    --                 progress = {
    --                     enabled = false,
    --                     format = "lsp_progress",
    --                     format_done = "lsp_progress_done",
    --                     throttle = 1000 / 30, -- frequency to update lsp progress message
    --                     view = "mini",
    --                 },
    --                 override = {
    --                     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                     ["vim.lsp.util.stylize_markdown"] = true,
    --                     ["cmp.entry.get_documentation"] = true,
    --                 },
    --                 signature = {
    --                     enabled = false,
    --                 },
    --                 hover = {
    --                     enabled = false,
    --                 },
    --             },
    --             routes = {
    --                 enabled = false,
    --                 -- { view = "cmdline", filter = { event = "msg_showmode" } }
    --             },
    --             presets = {
    --                 bottom_search = false,        -- use a classic bottom cmdline for search
    --                 command_palette = false,      -- position the cmdline and popupmenu together
    --                 long_message_to_split = true, -- long messages will be sent to a split
    --                 inc_rename = true,            -- enables an input dialog for inc-rename.nvim
    --                 lsp_doc_border = false,       -- add a border to hover docs and signature help
    --             },
    --         })
    --     end,
    -- },
    {
        "folke/flash.nvim",
        event = "BufRead",
        opts = {
            modes = {
                char = {
                    jump_labels = true
                },
                search = {
                    enabled = false
                }
            },

        },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function() require("flash").jump({}) end,
                desc = "Flash"
            },
            {
                "<M-s>",
                mode = { "n", "o", "x" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            {
                "r",
                mode = { "n", "o", "x" },
                function() require("flash").jump({ pattern = vim.fn.expand("<cword>") }) end,
                desc = "Flash Treesitter"
            },
            {
                "<M-/>",
                mode = { "n" },
                function() require("flash").toggle() end,
                desc =
                "Toggle Flash Search"
            },
        },
    },
    {
        "MattesGroeger/vim-bookmarks"
    },
    {
        "tom-anders/telescope-vim-bookmarks.nvim",
        config = function()
            vim.keymap.set("n", "ma", "<cmd>Telescope vim_bookmarks<cr>",
                { noremap = true, desc = "Telescope Bookmarks" })
        end
    },
    {
        "debugloop/telescope-undo.nvim",
    },
    {
        "chrisgrieser/nvim-spider",
        event = "BufRead",
        lazy = true,
        opts = {
            skipInsignificantPunctuation = true
        }
    },
    {
        'simrat39/symbols-outline.nvim',
        event = "LspAttach",
        opts = {
            autofold_depth = 2,
            auto_unfold_hover = false
        },
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufRead" },
        opts = {
            chunk = {
                exclude_filetypes = {
                    aerial = true,
                    dashboard = true,
                    Outline = true
                },
            },
            line_num = {
                enable = false,
                use_treesitter = false,
                style = "#806d9c",
            },
        }
    },
    {
        'yamatsum/nvim-cursorline',
        opts = {
            cursorline = {
                enable = false,
                timeout = 3000,
                number = false,
            }
        }
    },
    {
        "gbprod/yanky.nvim",
        event = "BufRead",
        opts = {}
    },
    {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        event = 'LspAttach'
    },
    {
        'karb94/neoscroll.nvim',
        envent = "BufRead",
        cond = not vim.g.neovide,
        opts = {}
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            settings = {
                tsserver_file_preferences = {
                    quotePreference = "single",
                },
                tsserver_format_options = {
                    semicolons = "insert",
                }
            }
        },
    },
    {
        "monaqa/dial.nvim",
        event = "BufRead",
        keys = {
            { "<C-a>",  "<Plug>(dial-increment)",  mode = { "n", "v" }, remap = true },
            { "<C-x>",  "<Plug>(dial-decrement)",  mode = { "n", "v" }, remap = true },
            { "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" }, remap = true },
            { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, remap = true },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,                                                                    -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.hex,                                                                        -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                    augend.constant.alias.bool,                                                                      -- boolean value (true <-> false)
                    augend.date.alias["%Y/%m/%d"],                                                                   -- date (2022/02/18, etc.)
                    augend.date.alias["%m/%d/%Y"],                                                                   -- date (02/19/2022)
                    augend.date.new { pattern = "%m-%d-%Y", default_kind = "day", only_valid = true, word = false }, -- date (02-19-2022)
                    augend.date.new { pattern = "%Y-%m-%d", default_kind = "day", only_valid = true, word = false }, -- date (02-19-2022)
                    augend.date.new({ pattern = "%m.%d.%Y", default_kind = "day", only_valid = true, word = false, }),
                    augend.constant.new { elements = { "&&", "||" }, word = false, cyclic = true, },
                    augend.constant.new { elements = { '>', '<' }, word = false, cyclic = true, },
                    augend.constant.new { elements = { '>=', '<=' }, word = false, cyclic = true, },
                    augend.constant.new { elements = { '==', '!=', }, word = false, cyclic = true, },
                    augend.constant.new { elements = { '===', '!==' }, word = false, cyclic = true, },
                    augend.constant.new { elements = { 'True', 'False' }, word = false, cyclic = true, },
                    augend.constant.new { elements = { 'and', 'or', 'not' }, word = false, cyclic = true, },
                },
            })
        end,
    },
    {
        'xiyaowong/transparent.nvim',
        cond = not vim.g.neovide,
        config = function()
            require('transparent').setup({
                groups = { "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier", "Statement", "PreProc",
                    "Type", "Underlined", "Todo", "String", "Function", "Conditional", "Repeat", "Operator", "Structure",
                    "LineNr", "NonText", "SignColumn", "CursorLineNr", "EndOfBuffer", },
                extra_groups = { "NormalFloat", "FloatBorder", --[["NvimTreeWinSeparator",]] "NvimTreeNormal",
                    "NvimTreeNormalNC", "NvimTreeEndOfBuffer", "TroubleNormal", "TelescopeNormal", "TelescopeBorder",
                    "WhichKeyFloat", },
            })
            vim.g.transparent_enabled = true
        end
    },
    -- {
    --     "altermo/ultimate-autopair.nvim",
    --     event = { "InsertEnter", "CmdlineEnter" },
    --     dependencies = "nvim-treesitter/nvim-treesitter",
    --     opts = {
    --         tabout = {
    --             enable = true,
    --             map = "<A-o>",
    --             cmap = "<A-o>",
    --             hopout = true,
    --         },
    --         cr = {
    --             enable = false,
    --         },
    --         bs = {
    --             enable = false,
    --         }
    --     },
    -- },
    {
        'HiPhish/rainbow-delimiters.nvim',
        event = "BufRead",
        config = function()
            local rainbow_delimiters = require 'rainbow-delimiters'
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                    html = 'rainbow-delimiters',
                    jsx = 'rainbow-delimiters-react',
                    tsx = 'rainbow-delimiters-react',
                    python = 'rainbow-delimiters',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end
    },
    {
        'antosha417/nvim-lsp-file-operations',
        lazy = "LspAttach",
        dependencies = {
            "nvim-lua/plenary.nvim",
        }
    },
    -- {
    --     'VidocqH/lsp-lens.nvim',
    --     event = "LspAttach",
    --     ft = { "java", "cs", "typescript", "tsx" },
    --     config = function()
    --         require 'lsp-lens'.setup({
    --             enable = true,
    --             include_declaration = true, -- Reference include declaration
    --             sections = {                -- Enable / Disable specific request
    --                 definition = true,
    --                 references = true,
    --                 implements = true,
    --             },
    --             ignore_filetype = {
    --                 "prisma", "json", "css", "html", "toml", "bson", "scss", "python", "lua", "javascript", "jsx", "http"
    --             },
    --         })
    --     end
    -- },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
        },
        config = true,
        event = "BufRead",
        opts = {}
    },
    {
        "CRAG666/code_runner.nvim",
        event = "LspAttach",
        config = true
    },
    {
        "rest-nvim/rest.nvim",
        event = "BufRead",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("rest-nvim").setup({
                result_split_horizontal = false,
                result_split_in_place = false,
                skip_ssl_verification = true,
                encode_url = true,
                highlight = {
                    enabled = true,
                    timeout = 150,
                },
                result = {
                    show_url = true,
                    show_curl_command = true,
                    show_http_info = true,
                    show_headers = true,
                    formatters = {
                        json = "jq",
                        html = function(body)
                            return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
                        end
                    },
                },
                jump_to_request = false,
                env_file = '.env',
                custom_dynamic_variables = {},
                yank_dry_run = true,
            })
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
    },
    {
        'nanotee/zoxide.vim',
    },
    {
        "vigoux/notifier.nvim",
        event = "VeryLazy",
        opts = {}
    },
}



return plugins
