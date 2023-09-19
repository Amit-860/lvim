-- NOTE: Neovim Options
vim.opt.cursorline = false
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-- NOTE: Treesitter config options : START
local ts_opts = {
    on_config_done = nil,

    -- A list of parser names, or "all"
    ensure_installed = { "comment", "markdown_inline", "regex", "python", "javascript", "typescript", "lua" },

    -- List of parsers to ignore installing (for "all")
    ignore_install = {},

    -- A directory to install the parsers into.
    -- By default parsers are installed to either the package dir, or the "site" dir.
    -- If a custom path is used (not nil) it must be added to the runtimepath.
    parser_install_dir = nil,

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    matchup = {
        enable = false, -- mandatory, false will disable the whole extension
        disable = {},   -- optional, list of language that will be disabled
    },
    highlight = {
        enable = false, -- false will disable the whole extension
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
            -- Languages that have a single comment style
            typescript = "// %s",
            css = "/* %s */",
            scss = "/* %s */",
            html = "<!-- %s -->",
            svelte = "<!-- %s -->",
            vue = "<!-- %s -->",
            json = "",
        },
    },
    indent = { enable = true, disable = { "yaml", "python" } },
    autotag = { enable = true },
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ['<M-a>'] = "@parameter.inner"
            },
            swap_previous = {
                ['<M-A>'] = "@parameter.inner"
            }
        },
        select = {
            enable = false,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            including_surrounding_whitespace = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
                -- ['aa'] = '@parameter.outer',
                -- ['ia'] = '@parameter.inner',
                ['id'] = '@conditional.inner',
                ['ad'] = '@conditional.outer',

            },
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V',  -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
        },

        move = {
            enable = false,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']c'] = '@class.outer',
                ['][c'] = '@class.inner',

                [']f'] = '@function.outer',  -- outside of the next function
                ['][f'] = '@function.inner', -- inside the start of the next function

                [']l'] = '@loop.outer',
                ['][l'] = '@loop.inner',

                [']d'] = '@conditional.outer',
                ['][d'] = '@conditional.inner',

                [']a'] = '@parameter.inner',
            },
            goto_next_end = {
                [']]c'] = '@class.inner',
                [']]f'] = '@function.inner', -- inside the end of the next function
                [']]d'] = '@conditional.inner',
                [']]l'] = '@loop.inner',
            },
            goto_previous_start = {
                ['[c'] = '@class.outer',
                ['[[c'] = '@class.inner',

                ['[f'] = '@function.outer',  -- outside of the previous function
                ['[[f'] = '@function.inner', -- inside the start of the previous function

                ['[l'] = '@loop.outer',
                ['[[l'] = '@loop.inner',

                ['[d'] = '@conditional.outer',
                ['[[d'] = '@conditional.inner',

                ['[a'] = '@parameter.inner',
            },
            goto_previous_end = {
                ['[]c'] = '@class.inner',
                ['[]f'] = '@function.inner', -- inside of the end of the previous function
                ['[]l'] = '@loop.inner',
                ['[]d'] = '@conditional.inner',
            },
        },
    },
    textsubjects = {
        enable = true,
        keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "vn",
            node_incremental = "n",
            node_decremental = "N",
            scope_incremental = "T",
        },
    },
}
-- treesitter config options : END


-- NOTE: lazy plugin : STARTS
require("lazy").setup({
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require 'nvim-treesitter.configs'.setup(ts_opts)
        end
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
                    -- For all filetypes
                    -- Note that setting an entry here replaces all other patterns for this entry.
                    -- By setting the 'default' entry below, you can control which nodes you want to
                    -- appear in the context window.
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
    { "wellle/targets.vim" },
    {
        "ckolkey/ts-node-action",
        dependencies = { "nvim-treesitter" },
        Lazy = 'VeryLazy',
        opts = {},
    },
    { "tpope/vim-repeat" },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
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
        "chrisgrieser/nvim-spider",
        lazy = true,
        opts = {
            skipInsignificantPunctuation = true
        }
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
    -- {
    --     'Cassin01/wf.nvim',
    --     cond = not vim.g.vscode,
    --     opts = {
    --         theme = "default"
    --     }
    -- },
    {
        "EdenEast/nightfox.nvim",
        cond = not vim.g.vscode,
        lazy = false,
        priority = 1000,
        config = function()
        end
    },
    {
        "max397574/better-escape.nvim",
        cond = not vim.g.vscode,
        config = function()
            require("better_escape").setup({
                mapping = { "jk" },        -- a table with mappings to use
                timeout = 500,             -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = false, -- clear line after escaping if there is only whitespace
                keys = "<Esc>",            -- keys used for escaping, if it is a function will use the result everytime
            })
        end,
    },
    opts = {
        checker = {
            frequency = 604800,
        }
    }
})
-- plugin : END

if not vim.g.vscode then
    vim.cmd("colorscheme nightfox")
    vim.wo.relativenumber = true
    vim.o.cursorline = true
    vim.keymap.set('n', "<C-q>", ":q<cr>", { noremap = true, silent = true, desc = 'Exit' })
    vim.keymap.set('n', "<C-Q>", ":q!>cr>", { noremap = true, silent = true, desc = 'Force Exit' })
    vim.keymap.set({ 'n', 'i', 'v' }, "<c-s>", ":w!<cr>", { noremap = true, silent = true, desc = 'Save' })
end

vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>",
    { desc = "Spider-w", noremap = true })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>",
    { desc = "Spider-e", noremap = true })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>",
    { desc = "Spider-b", noremap = true })
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>",
    { desc = "Spider-ge", noremap = true })
vim.keymap.set({ "n" }, "<M-.>", "<cmd>lua require('ts-node-action').node_action()<cr>", { desc = "Trigger Node Action" })

-- local which_key = require("wf.builtin.which_key")
-- local register = require("wf.builtin.register")
-- local bookmark = require("wf.builtin.bookmark")
-- local buffer = require("wf.builtin.buffer")
-- local mark = require("wf.builtin.mark")

-- Register
-- vim.keymap.set(
--     "n",
--     "\"",
--     -- register(opts?: table) -> function
--     -- opts?: option
--     register(),
--     { noremap = true, silent = true, desc = "[wf.nvim] register" }
-- )

-- Bookmark
-- vim.keymap.set(
--     "n",
--     "<Space>m",
--     -- bookmark(bookmark_dirs: table, opts?: table) -> function
--     -- bookmark_dirs: directory or file paths
--     -- opts?: option
--     bookmark({
--         nvim = "~/.config/nvim",
--     }),
--     { noremap = true, silent = true, desc = "[wf.nvim] bookmark" }
-- )

-- -- Buffer
-- vim.keymap.set(
--     "n",
--     "<Space><Space>",
--     -- buffer(opts?: table) -> function
--     -- opts?: option
--     buffer(),
--     { noremap = true, silent = true, desc = "[wf.nvim] buffer" }
-- )

-- -- Mark
-- vim.keymap.set(
--     "n",
--     "'",
--     -- mark(opts?: table) -> function
--     -- opts?: option
--     mark(),
--     { nowait = true, noremap = true, silent = true, desc = "[wf.nvim] mark" }
-- )

-- -- which_key
-- vim.keymap.set(
--     "n",
--     "<Leader>",
--     -- mark(opts?: table) -> function
--     -- opts?: option
--     which_key({ text_insert_in_advance = "<Space>" }),
--     { noremap = true, silent = true, desc = "[wf.nvim] which-key /", }
-- )

-- Quit
vim.keymap.set(
    "n",
    "<leader>qq",
    "<cmd>q!<cr>",
    { noremap = true, silent = true, desc = "[wf.nvim] Quit", }
)
