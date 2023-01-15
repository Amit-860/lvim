-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.transparent_window = true

-- lvim.colorscheme = "nightfox"
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "nord"
-- lvim.colorscheme = "github_dark_default"
-- lvim.colorscheme = "github_dark_colorblind"
-- lvim.colorscheme = "habamax"
-- lvim.colorscheme = "OceanicNext"
-- lvim.colorscheme = "ayu"
-- lvim.colorscheme = "onedark"
-- lvim.colorscheme = "boo"
-- lvim.colorscheme = "lunar"
-- lvim.colorscheme = "crimson_moonlight"
-- lvim.colorscheme = "forest_stream"
lvim.colorscheme = "kanagawa"
-- lvim.colorscheme = "gruvbox-material"
-- lvim.colorscheme = "catppuccin-frappe"
-- lvim.colorscheme = "catppuccin-macchiato"
-- lvim.colorscheme = "gruvbox-material"
-- lvim.colorscheme = "edge"
-- vim.g.edge_style = 'aura'

-- Example config in Lua
vim.g.monokaipro_transparent = true
vim.g.monokaipro_flat_float = true
vim.g.monokaipro_flat_sidebar = true
vim.g.monokaipro_flat_term = true
vim.g.monokaipro_filter = "octogon" -- default, machine, ristretto, octogon, spectrum, classic
vim.g.monokaipro_italic_functions = true
vim.g.monokaipro_sidebars = { "vista_kind", "packer" }
vim.g.monokaipro_flat_term = true

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.monokaipro_colors = { hint = "orange", error = "#8b0000" }
-- lvim.colorscheme = 'monokaipro'

lvim.lsp.automatic_servers_installation = false

vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldnestmax = 10
vim.opt.foldlevel = 4
vim.opt.foldenable = false
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "o" } end,

})
-- vim.opt.listchars:append "eol:↴"
-- vim.opt.listchars:append "eol:↶"
-- vim.opt.listchars:append "eol:⮦"
-- vim.opt.timeoutlen = 500

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- add your own keymapping
require('key_bindings')

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
  -- pcall(telescope.load_extension, "frecency")
  -- pcall(telescope.load_extension, "neoclip")
  pcall(telescope.load_extension, "vim_bookmarks")
  pcall(telescope.load_extension, "dap")
  pcall(telescope.load_extension, "harpoon")
  pcall(telescope.load_extension, "lsp_handlers")
  pcall(telescope.load_extension, "ui-select")
  pcall(telescope.load_extension, "refactoring")
  pcall(telescope.load_extension, "git_worktree")
  pcall(telescope.load_extension, "attempt")
  pcall(telescope.load_extension, "file_browser")

  -- any other extensions loading
end

-- Use which-key to add extra bindings with the leader-key prefix

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.alpha.mode = "startify"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.incremental_selection.enable = true
lvim.builtin.treesitter.textobjects.swap.enable = true
lvim.builtin.treesitter.textobjects.select.enable = true
lvim.builtin.treesitter.textobjects.move.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local emmet_ls_opts = {
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
require("lvim.lsp.manager").setup("emmet_ls", emmet_ls_opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "prettier",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--print-with", "100" },
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "typescript", "typescriptreact" },
  -- },
  -- {
  --   -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --   command = "prettierd",
  --   ---@usage arguments to pass to the formatter
  --   -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --   extra_args = { "--print-with", "100" },
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "typescript", "typescriptreact" },
  -- },
  { command = "rome", filetype = { "javascript", "typescript", "javascriptreact", "typescriptreact" } }
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8", filetypes = { "python" } },
  { command = "pylint", filetypes = { "python" } },
  -- { command = "mypy", filetypes = { "python" } },
  -- { command = "checkstyle", filetypes = { "java" }, extra_args = { "-c", "/google_checks.xml" }, },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-wdth 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
  { command = "alex",
    filetypes = { "markdown", "text" }
  },
}


-- Additional Plugins
lvim.plugins = require('plugins')

-- custom tweaks
lvim.builtin.indentlines.options.show_current_context = true
lvim.builtin.indentlines.options.show_current_context_start = false
lvim.builtin.indentlines.options.space_char_blankline = " "
lvim.builtin.indentlines.options.show_end_of_line = true

lvim.autocommands = {
  {
    { "BufEnter", "Filetype" },
    {
      desc = "Enable Spell Check and Suggestion on text, markdown and norg files",
      pattern = { "*" },
      callback = function()
        if vim.tbl_contains({ "norg", "text", "markdown" }, vim.o.filetype) then
          vim.opt.spell = true
          vim.opt.spelllang = { 'en_us' }
        elseif vim.o.buftype == "" then
          vim.opt.spell = false
        end
      end
    }
  },
}
