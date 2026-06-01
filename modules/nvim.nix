{ pkgs, lib }:

pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
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
        oil-nvim
        smear-cursor-nvim
        neoscroll-nvim
	];

    luaRcContent = ''
        ${builtins.readFile ../config/nvim/plugins/tokyodark.lua}
        ${builtins.readFile ../config/nvim/keymap.lua}
        ${builtins.readFile ../config/nvim/options.lua}
        ${builtins.readFile ../config/nvim/lsp.lua}

        ${builtins.readFile ../config/nvim/plugins/colorizer.lua}
        ${builtins.readFile ../config/nvim/plugins/gitsigns.lua}
        ${builtins.readFile ../config/nvim/plugins/ibl.lua}
        ${builtins.readFile ../config/nvim/plugins/lualine.lua}
        ${builtins.readFile ../config/nvim/plugins/neoscroll.lua}
        ${builtins.readFile ../config/nvim/plugins/noice.lua}
        ${builtins.readFile ../config/nvim/plugins/notify.lua}
        ${builtins.readFile ../config/nvim/plugins/nvim-autopairs.lua}
        ${builtins.readFile ../config/nvim/plugins/nvim-cmp.lua}
        ${builtins.readFile ../config/nvim/plugins/oil.lua}
        ${builtins.readFile ../config/nvim/plugins/smear_cursor.lua}
        ${builtins.readFile ../config/nvim/plugins/treesitter.lua}
    '';
    withRuby = false;
    withPython3 = false;

    wrapperArgs = with pkgs; [
        "--suffix" "PATH" ":"
        "${pkgs.lib.makeBinPath [
            ripgrep
            fd
            lua-language-server
            nil
            gcc
            sqlite
            yaml-language-server
            clang-tools
        ]}"
    ];
}
