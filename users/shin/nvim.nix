{ config, pkgs, ... }:

let
tokyodark-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "tokyodark-nvim";
    src = pkgs.fetchFromGitHub {
        owner = "tiagovla";
        repo = "tokyodark.nvim";
        rev = "master";
        sha256 = "sha256-THvvevUwK3p/aZW+FI2RNnduqWBcmWF5tueYwEY43FI=";
    };
};
in
{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        extraPackages = with pkgs; [
            ripgrep
            fd
            lua-language-server
            nil
            gcc
            sqlite
            yaml-language-server
        ];
        plugins = with pkgs.vimPlugins; [
            nvim-treesitter.withAllGrammars
            telescope-nvim
            tokyodark-nvim
            neogit
            plenary-nvim
            diffview-nvim
            lualine-nvim
            nvim-web-devicons
            gitsigns-nvim
            nvim-cmp
            cmp-buffer
            cmp-path
            cmp-nvim-lsp
            cmp_luasnip
            lspkind-nvim
            friendly-snippets
            nvim-autopairs
            nvim-colorizer-lua
            nvim-lspconfig
            indent-blankline-nvim
            noice-nvim
            nui-nvim
            nvim-notify
        ];
        extraLuaConfig = ''
        require("tokyodark").setup({
            transparent_background = true,
            custom_highlights = function(highlights, palette) 
                return {
                    iblNormal = { fg = palette.bg1 },
                    iblScope = { fg = palette.blue }
                }
            end,
        })
        vim.cmd.colorscheme("tokyodark")

        vim.opt.clipboard = 'unnamedplus'

        vim.opt.termguicolors = true

        vim.o.guicursor = "n-v-c:underline,i-ci-ve:ver25,r-cr-o:hor20"
        vim.o.guifont = "JetBrainsMono Nerd Font:h11"

        vim.opt.nu = true
        vim.opt.relativenumber = true

        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.autoindent = true
        vim.opt.cindent = true

        vim.opt.wrap = false

        vim.opt.incsearch = true

        vim.g.mapleader = " "

        local telescope = require("telescope.builtin")
        local neogit = require("neogit")

        vim.keymap.set("n", "<leader>f", telescope.find_files, { noremap=true, silent=true, buffer=bufnr })
        vim.keymap.set("n", "<leader>p", "\"_dP", { noremap=true, silent=true, buffer=bufnr })
        vim.keymap.set("n", "<leader>q", vim.cmd.qa, { noremap=true, silent=true, buffer=bufnr })
        vim.keymap.set("n", "<leader>gc", function() neogit.open({ "commit" }) end, { noremap=true, silent=true, buffer=bufnr })
        vim.keymap.set("n", "<leader>ga", function() neogit.open({ "stash" }) end, { noremap=true, silent=true, buffer=bufnr })
        vim.keymap.set("n", "<leader>gf", function() neogit.open({ "fetch" }) end, { noremap=true, silent=true, buffer=bufnr })
        vim.keymap.set("n", "<leader>gd", function() neogit.open({ "diff" }) end, { noremap=true, silent=true, buffer=bufnr })

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'tokyodark',
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
                lualine_w = {'lsp_status'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
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

        vim.cmd([[
            set completeopt=menuone,noinsert,noselect
            highlight! default link CmpItemKind CmpItemMenuDefault
        ]])

        require("nvim-autopairs").setup({
            disable_filetype = { "TelescopePrompt", "vim" },
        })

        require("colorizer").setup({ "*" })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.lsp.config("clangd", {
            capabilities = capabilities
        })
        
        vim.lsp.enable("clangd")

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
        '';
    };
}
