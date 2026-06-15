return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
      },
      formatters = {
        ["prettier"] = {
          -- Optional: Add extra arguments or plugins here
          -- prepend_args = { "--number" },
          prepend_args = { "--prose-wrap", "always" },
        },
      },
    },
  },
}

