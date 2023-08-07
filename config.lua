-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd([[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote= shellxquote=
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  ]])

-- Set a compatible clipboard manager
vim.g.clipboard = {
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
}

-- setting for neovide
if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h10.5"
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 4
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_transparency = 0.85
    vim.g.neovide_fullscreen = true
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_cursor_vfx_mode = "wireframe"
    -- vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_cursor_vfx_particle_density = 10
    vim.o.winblend = 50
    vim.o.pumblend = 50
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_underline_automatic_scaling = true
    vim.g.neovide_no_idle = false
    vim.g.neovide_cursor_unfocused_outline_width = 0.05

    lvim.transparent_window = false
    lvim.colorscheme = "terafox"
    -- lvim.colorscheme = "nightfly"
else
    lvim.transparent_window = true
    -- lvim.colorscheme = "catppuccin-mocha"
    lvim.colorscheme = "nightfox"
end

-- lvim.log.level = "warn"
lvim.format_on_save.enabled = true

-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "githdark_colorblind"
-- lvim.colorscheme = "catppuccin-macchiato"
-- lvim.colorscheme = "catppuccin"

lvim.lsp.automatic_servers_installation = false
lvim.lazy.opts.checker = {
    frequency = 604800,
}

vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
-- vim.opt.foldmethod = "expr"                     -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldnestmax = 10
vim.opt.foldlevel = 4
vim.opt.foldenable = false
vim.opt.timeoutlen = 200
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "o" }
    end,
})

lvim.builtin.indentlines.active = false

lvim.leader = "space"

-- add your own keymapping
lvim.keys.insert_mode["<C-s>"] = "<esc>:w<cr>"
lvim.keys.insert_mode["<C-S>"] = "<esc>:wa<cr>"

lvim.keys.normal_mode["<leader>w"] = ":w!<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-S>"] = ":wa<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-z>"] = ":Telescope undo<CR>"
lvim.keys.normal_mode["<F5>"] = ":DapContinue<CR>"
lvim.keys.normal_mode["<F7>"] = ":DapToggleBreakpoint<CR>"
lvim.keys.normal_mode["<F8>"] = ":DapStepOut<CR>"
lvim.keys.normal_mode["<F9>"] = ":DapStepInto<CR>"
lvim.keys.normal_mode["<F10>"] = ":DapStepOver<CR>"
lvim.keys.normal_mode["<tab>s"] = ":Telescope spell_suggest<CR>"
lvim.keys.normal_mode["<C-q>"] = ":close<CR>"

vim.keymap.set("v", "<Bs>", '"_d')
vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set({ "n" }, "<M-.>", "<cmd>lua require('ts-node-action').node_action()<cr>", { desc = "Trigger Node Action" })

vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>",
    { desc = "Spider-w", noremap = true })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>",
    { desc = "Spider-e", noremap = true })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>",
    { desc = "Spider-b", noremap = true })
vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>",
    { desc = "Spider-ge", noremap = true })

lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["<leader>"] = { "<cmd>Telescope buffers<CR>", "which_key_ignore" }
lvim.builtin.which_key.mappings["E"] = { "<Plug>(Scalpel)", "Scalpel" }
lvim.builtin.which_key.mappings["m"] = {
    name = "Harpoon",
    -- h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon" },
    a = { "<cmd>Telescope harpoon marks<cr>", "Show Marked Files" },
    m = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark File" },
}
lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",

    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

lvim.builtin.which_key.mappings["z"] = {
    name = "+Extra",
    d = {
        name = "+Diff View",
        d = { "<CMD>DiffviewOpen<CR>", "Open Diff View" },
        c = { "<CMD>DiffviewClose<CR>", "Close Diff View" },
        h = { "<CMD>DiffviewFileHistory %<CR>", "Open File History for Current File" },
        H = { "<CMD>DiffviewFileHistory<CR>", "Open File History" },
    },
    t = { "<cmd>lua require 'lvim.core.terminal'.tig_ui_toggle()<cr>", "Tig" },
    -- z = { "<cmd>ZenMode<CR>", "Zen Mode" }
}

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}

lvim.builtin.telescope.on_config_done = function(telescope)
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "harpoon")
    pcall(telescope.load_extension, "lsp_handlers")
    pcall(telescope.load_extension, "vim_bookmarks")
    pcall(telescope.load_extension, "undo")
end

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.alpha.mode = "startify"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = false

lvim.builtin.treesitter.ensure_installed = { "javascript", "lua", "json", "python", "typescript", "tsx", "css" }

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.incremental_selection.enable = true
lvim.builtin.treesitter.textobjects.swap.enable = true
lvim.builtin.treesitter.textobjects.select.enable = true
lvim.builtin.treesitter.textobjects.move.enable = true
lvim.builtin.cmp.cmdline.enable = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local emmet_ls_opts = {
    capabilities = capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "scss" },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    },
} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("emmet_ls", emmet_ls_opts)

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    {
        command = "black",
        filetypes = { "python" },
    },
    {
        command = "isort",
        filetypes = { "python" },
    },
    {
        command = "prettier",
        extra_args = { "--print-with", "100", "--use-tabs", "true" },
        filetypes = { "scss", "css", "html", "yaml" },
    },
    -- {
    --     command = "prettierd",
    --     filetypes = { "scss", "css", "html", "yaml" },
    -- },
    {
        command = "rome",
        -- extra_args = { "format", "--write", "$FILENAME" },
        filetype = { "json", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
    -- { command = "flake8", filetypes = { "python" } },
    {
        command = "pylint",
        filetypes = { "python" },
    },
    -- { command = "mypy", filetypes = { "python" } },
    -- { command = "checkstyle", filetypes = { "java" }, extra_args = { "-c", "/google_checks.xml" }, },
    -- {
    --   command = "shellcheck",
    --   extra_args = { "--severity", "warning" },
    -- },
    {
        command = 'codespell',
        filetypes = { "javascript", "python" },
    },
})

lvim.plugins = {
    { "EdenEast/nightfox.nvim",     lazy = false,      priority = 1000 },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            -- transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent"
            }
        },
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        opts = {}

    },
    { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false,   priority = 1000 },
    { "projekt0n/github-nvim-theme" },
    { "nvimdev/zephyr-nvim" },
    { "sainnhe/sonokai" },
    { "tpope/vim-surround" },
    { "HiPhish/nvim-ts-rainbow2" },
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
    -- {
    --     "andymass/vim-matchup",
    --     event = "CursorMoved",
    --     config = function()
    --         vim.g.matchup_matchparen_offscreen = { method = "popup" }
    --     end,
    -- },
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
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require("lsp_signature").on_attach()
            require("lsp_signature").setup()
        end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup({
                mapping = { "jk" },        -- a table with mappings to use
                timeout = 500,             -- the time in which the keys must be hit in ms. Use option timeoutlen by default
                clear_empty_lines = false, -- clear line after escaping if there is only whitespace
                keys = "<Esc>",            -- keys used for escaping, if it is a function will use the result everytime
                -- example(recommended)
                -- keys = function()
                --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
                -- end,
            })
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },
    {
        "ThePrimeagen/harpoon",
        config = function()
            require("harpoon").setup({})
        end,
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        config = function() end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
            vim.diagnostic.config({ virtual_text = true })
            vim.diagnostic.config({
                virtual_lines = false,
            })
            -- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
            local flag = true
            vim.keymap.set(
                "",
                "<Tab>l",
                function()
                    if flag then
                        vim.diagnostic.config({
                            virtual_text = false,
                        })
                        vim.diagnostic.config({
                            virtual_lines = true,
                        })
                    else
                        vim.diagnostic.config({
                            virtual_text = true,
                        })
                        vim.diagnostic.config({
                            virtual_lines = false,
                        })
                    end
                    flag = not flag
                end, -- require("lsp_lines").toggle,
                {
                    desc = "Toggle lsp_lines",
                }
            )
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
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            "filesystem",
            "buffers",
            "git_status",
            "document_symbols",
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                window = {
                    position = "right",
                    width = 30,
                },
                buffers = {
                    follow_current_file = true,
                },
                filesystem = {
                    follow_current_file = true,
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_by_name = {
                            "node_modules",
                        },
                        never_show = {
                            ".DS_Store",
                            "thumbs.db",
                        },
                    },
                },
            })
        end,
    },
    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",
                transparent_background = true,
                term_colors = true,
            })
        end,
    },
    {
        "drybalka/tree-climber.nvim",
        config = function()
            local keyopts = { noremap = true, silent = true }
            vim.keymap.set(
                { "n", "v", "o" },
                "<M-o>",
                "<cmd>lua require('tree-climber').goto_parent({highlight = true})<CR>",
                keyopts
            )
            vim.keymap.set(
                { "n", "v", "o" },
                "<M-i>",
                "<cmd>lua require('tree-climber').goto_child({highlight = true})<CR>",
                keyopts
            )
            vim.keymap.set(
                { "n", "v", "o" },
                "<M-n>",
                require("tree-climber").goto_next,
                { noremap = true, silent = true }
            )
            vim.keymap.set(
                { "n", "v", "o" },
                "<M-p>",
                require("tree-climber").goto_prev,
                { noremap = true, silent = true }
            )
            -- vim.keymap.set({ 'n', 'v', 'o' }, '<M-p>',
            --   function()
            --     vim.cmd('lua require("tree-climber").goto_parent()')
            --     vim.cmd('lua require("tree-climber").goto_next()')
            --   end, keyopts)

            -- vim.keymap.set({ 'n', 'v', 'o' }, '<tab>n', require('tree-climber').select_node, keyopts)
            -- vim.keymap.set('n', '<c-k>', require('tree-climber').swap_prev, keyopts)
            -- vim.keymap.set('n', '<c-j>', require('tree-climber').swap_next, keyopts)
            -- vim.keymap.set('n', '<tab>h', require('tree-climber').highlight_node, keyopts)
        end,
    },
    {
        "folke/trouble.nvim",
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
        opts = {},
    },
    { "tpope/vim-repeat" },
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
    --                     -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
    --                     -- See the section on formatting for more details on how to customize.
    --                     -- @type NoiceFormat|string
    --                     format = "lsp_progress",
    --                     -- @type NoiceFormat|string
    --                     format_done = "lsp_progress_done",
    --                     throttle = 1000 / 30, -- frequency to update lsp progress message
    --                     view = "mini",
    --                 },
    --                 -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
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
    --             routes = { { view = "cmdline", filter = { event = "msg_showmode" } } },
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
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
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
    -- {
    --     "folke/zen-mode.nvim",
    --     opts = {
    --         -- your configuration comes here
    --         -- or leave it empty to use the default settings
    --         -- refer to the configuration section below
    --     },
    -- },
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        config = function()
        end
    },
    {
        'simrat39/symbols-outline.nvim',
        opts = {
            autofold_depth = 2,
            auto_unfold_hover = false
        },
    },
    { "shellRaining/hlchunk.nvim", event = { "UIEnter" }, opts = {} },
}
