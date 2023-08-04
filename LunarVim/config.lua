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
  },
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  -- {
  --   "nacro90/numb.nvim",
  --   event = "BufRead",
  --   config = function()
  --   require("numb").setup {
  --     show_numbers = true, -- Enable 'number' for the window while peeking
  --     show_cursorline = true, -- Enable 'cursorline' for the window while peeking
  --     hide_relativenumbers = true,
  --   }
  --   end,
  -- },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
  "kevinhwang91/rnvimr",
    cmd = "RnvimrToggle",
    config = function()
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
      end,
  },
}

-- LunarVim specific configurations
lvim.colorscheme = "catppuccin-frappe"

-- Key mappings
lvim.builtin.which_key.mappings["r"] = {
  "<cmd>RnvimrToggle<CR>", "Ranger"
}

-- Neovide specific configuration
if vim.g.neovide then
  vim.opt.guifont = "MonoLisa Nerd Font:h12"
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_cursor_animation_length = 0.01
end
