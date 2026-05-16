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
        ${buildins.readFile ../config/nvim/plugins/tokyodark.lua}
        ${builtins.readFile ../config/nvim/keymap.lua}
        ${builtins.readFile ../config/nvim/options.lua}
        ${builtins.readFile ../config/nvim/lsp.lua}

        ${buildins.readFile ../config/nvim/plugins/colorizer.lua}
        ${buildins.readFile ../config/nvim/plugins/gitsigns.lua}
        ${buildins.readFile ../config/nvim/plugins/ibl.lua}
        ${buildins.readFile ../config/nvim/plugins/lualine.lua}
        ${buildins.readFile ../config/nvim/plugins/neoscroll.lua}
        ${buildins.readFile ../config/nvim/plugins/noice.lua}
        ${buildins.readFile ../config/nvim/plugins/notify.lua}
        ${buildins.readFile ../config/nvim/plugins/nvim-autopairs.lua}
        ${buildins.readFile ../config/nvim/plugins/nvim-cmp.lua}
        ${buildins.readFile ../config/nvim/plugins/oil.lua}
        ${buildins.readFile ../config/nvim/plugins/smear_cursor.lua}
        ${buildins.readFile ../config/nvim/plugins/treesitter.lua}
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
