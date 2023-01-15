local M = {}
M.config = function()
  lvim.builtin.which_key = {
    ---@usage disable which-key completely [not recommended]
    active = true,
    on_config_done = nil,
    setup = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = false, -- default bindings on <c-w>
          nav = false, -- misc bindings to work with windows
          z = false, -- bindings for folds, spelling and others prefixed with z
          g = false, -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
      },
      icons = {
        breadcrumb = lvim.icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
        separator = lvim.icons.ui.BoldArrowRight, -- symbol used between a key and it's label
        group = lvim.icons.ui.Plus, -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 2, 28, 7, 32 }, -- extra window margin [top, right, bottom, left]
        -- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      show_help = false, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    },

    opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },
    vopts = {
      mode = "v", -- VISUAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },
    -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
    -- see https://neovim.io/doc/user/map.html#:map-cmd
    vmappings = {
      ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    },
    mappings = {
      [";"] = { "<cmd>Alpha<cr>", "which_key_ignore" },
      a = {
        name = "AI",
        a = { "<cmd>ChatGPT<cr>", "ChatGPT" },
        c = { "<cmd>ChatGPTEditWithInstructions<cr>", "ChatGPT" },
        o = { "<cmd>ChatGPTActAs<cr>", "ChatGPTActAs" }
      },
      -- ["w"] = { "<cmd>w!<CR>", "Save" },
      ["w"] = "which_key_ignore",
      ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment Toggle" },
      ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
      ["f"] = { name = "Files",
        f = { require("lvim.core.telescope.custom-finders").find_project_files, "Find File" },
        e = { "<cmd>Telescope file_browser<cr>", "File Browser" }
      },
      ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
      b = {
        name = "Buffers",
        j = { "<cmd>BufferLinePick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
        n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
        -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
        e = {
          "<cmd>BufferLinePickClose<cr>",
          "Pick which buffer to close",
        },
        h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
        l = {
          "<cmd>BufferLineCloseRight<cr>",
          "Close all to the right",
        },
        D = {
          "<cmd>BufferLineSortByDirectory<cr>",
          "Sort by directory",
        },
        L = {
          "<cmd>BufferLineSortByExtension<cr>",
          "Sort by language",
        },
      },
      P = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
      },

      -- " Available Debug Adapters:
      -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
      -- " Adapter configuration and installation instructions:
      -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
      -- " Debug Adapter protocol:
      -- "   https://microsoft.github.io/debug-adapter-protocol/
      -- " Debugging
      g = {
        name = "Git",
        g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
          "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
          "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = {
          "<cmd>Telescope git_bcommits<cr>",
          "Checkout commit(for current file)",
        },
        d = {
          "<cmd>Gitsigns diffthis HEAD<cr>",
          "Git Diff",
        },
        w = { function() require('telescope').extensions.git_worktree.git_worktrees() end, "Worktree" },
        W = { function() require('telescope').extensions.git_worktree.create_git_worktree() end, "Create Worktree" }
      },
      l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        f = { require("lvim.lsp.utils").format, "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Mason Info" },
        j = {
          vim.diagnostic.goto_next,
          "Next Diagnostic",
        },
        k = {
          vim.diagnostic.goto_prev,
          "Prev Diagnostic",
        },
        l = { vim.lsp.codelens.run, "CodeLens Action" },
        q = { vim.diagnostic.setloclist, "Quickfix" },
        r = { vim.lsp.buf.rename, "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          "Workspace Symbols",
        },
        e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
      },
      L = {
        name = "+LunarVim",
        c = {
          "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>",
          "Edit config.lua",
        },
        d = { "<cmd>LvimDocs<cr>", "View LunarVim's docs" },
        f = {
          "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
          "Find LunarVim files",
        },
        g = {
          "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>",
          "Grep LunarVim files",
        },
        k = { "<cmd>Telescope keymaps<cr>", "View LunarVim's keymappings" },
        i = {
          "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>",
          "Toggle LunarVim Info",
        },
        I = {
          "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
          "View LunarVim's changelog",
        },
        l = {
          name = "+logs",
          d = {
            "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
            "view default log",
          },
          D = {
            "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
            "Open the default logfile",
          },
          l = {
            "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
            "view lsp log",
          },
          L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
          n = {
            "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
            "view neovim log",
          },
          N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
          p = {
            "<cmd>lua require('lvim.core.terminal').toggle_log_view(get_cache_dir() .. '/packer.nvim.log')<cr>",
            "view packer log",
          },
          P = { "<cmd>edit $LUNARVIM_CACHE_DIR/packer.nvim.log<cr>", "Open the Packer logfile" },
        },
        r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
        u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
      },
      s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        t = { "<cmd>Telescope live_grep<cr>", "Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        s = { "/\\<<C-r><C-w>\\>/<CR>", "Word Under Cursor" },
        p = {
          "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
          "Colorscheme with Preview",
        },
      },
      T = {
        name = "Treesitter",
        i = { ":TSConfigInfo<cr>", "Info" },
      },
      ["q"] = {
        name = "Quit",
        q = { "<cmd>lua require('lvim.utils.functions').smart_quit()<CR>", "Quit" },
        Q = { "<CMD>q!<CR>", "Force Quit" },
        s = { "<CMD>wq<CR>", "Write & Quit" },
        S = { "<CMD>wqa<CR>", "Write All & Quit" }
      },
      n = {
        name = "Notes",
        t = { name = "Task" },
        n = "New Note",
        g = { name = "goto" },
        i = { "<cmd>Neorg index<cr>", "Index" },
        m = {
          name = "mode",
          n = { "<cmd>Neorg mode norg<cr>", "Norg Mode" },
          h = { "<cmd>Neorg mode tracerse-heading<cr>", "Norg Mode" },
          t = { "<cmd>Neorg toc split<cr>", "ToC Split" },
        },
        w = { "<cmd>Neorg workspace home<cr>", "Workspace" },
        l = {
          function()
            if (vim.bo.filetype == "norg") then
              vim.api.nvim_feedkeys("diw", 'n', true)
              vim.api.nvim_feedkeys(vim.api.nvim_eval('"a\\<esc>"'), 'n', true)
              vim.api.nvim_feedkeys("p", 'n', true)
              vim.api.nvim_feedkeys(vim.api.nvim_eval('"a\\<esc>"'), 'n', true)
              vim.api.nvim_feedkeys(vim.api.nvim_eval('"a {:\\<esc>"'), 'n', true)
              vim.api.nvim_feedkeys(vim.api.nvim_eval('"pa\\<esc>"'), 'n', true)
              vim.api.nvim_feedkeys(vim.api.nvim_eval('"a:}\\<esc>"'), 'n', true)
            else
              vim.api.nvim_command("echo NOT a norg file")
            end
          end,
          "Link"
        }
      },
      S = {
        name = "Session",
        S = { "<CMD>SessionManager load_last_session<CR>", "Load Last Session" },
        D = { "<cmd>SessionManager delete_session<cr>", "Delete Session" },
        m = { "<cmd>Telescope vim_bookmarks<cr>", "Global Marks" },
        s = { "<cmd>SessionManager save_current_session<cr>", "Save Current Session" },
        l = { "<cmd>SessionManager load_session<cr>", "Load Session" },
        d = { "<cmd>SessionManager load_current_dir_session<cr>", "Load Current Dir Session" },
        w = {
          name = "Window",
          n = { "<cmd>tabnew %<cr>", "Tab New" },
          c = { "<cmd>tabclose<cr>", "Tab Close" },
          h = { "<cmd>tabprevious<cr>", "Tab Previous" },
          l = { "<cmd>tabnext<cr>", "Tab Next" },
          m = { "<cmd>tabmove<cr>", "Tab Move" },
          f = { "<cmd>tabs<cr>", "Tab Find" },
          v = { "<cmd>vsplit<cr>", "Verticle Split" },
          s = { "<cmd>vsplit<cr>", "Horizontal Split" },
        },
      },
      d = {
        name = "Debug",
        n = { "<cmd>DapStepOver<CR>", "Step Over" },
        C = { "<CMD>DapLoadLaunchJSON<CR>", "Config" },
        x = { "<CMD>DapRestartFrame<CR>", "Restart Frame" },
        i = { "<CMD>DapStepInto<CR>", "Step Into" },
        o = { "<CMD>DapStepOut<CR>", "Step Out" },
        c = { "<CMD>DapContinue<CR>", "Continue" },
        T = { "<CMD>DapTerminate<CR>", "Terminate" },
        b = { "<CMD>DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
        B = { "<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
          "Conditional Breakpoint" },
        u = { "<CMD>lua require('dapui').toggle()<CR>", "Toggle UI" },
        r = {
          -- function()
          --   if (vim.bo.filetype == "python")
          --   then
          --     -- vim.api.nvim_command("w | !python %") -- doesnt work properly
          --     -- vim.api.nvim_eval('":w | !python %\\<cr>"') -- evaluate it as a nvim expression
          --     -- vim.api.nvim_feedkeys(":w | !python %", 'n', true) -- micic keystrok
          --     vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !python %\\<cr>"'), 'n', true)
          --   elseif (vim.bo.filetype == "javascript")
          --   then
          --     vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !node %\\<cr>"'), 'n', true)
          --   elseif (vim.bo.filetype == "lua")
          --   then
          --     vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !lua %\\<cr>"'), 'n', true)
          --   elseif (vim.bo.filetype == "java")
          --   then
          --     vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !java %\\<cr>"'), 'n', true)
          --     -- vim.api.nvim_command("!java %:r") -- doesnt work properly
          --   elseif (vim.bo.filetype == "cs")
          --   then
          --     vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !dotnet run\\<cr>"'), 'n', true)
          --     -- vim.api.nvim_command("!java %:r") -- doesnt work properly
          --   end
          -- end
          "<cmd>CompileAuto<cr>",
          "Run"
        },
        -- R = { "<CMD>DapTerminate<CR><CMD>DapContinue<CR>", "Restart" },
        R = { "<CMD>lua require'dap'.run_last()<CR>", "Restart Adapter" },
        t = {
          name = "Telescope",
          c = { "<cmd>require'telescope'.extensions.dap.commands{}<cr>", "Commands" },
          C = { "<cmd>require'telescope'.extensions.dap.configurations{}<cr>", "Configuration" },
          b = { "<cmd>require'telescope'.extensions.dap.list_breakpoints{}<cr>", "List Breakpoint" },
          v = { "<cmd>require'telescope'.extensions.dap.variables{}<cr>", "Variables" },
          f = { "<cmd>require'telescope'.extensions.dap.frames{}<cr>", "Frame" },
        }
      }
    },
  }
end

M.setup = function()
  local which_key = require "which-key"

  which_key.setup(lvim.builtin.which_key.setup)

  local opts = lvim.builtin.which_key.opts
  local vopts = lvim.builtin.which_key.vopts

  local mappings = lvim.builtin.which_key.mappings
  local vmappings = lvim.builtin.which_key.vmappings

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)

  if lvim.builtin.which_key.on_config_done then
    lvim.builtin.which_key.on_config_done(which_key)
  end

  local wk = require("which-key")
  wk.register({
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    D = { "<cmd>Telescope diagnostics theme=get_ivy<cr>", "Diagnostics" },
    f = { require("lvim.lsp.utils").format, "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    p = {
      name = "Peek",
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    -- s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    s = { "<cmd>SymbolsOutline<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    R = { vim.lsp.buf.rename, "LSP Rename" },
    e = { "<cmd>RnvimrToggle<CR>", "Ranger" },
    w = { "<cmd>cd %:p:h<cr>", "Change Directory to Current Open File" },
    G = { "<cmd>Neogit<cr>", "Neogit" },
    -- g = "Glance",
    -- F = { "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Re-Factoring" },
    ["<F12>"] = {
      name = "Struc",
      r = { "<cmd>Telescope lsp_references<cr>", "Reference" },
      p = "Print Selected",
      P = { "<cmd>lua require('refactoring').debug.cleanup({})<cr>", "'Print' Clean Up", noremap = true },
      d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
      i = { "<cmd>Telescope lsp_implementations<cr>", "Implementation" },
      q = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
      ["/"] = { "A # noqa<esc>", "Ignore Error" }
    },
    m = { "<cmd>Telescope harpoon marks<cr>", "Harpoon Marks" },
    M = { "<cmd>Telescope vim_bookmarks<cr>", "Global Marks" },
    T = {
      name = "+Trouble",
      r = { "<cmd>Trouble lsp_references<cr>", "References" },
      f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
      d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
      q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
      l = { "<cmd>Trouble loclist<cr>", "LocationList" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
    },
  }, { prefix = "<F12>" })

  wk.register({
    ["<F34>"] = { "<cmd>DapStepOver<CR>", "Step Over" },
    C = { "<CMD>DapLoadLaunchJSON<CR>", "Config" },
    x = { "<CMD>DapRestartFrame<CR>", "Restart Frame" },
    i = { "<CMD>DapStepInto<CR>", "Step Into" },
    o = { "<CMD>DapStepOut<CR>", "Step Out" },
    c = { "<CMD>DapContinue<CR>", "Continue" },
    T = { "<CMD>DapTerminate<CR>", "Terminate" },
    b = { "<CMD>DapToggleBreakpoint<CR>", "Toggle Breakpoint" },
    B = { "<CMD>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Conditional Breakpoint" },
    u = { "<CMD>lua require('dapui').toggle()<CR>", "Toggle UI" },
    r = {
      --   function()
      --     if (vim.bo.filetype == "python")
      --     then
      --       -- vim.api.nvim_command("w | !python %") -- doesnt work properly
      --       -- vim.api.nvim_eval('":w | !python %\\<cr>"') -- evaluate it as a nvim expression
      --       -- vim.api.nvim_feedkeys(":w | !python %", 'n', true) -- micic keystrok
      --       vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !python %\\<cr>"'), 'n', true)
      --     elseif (vim.bo.filetype == "javascript")
      --     then
      --       vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !node %\\<cr>"'), 'n', true)
      --     elseif (vim.bo.filetype == "lua")
      --     then
      --       vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !lua %\\<cr>"'), 'n', true)
      --     elseif (vim.bo.filetype == "java")
      --     then
      --       vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !java %\\<cr>"'), 'n', true)
      --       -- vim.api.nvim_command("!java %:r") -- doesnt work properly
      --     elseif (vim.bo.filetype == "cs")
      --     then
      --       vim.api.nvim_feedkeys(vim.api.nvim_eval('":w | !dotnet run\\<cr>"'), 'n', true)
      --       -- vim.api.nvim_command("!java %:r") -- doesnt work properly
      --     end
      --   end,
      "<cmd>CompileAuto<cr>", "Run"
    },
    R = { "<CMD>lua require'dap'.run_last()<CR>", "Restart Adapter" },
    t = {
      name = "Telescope",
      c = { "<cmd>lua require'telescope'.extensions.dap.commands{}<cr>", "Commands" },
      C = { "<cmd>lua require'telescope'.extensions.dap.configurations{}<cr>", "Configuration" },
      b = { "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<cr>", "List Breakpoint" },
      v = { "<cmd>lua require'telescope'.extensions.dap.variables{}<cr>", "Variables" },
      f = { "<cmd>lua require'telescope'.extensions.dap.frames{}<cr>", "Frame" },
    }
  }, { prefix = "<F34>" })

  wk.register({
    ["<F2>"] = { "<CMD>SessionManager load_last_session<CR>", "Load Last Session" },
    t = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
    D = { "<cmd>SessionManager delete_session<cr>", "Delete Session" },
    m = { "<cmd>Telescope vim_bookmarks<cr>", "Global Marks" },
    s = { "<cmd>SessionManager save_current_session<cr>", "Save Current Session" },
    l = { "<cmd>SessionManager load_session<cr>", "Load Session" },
    d = { "<cmd>SessionManager load_current_dir_session<cr>", "Load Current Dir Session" },
    f = {
      name = "Fold",
      s = { "<cmd>mkview<cr>", "Save Code Fold" },
      f = { "<cmd>loadview<cr>", "Load Code Fold" },
    },
    w = {
      name = "Window",
      n = { "<cmd>tabnew %<cr>", "Tab New" },
      c = { "<cmd>tabclose<cr>", "Tab Close" },
      h = { "<cmd>tabprevious<cr>", "Tab Previous" },
      l = { "<cmd>tabnext<cr>", "Tab Next" },
      m = { "<cmd>tabmove<cr>", "Tab Move" },
      f = { "<cmd>tabs<cr>", "Tab Find" },
      v = { "<cmd>vsplit<cr>", "Verticle Split" },
      s = { "<cmd>vsplit<cr>", "Horizontal Split" },
    },
  }, { prefix = "<F2>" })

  wk.register({
    a = { name = "around" },
    i = { name = "inside" },
  }, { prefix = 'v' })

end

return M
