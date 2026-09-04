return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["tex"] = { "latexindent" },
        -- "pylsp" is not a conform formatter, so conform found nothing and fell
        -- back to LSP formatting (LazyVim sets lsp_format = "fallback"), which
        -- ran pylsp's autopep8 -- hardcoded PEP-8 4-space indent. ruff_format
        -- reads pyproject.toml, so this matches `uv run ruff format`.
        ["python"] = { "pylsp" },
      },
      formatters = {
        ["prettier"] = {
          -- Optional: Add extra arguments or plugins here
          -- prepend_args = { "--number" },
          prepend_args = { "--prose-wrap", "always" },
        },
        ["latexindent"] = {
          prepend_args = {
            "-m", -- Enables line break modification routines
            "-y=modifyLineBreaks:textWrapOptions:columns:80",
          },
        },
      },
    },
  },
}
