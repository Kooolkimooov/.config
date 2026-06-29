return {
  "folke/snacks.nvim",
  opts = {
    image = {
      format = { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "pdf" },
      doc = { enabled = true, inline = true, float = false },
      math = {enabled = false},
    },
    picker = {
      hidden = true,
      ignored = true,
      sources = {
        files = {
          hidden = true,
        },
        explorer = {
          hidden = true,
          layout = {
            layout = {
              position = "right",
            },
          },
        },
        grep = {
          hidden = true,
        },
      },
    },
  },
}
