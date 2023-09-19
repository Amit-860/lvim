local M = {}
local components = require "lvim.core.lualine.components"

local styles = {
    lvim = nil,
    default = nil,
    none = nil,
}

styles.none = {
    style = "none",
    options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = lvim.use_icons,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
}

styles.default = {
    style = "default",
    options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = lvim.use_icons,
        component_separators = {
            left = lvim.icons.ui.DividerRight,
            right = lvim.icons.ui.DividerLeft,
        },
        section_separators = {
            left = lvim.icons.ui.BoldDividerRight,
            right = lvim.icons.ui.BoldDividerLeft,
        },
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
}

local lualine = require 'lualine'
local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

-- NOTE: auto_commmads
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        lualine.refresh({
            place = { "statusline" },
        })
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
            50,
            0,
            vim.schedule_wrap(function()
                lualine.refresh({
                    place = { "statusline" },
                })
            end)
        )
    end,
})

styles.lvim = {
    style = "lvim",
    options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = lvim.use_icons,
        component_separators = { left = "│", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
    },
    sections = {
        lualine_a = {
            -- components.mode,
            { "mode" },
            {
                "macro-recording",
                fmt = show_macro_recording,
            },
        },
        lualine_b = {
            components.branch,
        },
        lualine_c = {
            components.diff,
            components.python_env,
            components.diagnostics,
        },
        lualine_x = {
            components.lsp,
            components.spaces,
            components.filetype,
        },
        lualine_y = { components.location },
        lualine_z = {
            components.progress,
        },
    },
    inactive_sections = {
        lualine_a = {
            components.mode,
        },
        lualine_b = {
            components.branch,
        },
        lualine_c = {
            components.diff,
            components.python_env,
        },
        lualine_x = {
            components.diagnostics,
            components.lsp,
            components.spaces,
            components.filetype,
        },
        lualine_y = { components.location },
        lualine_z = {
            components.progress,
        },
    },
    tabline = {},
    extensions = {},
}

function M.get_style(style)
    local style_keys = vim.tbl_keys(styles)
    if not vim.tbl_contains(style_keys, style) then
        local Log = require "lvim.core.log"
        Log:error(
            "Invalid lualine style"
            .. string.format('"%s"', style)
            .. "options are: "
            .. string.format('"%s"', table.concat(style_keys, '", "'))
        )
        Log:debug '"lvim" style is applied.'
        style = "lvim"
    end

    return vim.deepcopy(styles[style])
end

function M.update()
    local style = M.get_style(lvim.builtin.lualine.style)

    lvim.builtin.lualine = vim.tbl_deep_extend("keep", lvim.builtin.lualine, style)

    local color_template = vim.g.colors_name or lvim.colorscheme
    local theme_supported, template = pcall(function()
        require("lualine.utils.loader").load_theme(color_template)
    end)
    if theme_supported and template then
        lvim.builtin.lualine.options.theme = color_template
    end
end

return M
