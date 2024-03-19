local plugins = {
    {
        'dstein64/vim-startuptime',
        cmd = "StartupTime",
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
        opts = {
            styles = {
                bold = true,
                italic = false,
                transparency = true,
            }
        }
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
    },
    {
        "bluz71/vim-nightfly-colors",
        name = "nightfly",
        lazy = false,
        priority = 1000
    },
    {
        "kylechui/nvim-surround",
        event = "BufRead",
        -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
        version = "main",
        config = function()
            require("nvim-surround").setup({})
        end,
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
    { "wincent/scalpel",                         cmd = { 'Scalpel' } },
    { "gbrlsnchs/telescope-lsp-handlers.nvim",   event = "LspAttach" },
    { "nvim-telescope/telescope-ui-select.nvim", event = "VeryLazy" },
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup({
                mapping = { "jk" },       -- a table with mappings to use
                timeout = 300,            -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = true, -- clear line after escaping if there is only whitespace
                keys = "<Esc>",           -- keys used for escaping, if it is a function will use the result every time
            })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = 'python',
        event = "LspAttach",
        config = function()
            require("dap-python").setup("~/scoop/apps/python/current/python")
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        event = "LspAttach",
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        event = "LspAttach",
        opts = {}
    },
    {
        "windwp/nvim-ts-autotag",
        ft = 'html',
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "romgrk/nvim-treesitter-context",
        event = 'BufRead',
        config = function()
            require("treesitter-context").setup({
                enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true, -- Throttles plugin updates (may improve performance)
                max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
                patterns = { default = { "class", "function", "method" } },
            })
        end,
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        event = 'BufRead',
        config = function()
            require("various-textobjs").setup({
                useDefaultKeymaps = true,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = 'BufRead',
    },
    {
        "wellle/targets.vim",
        event = "BufRead",
    },
    {
        "folke/trouble.nvim",
        event = "LspAttach",
        cmd = "TroubleToggle",
        opts = { height = 14 },
    },
    {
        "sindrets/diffview.nvim",
        cmd = { 'DiffviewOpen', 'DiffviewClose', 'FiffviewFileHistory' }
    },
    {
        "ckolkey/ts-node-action",
        dependencies = { "nvim-treesitter" },
        event = "VeryLazy",
        opts = {},
        config = function()
            vim.keymap.set(
                { "n" }, "<M-.>", "<cmd>lua require('ts-node-action').node_action()<cr>",
                { desc = "Trigger Node Action" }
            )
        end
    },
    {
        "tpope/vim-repeat",
        event = "BufRead",
    },
    --  {
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
    --                 signature = { enabled = false, },
    --                 hover = { enabled = false, },
    --             },
    --             routes = { enabled = false, -- { view = "cmdline", filter = { event = "msg_showmode" } }
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
        opts = {
            modes = {
                char = { jump_labels = true, },
                search = { enabled = false, },
            },
        },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function() require("flash").jump({}) end,
                desc = "Flash",
            },
            {
                "<M-s>",
                mode = { "n", "o", "x" },
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function() require("flash").jump({ pattern = vim.fn.expand("<cword>") }) end,
                desc = "Flash Treesitter",
            },
            {
                "<M-/>",
                mode = { "n" },
                function() require("flash").toggle() end,
                desc = "Toggle Flash Search",
            },
        },
        config = function()
            vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#e67947", bg = "#000000", bold = true })
        end,
    },
    { "MattesGroeger/vim-bookmarks",
    },
    {
        "tom-anders/telescope-vim-bookmarks.nvim",
        keys = {
            {
                "ma",
                mode = { "n" },
                "<cmd>Telescope vim_bookmarks<cr>",
                desc = "Telescope Bookmarks"
            }
        }
    },
    {
        "debugloop/telescope-undo.nvim",
        event = "VeryLazy"
    },
    {
        "chrisgrieser/nvim-spider",
        event = "BufRead",
        lazy = true,
        opts = {
            skipInsignificantPunctuation = true,
        },
    },
    {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline" },
        opts = {
            autofold_depth = 2,
            auto_unfold_hover = false,
        },
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufRead" },
        config = function()
            local opts = {
                chunk = {
                    enable = true,
                    exclude_filetypes = {
                        aerial = true,
                        dashboard = true,
                        Outline = true,
                    },
                },
                line_num = {
                    enable = false,
                    use_treesitter = false,
                    style = "#806d9c",
                },
                blank = {
                    enable = false
                },
                indent = {
                    char = { "¦", "┆", "┊", }
                }
            }
            if vim.g.neovide then
                opts.chunk.enable = false
            end
            require("hlchunk").setup(opts)
        end
    },
    {
        "yamatsum/nvim-cursorline",
        opts = {
            cursorline = {
                enable = false,
                timeout = 3000,
                number = false,
            },
        },
    },
    {
        "gbprod/yanky.nvim",
        event = "BufRead",
        opts = {},
    },
    {
        "hrsh7th/cmp-nvim-lsp-signature-help",
        event = "LspAttach",
    },
    -- {
    --     "karb94/neoscroll.nvim",
    --     event = "BufRead",
    --     cond = not vim.g.neovide,
    --     opts = {},
    -- },
    {
        "pmizio/typescript-tools.nvim",
        ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            settings = {
                tsserver_file_preferences = {
                    quotePreference = "single",
                },
                tsserver_format_options = {
                    semicolons = "insert",
                },
            },
        },
    },
    --[[ {
        "hinell/lsp-timeout.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            vim.g["lsp-timeout-config"] = {
                -- When focus is lost
                -- wait 5 minutes before stopping all LSP servers
                stopTimeout = 1000 * 60 * 3,
                startTimeout = 1000 * 10
            }
        end
    }, ]]
    {
        "monaqa/dial.nvim",
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
                    augend.integer.alias.decimal,                                                                     -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.hex,                                                                         -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                    augend.constant.alias.bool,                                                                       -- boolean value (true <-> false)
                    augend.date.alias["%Y/%m/%d"],                                                                    -- date (2022/02/18, etc.)
                    augend.date.alias["%m/%d/%Y"],                                                                    -- date (02/19/2022)
                    augend.date.new({ pattern = "%m-%d-%Y", default_kind = "day", only_valid = true, word = false }), -- date (02-19-2022)
                    augend.date.new({ pattern = "%Y-%m-%d", default_kind = "day", only_valid = true, word = false }), -- date (02-19-2022)
                    augend.date.new({ pattern = "%m.%d.%Y", default_kind = "day", only_valid = true, word = false }),
                    augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { ">", "<" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "==", "!=" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "===", "!==" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "True", "False" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "and", "or", "not" }, word = false, cyclic = true }),
                },
            })
        end,
    },
    {
        "xiyaowong/transparent.nvim",
        cond = not vim.g.neovide,
        config = function()
            require("transparent").setup({
                groups = { "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
                    "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
                    "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText", "SignColumn",
                    "CursorLineNr", "EndOfBuffer", },
                extra_groups = { "NormalFloat", "FloatBorder", --[["NvimTreeWinSeparator",]] "NvimTreeNormal",
                    "NvimTreeNormalNC", "NvimTreeEndOfBuffer", "TroubleNormal", "TelescopeNormal",
                    "TelescopeBorder", "WhichKeyFloat", },
            })
            vim.g.transparent_enabled = true
        end,
    },
    --[[ {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            tabout = {
                enable = true,
                map = "<A-o>",
                cmap = "<A-o>",
                hopout = true,
            },
            cr = { enable = true, },
            bs = { enable = true, },
        },
    }, ]]
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufRead",
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                    html = "rainbow-delimiters",
                    jsx = "rainbow-delimiters-react",
                    tsx = "rainbow-delimiters-react",
                    python = "rainbow-delimiters",
                },
                highlight = {
                    "RainbowDelimiterRed", "RainbowDelimiterYellow", "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange", "RainbowDelimiterGreen", "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
    },
    {
        "antosha417/nvim-lsp-file-operations",
        event = "LspAttach",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    --[[ {
        'VidocqH/lsp-lens.nvim',
        event = "LspAttach",
        ft = { "java", "cs", "typescript", "tsx" },
        config = function()
            require 'lsp-lens'.setup({
                enable = true,
                include_declaration = true, -- Reference include declaration
                sections = {                -- Enable / Disable specific request
                    definition = true,
                    references = true,
                    implements = true,
                },
                ignore_filetype = {
                    "prisma", "json", "css", "html", "toml", "bson", "scss", "python", "lua", "javascript", "jsx", "http"
                },
            })
        end
    }, ]]
    {
        "NeogitOrg/neogit",
        cmd = { 'Neogit' },
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
        },
        config = true,
        event = "BufRead",
        opts = {},
    },
    {
        "CRAG666/code_runner.nvim",
        cmd = { 'RunFile', 'RunCode', 'RunProject', 'RunClose' },
        config = true,
    },
    {
        "rest-nvim/rest.nvim",
        ft = "http",
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
                        end,
                    },
                },
                jump_to_request = false,
                env_file = ".env",
                custom_dynamic_variables = {},
                yank_dry_run = true,
            })
        end,
    },
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
    },
    {
        "nanotee/zoxide.vim",
        cmd = { "Z" }
    },
    {
        "vigoux/notifier.nvim",
        lazy = true,
        opts = {},
    },
    {
        "drybalka/tree-climber.nvim",
        event = "BufRead",
        config = function()
            vim.keymap.set({ "n", "v", "o" }, "r",
                require("tree-climber").goto_next,
                { noremap = true, silent = true, desc = "Next Block" }
            )
            vim.keymap.set({ "n", "v", "o" }, "R",
                require("tree-climber").goto_prev,
                { noremap = true, silent = true, desc = "Prev Block" }
            )
            vim.keymap.set({ "n", "v", "o" }, "]r",
                require("tree-climber").goto_child,
                { noremap = true, silent = true, desc = "Goto Child Block" }
            )
            vim.keymap.set({ "n", "v", "o" }, "[R",
                require("tree-climber").goto_parent,
                { noremap = true, silent = true, desc = "Goto Parent Block" }
            )
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "LspAttach",
        config = function()
            local slow_format_filetypes = {}
            require("conform").setup({
                formatters_by_ft = {
                    python = { "isort", "black", },
                    scss = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    yaml = { "prettier" },
                    json = { "prettier" },
                    toml = { "prettier" },
                    javascript = { "biome" },
                    javascriptreact = { "biome" },
                    typescript = { "biome" },
                    typescriptreact = { "biome" },
                    -- ["*"] = { "codespell" },
                    ["_"] = { "trim_whitespace", "trim_newlines" },
                },
                format_on_save = function(bufnr)
                    if slow_format_filetypes[vim.bo[bufnr].filetype] then
                        return
                    end
                    local function on_format(err)
                        if err and err:match("timeout$") then
                            slow_format_filetypes[vim.bo[bufnr].filetype] = true
                        end
                    end
                    return { timeout_ms = 1000, lsp_fallback = true }, on_format
                end,
                format_after_save = function(bufnr)
                    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                        return
                    end
                    return { lsp_fallback = true }
                end,
            })
        end,
    },
    {
        "NStefan002/speedtyper.nvim",
        cmd = "Speedtyper",
        opts = {}
    },
    {
        "chrisgrieser/nvim-puppeteer", -- create fstring
        dependencies = "nvim-treesitter/nvim-treesitter",
        lazy = false,                  -- plugin lazy-loads itself. Can also load on filetypes.
    },
    {
        'renerocksai/telekasten.nvim',
        cmd = { "Telekasten", "Telekasten find_notes", "Telekasten show_tags", "Telekasten new_note" },
        dependencies = { 'nvim-telescope/telescope.nvim', 'renerocksai/calendar-vim' },
        config = function()
            require('telekasten').setup({
                home = vim.fn.expand("C:/Users/AMIT/zettelkasten/"),
            })
        end
    },
    -- {
    --     'boltlessengineer/smart-tab.nvim',
    --     event = "BufRead",
    --     config = function()
    --         require('smart-tab').setup({
    --             skips = { "string_content" },
    --             mapping = "<tab>",
    --         })
    --     end
    -- },
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    --[[ {
        'kevinhwang91/nvim-ufo',
        event = "BufEnter",
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }
            local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
            for _, ls in ipairs(language_servers) do
                require('lspconfig')[ls].setup({
                    capabilities = capabilities
                    -- you can add other fields for setting up lsp server in this table
                })
            end
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
            vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
            require('ufo').setup({})
        end
    }, ]]
    {
        "AgusDOLARD/backout.nvim",
        event = "BufRead",
        opts = {
            chars = "(){}[]`'\"<>" -- default chars
        },
        keys = {
            -- Define your keybinds
            { "<M-h>", "<cmd>lua require('backout').back()<cr>", mode = { "i", "n" } },
            { "<M-l>", "<cmd>lua require('backout').out()<cr>",  mode = { "i", "n" } },
        },
    },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",
        },
        opts = {
            -- configuration goes here
            lang = "python3"
        },
    }

}

return plugins
