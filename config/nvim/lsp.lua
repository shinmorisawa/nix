local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("clangd", {
    capabilities = capabilities
})

vim.lsp.enable("clangd")
