local M = {}

---@alias telescope_themes
---| "cursor"   # see `telescope.themes.get_cursor()`
---| "dropdown" # see `telescope.themes.get_dropdown()`
---| "ivy"      # see `telescope.themes.get_ivy()`
---| "center"   # retain the default telescope theme

function M.config()
    local actions = require("lvim.utils.modules").require_on_exported_call "telescope.actions"
    lvim.builtin.telescope = {
        ---@usage disable telescope completely [not recommended]
        active = true,
        on_config_done = nil,
        -- theme = "dropdown", ---@type telescope_themes
        defaults = {
            prompt_prefix = lvim.icons.ui.Telescope .. " ",
            selection_caret = lvim.icons.ui.Forward .. " ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = nil,
            layout_strategy = nil,
            layout_config = {},
            vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
                "--smart-case", "--hidden", "--glob=!.git/" },
            ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
            mappings = {
                i = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-c>"] = actions.close,
                    ["<C-j>"] = actions.cycle_history_next,
                    ["<C-k>"] = actions.cycle_history_prev,
                    ["<C-q>"] = function(...)
                        actions.smart_send_to_qflist(...)
                        actions.open_qflist(...)
                    end,
                    ["<CR>"] = actions.select_default
                },
                n = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-q>"] = function(...)
                        actions.smart_send_to_qflist(...)
                        actions.open_qflist(...)
                    end
                }
            },
            file_ignore_patterns = {},
            path_display = { "smart" },
            winblend = 0,
            border = {},
            borderchars = nil,
            color_devicons = true,
            set_env = {
                ["COLORTERM"] = "truecolor"
            } -- default = nil,
        },
        pickers = {
            find_files = {
                hidden = true,
                previewer = true
            },
            live_grep = {
                -- @usage don't include the filename in the search results
                only_sort_text = true,
                previewer = true
            },
            grep_string = {
                only_sort_text = true,
                previewer = true
            },
            buffers = {
                initial_mode = "insert",
                theme = "dropdown",
                previewer = false,
                mappings = {
                    i = {
                        ["<C-d>"] = actions.delete_buffer
                    },
                    n = {
                        ["dd"] = actions.delete_buffer
                    }
                }
            },
            planets = {
                show_pluto = true,
                show_moon = true
            },
            git_files = {
                hidden = true,
                show_untracked = true,
                previewer = true
            },
            colorscheme = {
                enable_preview = true
            },
            lsp_references = {
                -- theme = "dropdown",
                theme = "ivy",
                initial_mode = "normal"
            },
            lsp_definitions = {
                -- theme = "dropdown",
                theme = "ivy",
                initial_mode = "normal"
            },
            lsp_declarations = {
                -- theme = "dropdown",
                theme = "ivy",
                initial_mode = "normal"
            },
            lsp_implementations = {
                -- theme = "dropdown",
                theme = "ivy",
                initial_mode = "normal"
            },
            spell_suggest = {
                theme = "cursor",
                initial_mode = "normal"
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case"        -- or "ignore_case" or "respect_case"
            },
            lsp_handlers = {
                disable = {},
                location = {
                    telescope = require('telescope.themes').get_ivy({}),
                    no_results_message = 'No references found'
                },
                symbol = {
                    telescope = require('telescope.themes').get_ivy({}),
                    no_results_message = 'No symbols found'
                },
                call_hierarchy = {
                    telescope = require('telescope.themes').get_ivy({}),
                    no_results_message = 'No calls found'
                },
                -- code_action = {
                --     telescope = require('telescope.themes').get_cursor({}),
                --     no_results_message = 'No code actions available',
                --     prefix = ''
                -- }
            },
            ["ui-select"] = {
                -- require("telescope.themes").get_dropdown { }
                require("telescope.themes").get_cursor {
                    initial_mode = 'normal'
                },
            },
            undo = {
                use_delta = true,
                use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
                layout_strategy = "vertical",
                layout_config = {
                    preview_height = 0.6,
                },
                side_by_side = false,
                diff_context_lines = vim.o.scrolloff,
                entry_format = "state #$ID, $STAT, $TIME",
                time_format = "",
                initial_mode = "normal",
                mappings = {
                    i = {
                        ["<c-Y>"] = require("telescope-undo.actions").yank_additions,
                        ["<c-y>"] = require("telescope-undo.actions").yank_deletions,
                        ["<c-u>"] = require("telescope-undo.actions").restore
                    },
                    n = {
                        ["Y"] = require("telescope-undo.actions").yank_additions,
                        ["y"] = require("telescope-undo.actions").yank_deletions,
                        ["u"] = require("telescope-undo.actions").restore
                    },
                },
            },
        }
    }
end

function M.setup()
    local previewers = require "telescope.previewers"
    local sorters = require "telescope.sorters"

    lvim.builtin.telescope = vim.tbl_extend("keep", {
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_generic_fuzzy_sorter
    }, lvim.builtin.telescope)

    local telescope = require "telescope"

    local theme = require("telescope.themes")["get_" .. (lvim.builtin.telescope.theme or "")]
    if theme then
        lvim.builtin.telescope.defaults = theme(lvim.builtin.telescope.defaults)
    end

    telescope.setup(lvim.builtin.telescope)

    if lvim.builtin.project.active then
        pcall(function()
            require("telescope").load_extension "projects"
        end)
    end

    if lvim.builtin.telescope.on_config_done then
        lvim.builtin.telescope.on_config_done(telescope)
    end

    if lvim.builtin.telescope.extensions and lvim.builtin.telescope.extensions.fzf then
        pcall(function()
            require("telescope").load_extension "fzf"
        end)
    end
end

return M
