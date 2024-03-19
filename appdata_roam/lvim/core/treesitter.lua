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
                    [']sc'] = '@class.inner',

                    [']f'] = '@function.outer',  -- outside of the next function
                    [']sf'] = '@function.inner', -- inside the start of the next function

                    [']l'] = '@loop.outer',
                    [']sl'] = '@loop.inner',

                    [']d'] = '@conditional.outer',
                    [']sd'] = '@conditional.inner',

                    -- [']]'] = { query = { '@parameter.inner', '@attribute.inner', '@assignment.outer', '@call.inner',
                    --     '@statement.outer', '@function.inner', '@loop.inner', '@return.inner', '@scopename.inner',
                    --     '@conditional.inner', } },
                    [']]'] = { query = { '@parameter.inner', '@attribute.inner', '@assignment.lhs', '@assignment.rhs' } },
                },
                goto_next_end = {
                    [']ec'] = '@class.inner',
                    [']ef'] = '@function.inner', -- inside the end of the next function
                    [']ed'] = '@conditional.inner',
                    [']el'] = '@loop.inner',
                },
                goto_previous_start = {
                    ['[c'] = '@class.outer',
                    ['[sc'] = '@class.inner',

                    ['[f'] = '@function.outer',  -- outside of the previous function
                    ['[sf'] = '@function.inner', -- inside the start of the previous function

                    ['[l'] = '@loop.outer',
                    ['[sl'] = '@loop.inner',

                    ['[d'] = '@conditional.outer',
                    ['[sd'] = '@conditional.inner',

                    -- ['[['] = { query = { '@parameter.inner', '@attribute.inner', '@assignment.outer', '@call.inner',
                    --     '@statement.outer', '@function.inner', '@loop.inner', '@return.inner', '@scopename.inner',
                    --     '@conditional.inner', } },
                    ['[['] = { query = { '@parameter.inner', '@attribute.inner', '@assignment.lhs', '@assignment.rhs' } },
                },
                goto_previous_end = {
                    ['[ec'] = '@class.inner',
                    ['[ef'] = '@function.inner', -- inside of the end of the previous function
                    ['[el'] = '@loop.inner',
                    ['[ed'] = '@conditional.inner',

                    ['[]'] = "@nothing", -- just to remove default vim keybindings
                    [']['] = "@nothing"
                },
            },

        },
        textsubjects = {
            enable = false,
            keymaps = { ["r"] = "textsubjects-smart", ["R"] = "textsubjects-big" },
            prev_selection = ',', -- (Optional) keymap to select the previous selection
            -- keymaps = {
            --     ['.'] = 'textsubjects-smart',
            --     [';'] = 'textsubjects-container-outer',
            --     ['i;'] = 'textsubjects-container-inner',
            -- },
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
            -- strategy = require('ts-rainbow').strategy.global,
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

    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
end

return M
