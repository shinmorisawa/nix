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
        ${builtins.readFile ../config/nvim/keymap.lua}
        ${builtins.readFile ../config/nvim/lsp.lua}
        ${builtins.readFile ../config/nvim/options.lua}
        ${builtins.readFile ../config/nvim/plugins.lua}
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
