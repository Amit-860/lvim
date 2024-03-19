-- Video  Tutorials: https://www.youtube.com/watch?v=sFA11kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- Enable powershell as your default shell

-- "C:\Program Files\PowerShell\7\pwsh.exe" -ExecutionPolicy Bypass C:\Users\AMIT\.local\bin\lvid.ps1
-- C:\Users\AMIT\scoop\shims\nu.exe C:\Users\AMIT\.local\bin\lvid.nu

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
    vim.cmd([[set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
 		  \,a:blinkwait1000-blinkoff500-blinkon500-Cursor/lCursor]])
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h10.4"
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 4
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_cursor_vfx_mode = "wireframe"
    -- vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_cursor_vfx_particle_density = 10
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_underline_automatic_scaling = true
    vim.g.neovide_no_idle = false
    vim.g.neovide_cursor_unfocused_outline_width = 0.05

    vim.g.neovide_transparency = 0.75
    vim.g.neovide_fullscreen = true

    vim.o.winblend = 15
    vim.o.pumblend = 50

    lvim.transparent_window = false
    lvim.builtin.telescope.defaults.winblend = 75
    lvim.builtin.which_key.setup.window.winblend = 75
    lvim.builtin['terminal'].float_opts.winblend = 70
    lvim.colorscheme = "terafox"
else
    lvim.transparent_window = true
    lvim.colorscheme = "terafox"
    -- lvim.colorscheme = "github_dark_dimmed"
end

-- lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.lsp.installer.setup.automatic_installation = false
lvim.builtin.autopairs.active = true
lvim.builtin.which_key.active = true
lvim.lazy.opts.checker = {
    frequency = 604800,
}

vim.opt.cmdwinheight = 1
vim.opt.cmdheight = 0
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
-- vim.opt.foldmethod = "expr"                     -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldnestmax = 10
vim.opt.foldlevel = 4
vim.opt.foldenable = false
vim.opt.timeoutlen = 500
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "o" }
    end,
})

lvim.leader = "space"


-- add your own keymapping
lvim.keys.insert_mode["<C-S>"] = "<esc>:wa<cr>"
lvim.keys.normal_mode["<leader>w"] = ":w!<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-S>"] = ":wa<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<M-u>"] = ":Telescope undo<CR>"
--lvim.keys.normal_mode["<F5>"] = function() require('dap').continue() end
--lvim.keys.normal_mode["<F7>"] = function() require('dap').toggle_breakpoint() end
--lvim.keys.normal_mode["<M-b>"] = function() require('dap').toggle_breakpoint() end
--lvim.keys.normal_mode["<F8>"] = function() require('dap').step_out() end
--lvim.keys.normal_mode["<F9>"] = function() require('dap').step_into() end
--lvim.keys.normal_mode["<M-.>"] = function() require('dap').step_into() end
--lvim.keys.normal_mode["<F10>"] = function() require('dap').step_over() end
lvim.keys.normal_mode["<C-q>"] = ":close<CR>"


vim.keymap.set({ "n", "i" }, "<C-s>", "<esc>:w<cr>", { silent = true, noremap = true })
vim.keymap.set("v", "<BS>", '"_d')
vim.keymap.set('n', 'U', '<C-r>')
vim.keymap.set('n', '<M-l>', '<C-^>')
vim.keymap.set({ "n", "o", "x" }, "gs", '_', { noremap = true, silent = true, desc = "Goto first Non-whitespace char" })
vim.keymap.set({ "n", "o", "x" }, "gh", '0', { noremap = true, silent = true, desc = "Goto BOL" })
vim.keymap.set({ "n", "o", "x" }, "gl", '$', { noremap = true, silent = true, desc = "Goto EOL" })
vim.keymap.set({ "i", "n" }, "<M-i>", "<CMD>lua vim.lsp.buf.signature_help()<CR>")
vim.keymap.set("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set({ "n" }, "<M-n>", "<cmd>lua require('ts-node-action').node_action()<cr>", { desc = "Trigger Node Action" })

vim.keymap.set({ "n", "o", "x", "v" }, "w", "<cmd>lua require('spider').motion('w')<CR>",
    { desc = "Spider-w", noremap = true })
vim.keymap.set({ "n", "o", "x", "v" }, "e", "<cmd>lua require('spider').motion('e')<CR>",
    { desc = "Spider-e", noremap = true })
vim.keymap.set({ "n", "o", "x", "v" }, "b", "<cmd>lua require('spider').motion('b')<CR>",
    { desc = "Spider-b", noremap = true })
vim.keymap.set({ "n", "o", "x", "v" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>",
    { desc = "Spider-ge", noremap = true })

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
vim.keymap.set("n", "<M-p>", "<CMD>Telescope yank_history<CR>")

lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["<leader>"] = { "<cmd>Telescope buffers<CR>", "which_key_ignore" }
lvim.builtin.which_key.mappings["E"] = { "<Plug>(Scalpel)", "Scalpel" }
lvim.builtin.which_key.mappings["m"] = {
    name = "Harpoon",
    -- h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon" },
    m = { "<cmd>Telescope harpoon marks<cr>", "Show Marked Files" },
    a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add/Mark File" },
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

--  lvim.builtin.telescope.on_config_done = function(telescope)
  --  pcall(telescope.load_extension, "ui-select")
  --  pcall(telescope.load_extension, "harpoon")
  --  pcall(telescope.load_extension, "lsp_handlers")
  --  pcall(telescope.load_extension, "vim_bookmarks")
  --  pcall(telescope.load_extension, "undo")
  --  pcall(telescope.load_extension, "yank_history")
  --  pcall(telescope.load_extension, "dap")
--  end

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.alpha.mode = "startify"
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.terminal.active = true
lvim.builtin.breadcrumbs.active = false
lvim.builtin.indentlines.active = false
lvim.builtin.illuminate.active = false

lvim.builtin.treesitter.ensure_installed = { "html", "javascript", "lua", "json", "python", "typescript", "tsx",
    "css" }

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.matchup = {
    enable = true,                                                                  -- mandatory, false will disable the whole extension
    disable = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- optional, list of language that will be disabled
}
lvim.builtin.treesitter.autotag = {
    enable = true,
    enable_rename = true,
    enable_close = true,
    enable_close_on_slash = true,
    filetypes = {
        'html', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'xml'
    }
}
lvim.builtin.treesitter.incremental_selection.enable = true
lvim.builtin.treesitter.textobjects.swap.enable = true
lvim.builtin.treesitter.textobjects.select.enable = true
lvim.builtin.treesitter.textobjects.move.enable = true
lvim.builtin.cmp.cmdline.enable = true


-- NOTE: nul_ls formatters
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({})


-- NOTE: nul_ls linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
    {
        command = "pylint",
        filetypes = { 'python' }
    },
})


-- NOTE: lsp config below
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
}
require("lvim.lsp.manager").setup("emmet_ls", emmet_ls_opts)

require("lvim.lsp.manager").setup("rome", {
    capabilities = capabilities,
    settings = {
        formatter = {
            enabled = false,
            indentStyle = "tab",
            lineWidth = 120,
            indentSize = 4,
        },
        linter = {
            enabled = true,
            rules = {
                all = true
            }
        },
        organizeImports = {
            enabled = true
        }
    }
})

local ruff_opts = {
    capabilities = capabilities,
}
require("lvim.lsp.manager").setup("ruff_lsp", ruff_opts)


-- NOTE: plugin config
-- lvim.plugins = require('myPlugins')


-- NOTE: autocommands
lvim.autocommands = {
    {
        "BufEnter",
        {
            pattern = { "*.http" },
            command = "set filetype=http"
        }
    },
--    {
--        "BufWritePre",
--        {
--            pattern = "*",
--            callback = function(args)
--                require("conform").format({ bufnr = args.buf, quiet = true, async = true })
--            end,
--        }
--    },
}
