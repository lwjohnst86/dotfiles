return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
        },
        pyright = {
          mason = false,
        },
      },
    },
  },
}
