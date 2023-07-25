-- General Vim / NeoVim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.relativenumber = true

-- use treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- LunarVim Plugin's
lvim.plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe",
    },
  },
  {
    "max397574/better-escape.nvim",
    config = true,
  }
}

-- LunarVim specific configurations
lvim.colorscheme = "catppuccin-frappe"
