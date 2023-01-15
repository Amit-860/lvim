local M = {}

local function get_pickers(actions)
  return {
    find_files = {
      -- theme = "dropdown",
      hidden = true,
      -- previewer = false,
    },
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
      -- theme = "dropdown",
    },
    grep_string = {
      only_sort_text = true,
      -- theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
      previewer = false,
      initial_mode = "insert",
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
    planets = {
      show_pluto = true,
      show_moon = true,
    },
    git_files = {
      -- theme = "dropdown",
      hidden = true,
      -- previewer = false,
      show_untracked = true,
    },
    lsp_references = {
      -- theme = "dropdown",
      theme = "ivy",
      initial_mode = "normal",
    },
    lsp_definitions = {
      -- theme = "dropdown",
      theme = "ivy",
      initial_mode = "normal",
    },
    lsp_declarations = {
      -- theme = "dropdown",
      theme = "ivy",
      initial_mode = "normal",
    },
    lsp_implementations = {
      -- theme = "dropdown",
      theme = "ivy",
      initial_mode = "normal",
    },
  }
end

function M.config()
  -- Define this minimal config so that it's available if telescope is not yet available.

  lvim.builtin.telescope = {
    ---@usage disable telescope completely [not recommended]
    active = true,
    on_config_done = nil,
  }

  local ok, actions = pcall(require, "telescope.actions")
  if not ok then
    return
  end

  local fb_actions = require "telescope".extensions.file_browser.actions

  lvim.builtin.telescope = vim.tbl_extend("force", lvim.builtin.telescope, {
    defaults = {
      prompt_prefix = lvim.icons.ui.Telescope .. " ",
      selection_caret = lvim.icons.ui.Forward .. " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      -- sorting_strategy = "ascending",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.75,
        preview_cutoff = 120,
        horizontal = {
          preview_width = function(_, cols, _)
            if cols < 120 then
              return math.floor(cols * 0.5)
            end
            return math.floor(cols * 0.6)
          end,
          mirror = false,
          -- prompt_position = "top",
        },
        vertical = { mirror = false },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<CR>"] = actions.select_default,
        },
        n = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        },
      },
      pickers = get_pickers(actions),
      file_ignore_patterns = {},
      path_display = { "smart" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
    pickers = get_pickers(actions),
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        }
      },
      file_browser = {
        theme = "ivy",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        grouped = true,
        hide_parent_dir = true,
        initial_mode = "normal",
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
            ["<C-a>"] = fb_actions.create,
            ["<C-h>"] = fb_actions.toggle_hidden,
          },
          ["n"] = {
            -- your custom normal mode mappings
            q = actions.close,
            h = fb_actions.goto_parent_dir,
            l = actions.select_default,
            ["<C-a>"] = fb_actions.create,
            ["<C-h>"] = fb_actions.toggle_hidden,
            ["\\"] = actions.toggle_selection + actions.move_selection_next,
            ["|"] = actions.toggle_selection + actions.move_selection_previous,
          },
        },
      },
      lsp_handlers = {
        disable = {},
        location = {
          telescope = require('telescope.themes').get_ivy({}),
          no_results_message = 'No references found',
        },
        symbol = {
          telescope = require('telescope.themes').get_ivy({}),
          no_results_message = 'No symbols found',
        },
        call_hierarchy = {
          telescope = require('telescope.themes').get_ivy({}),
          no_results_message = 'No calls found',
        },
        code_action = {
          telescope = require('telescope.themes').get_dropdown({}),
          no_results_message = 'No code actions available',
          prefix = '',
        },
      },
    },
  })
end

function M.setup()
  local previewers = require "telescope.previewers"
  local sorters = require "telescope.sorters"

  lvim.builtin.telescope = vim.tbl_extend("keep", {
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
  }, lvim.builtin.telescope)

  local telescope = require "telescope"
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
