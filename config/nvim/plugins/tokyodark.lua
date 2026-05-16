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
