local M = {}
local Log = require "lvim.core.log"

function M.config()
    lvim.builtin.treesitter = {
        on_config_done = nil,

        -- A list of parser names, or "all"
        ensure_installed = { "comment", "markdown_inline", "regex" },

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
            enable = true, -- false will disable the whole extension
            additional_vim_regex_highlighting = false,
            disable = function(lang, buf)
                if vim.tbl_contains({ "latex" }, lang) then
                    return true
                end

                local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
                return status_ok and big_file_detected
            end,
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
        autotag = { enable = false },
        textobjects = {
            swap = {
                enable = false,
                -- swap_next = textobj_swap_keymaps,
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
                    [']a'] = '@parameter.outer',
                    [']f'] = '@function.outer',
                    ['][f'] = '@function.inner',
                    [']l'] = '@loop.outer',
                    ['][l'] = '@loop.inner',
                    -- ['<M-n>'] = '@block.outer',
                    -- ['<M-i>'] = '@block.inner',
                },
                goto_next_end = {
                    [']]f'] = '@function.outer',
                    [']]c'] = '@class.outer',
                    [']]d'] = '@conditional.outer',
                    [']]l'] = '@loop.outer',
                    [']]a'] = '@parameter.outer',
                },
                goto_previous_start = {
                    ['[c'] = '@class.outer',
                    ['[a'] = '@parameter.outer',
                    ['[f'] = '@function.outer',
                    ['[[f'] = '@function.inner',
                    ['[l'] = '@loop.outer',
                    ['[[l'] = '@loop.inner',
                    -- ['<M-p>'] = '@block.outer',
                },
                goto_previous_end = {
                    ['[]f'] = '@function.outer',
                    ['[]c'] = '@class.outer',
                    ['[]d'] = '@conditional.outer',
                    ['[]l'] = '@loop.outer',
                    ['[]a'] = '@parameter.outer',
                },
            },

        },
        textsubjects = {
            enable = false,
            keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
        },
        playground = {
            enable = false,
            disable = {},
            updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<cr>",
                show_help = "?",
            },
        },
        rainbow = {
            enable = false,
            extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean

            -- Which query to use for finding delimiters
            -- Highlight the entire buffer all at once
            strategy = require('ts-rainbow').strategy.global,
            query = {
                'rainbow-parens',
                javascriptreact = 'rainbow-tags-react',
                javascript = 'rainbow-tags-react',
                tsx = 'rainbow-tags'
            },
            max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
        },
        incremental_selection = {
            enable = false,
            keymaps = {
                init_selection = "vn",
                node_incremental = "n",

                scope_incremental = "T",
                node_decremental = "N",
            },
        },
    }
end

function M.setup()
    -- avoid running in headless mode since it's harder to detect failures
    if #vim.api.nvim_list_uis() == 0 then
        Log:debug "headless mode detected, skipping running setup for treesitter"
        return
    end

    local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        Log:error "Failed to load nvim-treesitter.configs"
        return
    end

    local opts = vim.deepcopy(lvim.builtin.treesitter)

    treesitter_configs.setup(opts)

    if lvim.builtin.treesitter.on_config_done then
        lvim.builtin.treesitter.on_config_done(treesitter_configs)
    end

    -- handle deprecated API, https://github.com/windwp/nvim-autopairs/pull/324
    local ts_utils = require "nvim-treesitter.ts_utils"
    ts_utils.is_in_node_range = vim.treesitter.is_in_node_range
    ts_utils.get_node_range = vim.treesitter.get_node_range
end

return M
