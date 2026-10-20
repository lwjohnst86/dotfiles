-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.lsp.enable("panache")
vim.lsp.enable("jarl")

-- For R LSP:
vim.lsp.config["r_language_server"] = {
  settings = {
    filetypes = { "r", "rmd" },
  },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "r", "rmd" },
  callback = function()
    vim.lsp.start(vim.lsp.config["r_language_server"])
  end,
})
vim.lsp.enable("r_language_server")

-- This is for Air formatter, from their website
vim.lsp.config["air"] = {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
-- Ensure that only Air is used
vim.lsp.config["r_language_server"] = {
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
vim.lsp.enable("air")
