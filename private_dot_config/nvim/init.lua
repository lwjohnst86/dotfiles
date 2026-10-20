-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.lsp.enable("panache")
vim.lsp.enable("jarl")

-- For R LSP:
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
vim.lsp.enable("air")
