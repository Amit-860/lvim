-- NOTE: lvim key bindings
lvim.keys.insert_mode["<C-s>"] = "<esc>:w<cr>"
lvim.keys.insert_mode["<C-S>"] = "<esc>:wa<cr>"
lvim.keys.insert_mode["<C-l>"] = "<Plug>(Tabout)"
lvim.keys.insert_mode["<C-h>"] = "<Plug>(TaboutBack)"

lvim.keys.normal_mode["<leader>w"] = ":w!<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-S>"] = ":wa<cr>"
-- lvim.keys.normal_mode["<C-q>"] = ":close<CR>"
lvim.keys.normal_mode["<C-n>"] = ":Neorg<CR>"
lvim.keys.normal_mode["<C-q>"] = ":q<CR>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<F10>"] = ":DapStepOver<CR>"
lvim.keys.normal_mode["<C-z>"] = ":UndotreeToggle<CR>"
lvim.keys.normal_mode["<F5>"] = ":DapContinue<CR>"
lvim.keys.normal_mode["<F7>"] = ":DapToggleBreakpoint<CR>"
lvim.keys.normal_mode["<F8>"] = ":DapStepOut<CR>"
lvim.keys.normal_mode["<F9>"] = ":DapStepInto<CR>"
lvim.keys.normal_mode["<tab>ha"] = ":lua require('harpoon.mark').add_file()<CR>"
lvim.keys.normal_mode["<tab>hm"] = ":Telescope harpoon marks<CR>"
lvim.keys.normal_mode["<tab>s"] = ":Telescope spell_suggest<CR>"
lvim.keys.normal_mode["<tab>m"] = ":Telescope vim_bookmarks<CR>"

vim.keymap.set("v", "<Bs>", '"_d')
vim.keymap.set('n', '<tab>T',
  function()
    vim.api.nvim_feedkeys(vim.api.nvim_eval('"OTAG:\\<space>\\<esc>\\<Plug>(comment_toggle_linewise_current)\\<cr>"'),
      'n', true)
  end,
  { desc = 'Mark Line' }
)
vim.keymap.set('n', '<tab>t',
  function()
    vim.api.nvim_command("lua require('telescope.builtin').live_grep({grep_open_files=true})")
    vim.api.nvim_feedkeys(vim.api.nvim_eval('"TAG:\\<esc>"'),
      'n', true)
  end,
  { desc = 'Find Marked Lines' }
)
vim.keymap.set('n', '<tab><tab>d', '<CMD>Glance definitions<CR>')
vim.keymap.set('n', '<tab><tab>r', '<CMD>Glance references<CR>')
vim.keymap.set('n', '<tab><tab>t', '<CMD>Glance type_definitions<CR>')
vim.keymap.set('n', '<tab><tab>i', '<CMD>Glance implementations<CR>')

-- text object keymapping
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
vim.keymap.set('n', 'vib',
  "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@block.inner','V')<CR>",
  { noremap = true, desc = "select inner block" }
)
vim.keymap.set('n', 'vab',
  "<cmd>lua require'nvim-treesitter.textobjects.select'.visual_select('@block.outer','V')<CR>",
  { noremap = true, desc = "select outer block" }
)
-- vim.keymap.set("i", "<C-k>",
--   function()
--     vim.lsp.buf.signature_help()
--   end
-- )
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
--
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")

-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.


-- NOTE: For which_key bindings
lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["<leader>"] = { "<cmd>Telescope buffers<CR>", "which_key_ignore" }
lvim.builtin.which_key.mappings["y"] = { "<cmd>lua require'telescope'.extensions.neoclip.neoclip{}<cr>", "Clipboard", }
lvim.builtin.which_key.mappings["E"] = { "<Plug>(Scalpel)", "Scalpel" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",

  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}


lvim.builtin.which_key.mappings["H"] = {
  name = "Harpoon",
  -- h = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon" },
  h = { "<cmd>Telescope harpoon marks<cr>", "Harpoon" },
  m = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Mark" },
}

lvim.builtin.which_key.mappings["x"] = {
  name = "eXtra",
  m = { "<cmd>Telescope marks<cr>", "Search Bookmarks" },
  s = { "<cmd>Telescope spell_suggest<cr>", "Spell Suggest" },
  c = { "<cmd>lua require('specs').toggle()<cr>", "Toggle Specs" },
}
