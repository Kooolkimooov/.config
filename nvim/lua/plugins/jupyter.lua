return {
  -- 1. Automatically convert .ipynb to markdown/python text on open
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      style = "hydrogen", -- Translates cells using "# %%" syntax
      force_ft = "python",
      output_extension = "py",
    },
  },

  -- 2. Inline Jupyter code execution engine
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- Use stable releases
    build = ":UpdateRemotePlugins", -- Ensures pynvim integration updates
    init = function()
      -- Change these mappings to your preference
      vim.g.molten_image_provider = "none" -- Set to "kitty" or "wezterm" if using terminal graphics
      vim.g.molten_output_win_max_height = 20

      -- Keymaps for code cell execution
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize Molten" })
      vim.keymap.set("n", "<leader>me", ":MoltenExecuteOperator<CR>", { silent = true, desc = "Run Operator" })
      vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Run Line" })
      vim.keymap.set("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>gvl", { silent = true, desc = "Run Visual Selection" })
      vim.keymap.set("n", "<leader>mr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Re-evaluate Cell" })
      vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { silent = true, desc = "Delete Cell Output" })
    end,
  },
}

