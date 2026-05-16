require("tokyodark").setup({
    transparent_background = true,
    custom_highlights = function(highlights, p) 
        return {
            iblNormal = { fg = p.bg1 },
            iblScope = { fg = p.blue },
            NotifyBackground = { bg = p.black },
            Normal = { fg = p.fg },
            NormalNC = { bg = p.black, fg = p.fg },
            NormalSB = { bg = p.black, fg = p.fg },
            NormalFloat = { bg = p.black, fg = p.fg },
            NormalTerminal = { fg = p.fg },
            Terminal = { fg = p.fg },
            EndOfBuffer = { bg = p.black, fg = p.fg },
        }
    end,
})

require("nvim-treesitter").setup()

local p = require("tokyodark.palette")
local colors = {
    bg = p.black,
    fg = p.fg,
    red = p.red,
    green = p.green,
    yellow = p.yellow,
    blue = p.blue,
    purple = p.purple,
    cyan = p.cyan,
    grey = p.grey,
}

local tokyo_dark = {
    inactive = {
        a = { fg = colors.grey, bg = colors.bg, gui = "bold" },
        b = { fg = colors.grey, bg = colors.bg },
        c = { fg = colors.grey, bg = colors.bg },
        x = { fg = colors.grey, bg = colors.bg },
        y = { fg = colors.grey, bg = colors.bg },
        z = { fg = colors.grey, bg = colors.bg },
    },
    normal = {
        a = { fg = colors.bg, bg = colors.green, gui = "bold" },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
        x = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.fg, bg = colors.bg },
        z = { fg = colors.bg, bg = colors.green, gui = "bold" },
    },
    visual = { a = { fg = colors.bg, bg = colors.purple, gui = "bold" } },
    replace = { a = { fg = colors.bg, bg = colors.red, gui = "bold" } },
    insert = { a = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
    command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = tokyo_dark,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1,
            tabline = 1,
            winbar = 1,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'lsp_status', 'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

require("gitsigns").setup {
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
}

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "vim" },
})

require("colorizer").setup({ "*" })

require("ibl").setup({
    indent = {
        highlight = "iblNormal"
    },

    scope = {
        enabled = true,
        highlight = "iblScope",
    },
})

require("noice").setup({
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },            
})

require("notify").setup({
    fps = 165,
})

require("oil").setup({
    default_file_explorer = true
})

require("smear_cursor").setup({
    opts = {
        smear_insert_mode = true,
        time_interval = 1,
        stiffness = 0.8,
        trailing_stiffness = 0.3,
        stiffness_insert_mode = 0.7,
        damping = 0.95
    },
})

require("neoscroll").setup({

})
