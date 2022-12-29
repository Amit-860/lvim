local leader = "<Space>"
local keybindings = {
  -- default_keybindings = false,
  neorg_leader = leader,
  hook = function(keybinds)
    keybinds.remap_key("norg", "n", "gtd", leader .. "ntd")
    keybinds.remap_key("norg", "n", "gtu", leader .. "ntu")
    keybinds.remap_key("norg", "n", "gth", leader .. "nth")
    keybinds.remap_key("norg", "n", "gtp", leader .. "ntp")
    keybinds.remap_key("norg", "n", "gtc", leader .. "ntc")
    keybinds.remap_key("norg", "n", "gtr", leader .. "ntr")
    keybinds.remap_key("norg", "n", "gti", leader .. "nti")
    keybinds.remap_key("norg", "n", "<C-Space>", leader .. "ntC")

    keybinds.remap_key("norg", "n", "<leader>tc", leader .. "nTc")
    keybinds.remap_key("norg", "n", "<leader>tv", leader .. "nTv")
    keybinds.remap_key("norg", "n", "<leader>te", leader .. "nTe")

    keybinds.remap_event("norg", "n", leader .. "ngl", "core.norg.esupports.hop.hop-link")
    keybinds.remap_event("norg", "n", leader .. "ngl", "core.norg.esupports.hop.hop-link", "vsplit")

    keybinds.unmap("all", "n", leader .. "mn")
    keybinds.unmap("all", "n", leader .. "mh")
    keybinds.unmap("all", "n", "gO")

    keybinds.remap_event("norg", "n", "<C-Space>", "core.norg.qol.todo_items.todo.task_done")
    keybinds.remap_event("norg", "n", "<C-S-Space>", "core.norg.qol.todo_items.todo.task_undone")
  end
}

return keybindings
