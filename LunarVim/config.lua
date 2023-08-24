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
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "document_symbols",
        },
        close_if_last_window = true,
        window = {
          width = 30,
        },
        buffers = {
          follow_current_file = {
            enabled = false
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = false
          },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
          },
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(file_path)
              -- auto close
              require("neo-tree.command").execute({ action = "close" })
            end
          },
        },
      })
    end
  },
}

-- LunarVim specific configurations
if vim.fn.hostname() == "Mac.local" then
  lvim.colorscheme = "catppuccin-latte"
else
  lvim.colorscheme = "catppuccin-frappe"
end
lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree
lvim.builtin.lir.active = false -- NOTE: using neo-tree

-- Key mappings
lvim.builtin.which_key.mappings["r"] = {
    "<cmd>RnvimrToggle<CR>", "Ranger"
}
lvim.builtin.which_key.mappings["n"] = {
  "<cmd>Neotree toggle<CR>", "NeoTree filesystem toggle"
}
lvim.builtin.which_key.mappings["|"] = {
  "<cmd>Neotree reveal<CR>", "NeoTree reveal"
}
lvim.builtin.which_key.mappings["B"] = {
  "<cmd>Neotree buffers toggle right<CR>", "NeoTree Buffers"
}


-- Neovide specific configuration
if vim.g.neovide then
  vim.opt.guifont = "MonoLisa Nerd Font:h12"
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_cursor_animation_length = 0.01
end
