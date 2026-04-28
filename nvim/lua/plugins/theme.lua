return { -- Using lazy.nvim
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "latte",
      transparent_background = true,
      custom_highlights = function()
        return {
          Normal = { fg = "#000000", bg = "NONE" },
          NormalNC = { fg = "#000000", bg = "NONE" },
          NormalFloat = { fg = "#000000", bg = "NONE" },
          SignColumn = { bg = "NONE" },
          EndOfBuffer = { bg = "NONE" },
        }
      end,
      integrations = {
        bufferline = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
  specs = {
    {
      "akinsho/bufferline.nvim",
      optional = true,
      opts = function(_, opts)
        if (vim.g.colors_name or ""):find("catppuccin") then
          opts.highlights = require("catppuccin.special.bufferline").get_theme()
        end
      end,
    },
  },
}
