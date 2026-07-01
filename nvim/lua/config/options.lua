-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars:append({ space = "∙" }) -- Render spaces as a larger dot-like glyph

local function set_custom_hl()
  vim.api.nvim_set_hl(0, "Whitespace", { fg = "#acb0be", ctermfg = 245 })
  vim.api.nvim_set_hl(0, "CursorInsert", { fg = "#ffffff", bg = "#0000ff", bold = true })
end

set_custom_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_custom_hl,
})

-- Enable transparent background
vim.o.termguicolors = true
vim.cmd([[highlight Normal ctermbg=NONE guibg=NONE]])
vim.cmd([[highlight NormalNC ctermbg=NONE guibg=NONE]])
vim.cmd([[highlight NonText ctermbg=NONE guibg=NONE]])

local zsh = vim.fn.exepath("zsh")
if zsh ~= "" then
  vim.opt.shell = zsh
end

-- Highly visible cursor: Solid block everywhere, fast blinking and bright green in insert mode
vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:block-CursorInsert-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20-Cursor"

