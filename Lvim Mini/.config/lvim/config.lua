--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- Themes
lvim.colorscheme = "nightfox"
-- lvim.colorscheme = "kanagawa"

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.transparent_window = true

vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.timeoutlen = 500

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.lsp.automatic_servers_installation = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = { "javascript", "json", "lua", "python", "typescript", "tsx", "css", "yaml" }

lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, "neoclip")
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "vim_bookmarks")
    pcall(telescope.load_extension, "harpoon")
    pcall(telescope.load_extension, "lsp_handlers")
    pcall(telescope.load_extension, "refactoring")
    -- any other extensions loading
end

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.textsubjects.enable = true
lvim.builtin.treesitter.textobjects = {
    swap = {
        enable = true,
        swap_next = {
            ["<tab>p"] = "@parameter.inner",
        },
        swap_previous = {
            ["<tab>P"] = "@parameter.inner",
        },
    },
    -- move = textobj_move_keymaps,
    select = {
        enable = true,
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
            ['ak'] = '@comment.outer',
            ['id'] = '@conditional.inner',
            ['ad'] = '@conditional.outer',
            ['ih'] = '@block.inner',
            ['ah'] = '@block.outer',
        },
        selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
        },
    },

    move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
            [']c'] = '@class.outer',
            [']a'] = '@parameter.outer',
            [']f'] = '@function.outer',
            ['][f'] = '@function.inner',
            [']d'] = '@conditional.outer',
            ['][d'] = '@conditional.inner',
            [']l'] = '@loop.outer',
            ['][l'] = '@loop.inner',
            [']h'] = '@block.outer',
            ['][h'] = '@block.inner',
        },
        goto_next_end = {
            [']]f'] = '@function.outer',
            [']]c'] = '@class.outer',
            [']]d'] = '@conditional.outer',
            [']]l'] = '@loop.outer',
            [']]a'] = '@parameter.outer',
            [']]h'] = '@block.outer',
        },

        goto_previous_start = {
            ['[c'] = '@class.outer',
            ['[a'] = '@parameter.outer',
            ['[f'] = '@function.outer',
            ['[[f'] = '@function.inner',
            ['[d'] = '@conditional.outer',
            ['[[d'] = '@conditional.inner',
            ['[l'] = '@loop.outer',
            ['[[l'] = '@loop.inner',
            ['[h'] = '@block.outer',
            ['[[h'] = '@block.inner',
        },
        goto_previous_end = {
            ['[]f'] = '@function.outer',
            ['[]c'] = '@class.outer',
            ['[]d'] = '@conditional.outer',
            ['[]l'] = '@loop.outer',
            ['[]a'] = '@parameter.outer',
            ['[]h'] = '@block.outer',
        },
    },
}
lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
        init_selection = "vn",
        node_incremental = "n",
        scope_incremental = "T",
        node_decremental = "N",
    },
}

-- lsp settings
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local opts = {
    capabilities = capabilities,
    filetypes = { 'html', 'javascript', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    }
} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("emmet_ls", opts)

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { command = "black", filetypes = { "python" } },
    { command = "isort", filetypes = { "python" } },
    { command = "rome", filetypes = { "javascript", "typescript", "typescriptreact" } },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { command = "pylint", filetypes = { "python" } },
}

-- Additional Plugins
lvim.plugins = {
    { "kylechui/nvim-surround",
        tag = '*',
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    { "p00f/nvim-ts-rainbow", },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup({
                keywords = {
                    TAG = { icon = "🏷", color = "#7aa2f7", alt = { 'MARK' } },
                    DONE = { icon = "✓", color = "#92cbad" },
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
                hop.hint_char2() -- hint_offset = 1
            end, { silent = true })
            vim.keymap.set('v', 'f', function()
                hop.hint_char2()
            end, { silent = true })
        end,
    },
    { "mbbill/undotree", },
    { "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup({
                mapping = { "jk", }, -- a table with mappings to use
                timeout = 150, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = false, -- clear line after escaping if there is only whitespace
                keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
                -- example(recommended)
                -- keys = function()
                --     return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
                -- end,
            })
        end,
    },
    { 'ThePrimeagen/harpoon',
        config = function()
            require('harpoon').setup({})
        end
    },
    {
        'MattesGroeger/vim-bookmarks',
        config = function()
        end
    },
    { 'tom-anders/telescope-vim-bookmarks.nvim' },
    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },
    {
        "chrisgrieser/nvim-various-textobjs",
        config = function()
            require("various-textobjs").setup({ useDefaultKeymaps = true })
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects', },
    { 'wellle/targets.vim' },
    { "EdenEast/nightfox.nvim" },
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
        "Shatur/neovim-session-manager",
        config = function()
            require("session_manager").setup({
                autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Possible values: Disabled, CurrentDir, LastSession
                autosave_last_session = true,
            })
        end,
    },
    {
        "AckslD/nvim-neoclip.lua",
        requires = {
            { 'kkharji/sqlite.lua', module = 'sqlite' },
            -- you'll need at least one of these
            -- {'nvim-telescope/telescope.nvim'},
            -- {'ibhagwan/fzf-lua'},
        },
        config = function()
            require('neoclip').setup({
                enable_persistent_history = true,
            })
        end,
    },
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
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require "lsp_signature".on_attach()
            require "lsp_signature".setup()
        end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { "gboncoffee/run.lua", },
    { 'rebelot/kanagawa.nvim' },

    -- DAP related plugings
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
    { "nvim-telescope/telescope-dap.nvim",
        config = function()
        end
    },
    { 'folke/lsp-colors.nvim',
        config = function()
            require("lsp-colors").setup({
                Error = "#db4b4b",
                Warning = "#e0af68",
                Information = "#0db9d7",
                Hint = "#10B981"
            })
        end
    },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require('symbols-outline').setup({
                width = 20,
                autofold_depth = 2
            })
        end
    },
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require('neoscroll').setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb' },
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
    -- Paste plugins above this line
}

-- Indentblankline
-- lvim.builtin.indentlines.options = {}

-- keybindings
lvim.leader = "space"
-- add your own keymapping
lvim.keys.insert_mode["<C-s>"] = "<esc>:w!<cr>"

lvim.keys.normal_mode["-"] = "$"
lvim.keys.normal_mode["<C-s>"] = ":w!<cr>"
lvim.keys.normal_mode["<C-q>"] = ":close<cr>"
lvim.keys.normal_mode["<C-X>"] = ":qa!<cr>"
lvim.keys.normal_mode["<C-x>"] = ":q!<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-z>"] = ":UndotreeToggle<CR>"
-- lvim.keys.normal_mode["<C-p>"] = ":Telescope neoclip<CR>"
lvim.keys.normal_mode["<F12>s"] = ":Telecope spell_suggest<CR>"
lvim.keys.normal_mode["<F9>"] = ":DapToggleBreakpoint<CR>"
lvim.keys.normal_mode["<F21>"] = ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"

vim.keymap.set("v", "<Bs>", '"_d')
vim.keymap.set("n", "<C-u>", '10<C-y>')
vim.keymap.set("n", "<C-d>", '10<C-e>')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set({ "v" }, "<C-y>",
    function()
        vim.api.nvim_feedkeys(vim.api.nvim_eval('":w !clip.exe\\<cr>\\<esc>gvy"'), 'v', true)
    end,
    { noremap = true, desc = "Global Copy", silent = true })

vim.keymap.set({ "o", "x" }, "as", function() require("various-textobjs").subword(false) end,
    { noremap = true, desc = "Outer Subword" })
vim.keymap.set({ "o", "x" }, "is", function() require("various-textobjs").subword(true) end,
    { noremap = true, desc = "Inner Subword" })
vim.keymap.set({ "o", "x" }, "!", function() require("various-textobjs").diagnostic() end,
    { noremap = true, desc = "Diagnostic" })

vim.keymap.set('n', 'vif',
    "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@function.inner','v')<CR>",
    { noremap = true, desc = "select inner function" }
)
vim.keymap.set('n', 'vaf',
    "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@function.outer','V')<CR>",
    { noremap = true, desc = "select inner function" }
)
vim.keymap.set('n', 'vil',
    "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@loop.inner','v')<CR>",
    { noremap = true, desc = "select inner loop" }
)
vim.keymap.set('n', 'val',
    "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@loop.outer','v')<CR>",
    { noremap = true, desc = "select inner loop" }
)
vim.keymap.set('n', 'vid',
    "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@conditional.inner','v')<CR>",
    { noremap = true, desc = "select inner conditional" }
)
vim.keymap.set('n', 'vad',
    "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@conditional.outer','v')<CR>",
    { noremap = true, desc = "select outer conditional" }
)
vim.keymap.set('n', 'vih',
    "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@block.inner','V')<CR>",
    { noremap = true, desc = "select inner block" }
)
vim.keymap.set('n', 'vah',
    "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@block.outer','V')<CR>",
    { noremap = true, desc = "select outer block" }
)

-- Which_key_mapping
lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["y"] = { "<cmd>Telescope neoclip<CR>", "Clipboard" }
lvim.builtin.which_key.mappings["<space>"] = { "<cmd>Telescope buffers<CR>", "which_key_ignore" }
lvim.builtin.which_key.mappings["E"] = { "<Plug>(Scalpel)", "Scalpel" }
lvim.builtin.which_key.mappings["m"] = {
    name = "Harpoon Mark",
    a = { function() require('harpoon.mark').add_file() end, "Harpoon Add" },
    m = { "<CMD>Telescope harpoon marks<CR>", "Harpoon Mark" },
}

-- Autocommand
lvim.autocommands = {
    {
        { "BufEnter", "Filetype" },
        {
            desc = "Enable verticle bar for python files",
            pattern = { '*' },
            callback = function()
                if vim.o.filetype == "python" then
                    vim.opt.textwidth = 100
                    vim.opt.colorcolumn = "+1"
                else
                    vim.opt.textwidth = 0
                    vim.opt.colorcolumn = ""
                end
            end
        }
    }
}
