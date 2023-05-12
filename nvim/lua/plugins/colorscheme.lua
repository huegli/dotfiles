return {
  -- add catppuccin
  {
    lazy = true,
    name = "catppuccin",
  },

  -- Configure LazyVim to load catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
