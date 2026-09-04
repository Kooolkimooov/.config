return {
  {
    -- pylsp is started by mason-lspconfig's `automatic_enable` via
    -- `vim.lsp.enable`, so settings must be registered with `vim.lsp.config`.
    -- The deprecated `require("lspconfig").pylsp.setup{}` framework cannot
    -- reach that client.
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                -- 2-space indent projects: E111/E114 are pure noise.
                pycodestyle = { ignore = { "E111", "E114", "E121", "E501" } },
              },
            },
          },
        },
      },
    },
  },
}
