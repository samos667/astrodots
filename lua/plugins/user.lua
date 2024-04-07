---@type LazySpec
return {

  -- markdown preview
  {
    "0x00-ketsu/markdown-preview.nvim",
    ft = { "md", "markdown", "mkd", "mkdn", "mdwn", "mdown", "mdtxt", "mdtext", "rmd", "wiki" },
    config = function() require("markdown-preview").setup {} end,
  },
  -- clipboard manager
  {
    "gbprod/yanky.nvim",
    opts = function()
      local mapping = require "yanky.telescope.mapping"
      local mappings = mapping.get_defaults()
      mappings.i["<c-p>"] = nil
      return {
        highlight = { timer = 200 },
        picker = {
          telescope = {
            use_default_mappings = false,
            mappings = mappings,
          },
        },
      }
    end,
    keys = {
      {
        "y",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc = "Yank text",
      },
      {
        "p",
        "<Plug>(YankyPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after cursor",
      },
      {
        "P",
        "<Plug>(YankyPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before cursor",
      },
      {
        "gp",
        "<Plug>(YankyGPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after selection",
      },
      {
        "gP",
        "<Plug>(YankyGPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before selection",
      },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
    },
  },
  {
    "ibhagwan/smartyank.nvim",
    init = function()
      require("smartyank").setup {
        osc52 = {
          enabled = true,
          ssh_only = false, -- false to OSC52 yank also in local sessions
          silent = false, -- true to disable the "n chars copied" echo
        },
        clipboard = {
          enabled = true,
        },
      }
    end,
  },
  -- Enhanced matchparen.vim plugin for Neovim to highlight the outer pair.
  {
    "utilyre/sentiment.nvim",
    version = "*",
    event = "VeryLazy", -- keep for lazy loading
    opts = {
      -- config
    },
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },
  -- joining blocks of code into oneline, or splitting one line into multiple lines.
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup { --[[ your config ]]
      }
    end,
  },
  -- The plugin offers the alibity to refactor code.
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  -- The plugin offers the abilibty to search and replace.
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },
  -- full signature help, docs and completion for the nvim lua API.
  { "folke/neodev.nvim", opts = {} },
  {
    "0x00-ketsu/autosave.nvim",
    -- lazy-loading on events
    event = { "InsertLeave", "TextChanged" },
    opts = function(_, opts)
      opts.prompt_style = "stdout" -- notify or stdout
    end,
  },
  -- automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
  { "RRethy/vim-illuminate", config = function() end },
  -- implementation/definition preview
  {
    "rmagatti/goto-preview",
    config = function() require("goto-preview").setup {} end,
  },
  -- Super fast git decorations implemented purely in Lua.
  {
    "lewis6991/gitsigns.nvim",
    event = { "CursorHold", "CursorHoldI" },
    init = function()
      require("gitsigns").setup {
        current_line_blame = true,
      }
    end,
  },
  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " ░▒▓███████▓▒░░▒▓███████▓▒░▒▓████████▓▒░ ",
        "░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ",
        "░▒▓█▓▒░      ░▒▓█▓▒░             ░▒▓█▓▒░ ",
        "░▒▓███████▓▒░░▒▓███████▓▒░      ░▒▓█▓▒░  ",
        "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░  ",
        "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░    ░▒▓█▓▒░   ",
        " ░▒▓██████▓▒░ ░▒▓██████▓▒░     ░▒▓█▓▒░   ",
      }
      return opts
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local utils = require "astronvim.utils"
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>", -- Ctrl + Space
          node_incremental = "<C-space>",
          scope_incremental = "<A-space>", -- Alt + Space
          node_decremental = "<bs>", -- Backspace
        },
      }
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, {
        -- neovim
        "vim",
        "lua",
        -- operation & cloud native
        "dockerfile",
        "hcl",
        "jsonnet",
        "regex",
        "terraform",
        "nix",
        "csv",
        -- other programming language
        "diff",
        "gitignore",
        "gitcommit",
        "latex",
        "sql",
        -- customized languages:
        "scheme",
      })

      -- add support for scheme
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.scheme = {
        install_info = {
          url = "https://github.com/6cdh/tree-sitter-scheme", -- local path or git repo
          files = { "src/parser.c" },
          -- optional entries:
          branch = "main", -- default branch in case of git repo if different from master
          generate_requires_npm = false, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
      }
      -- use scheme parser for filetypes: scm
      vim.treesitter.language.register("scheme", "scm")
    end,
  },

  -- Undo tree
  { "debugloop/telescope-undo.nvim" },
  -- An advanced git search extension for Telescope
  {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- optional: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      "sindrets/diffview.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      -- 1. Disable highlighting for certain filetypes
      -- 2. Ignore files larger than a certain filesize
      local previewers = require "telescope.previewers"

      local _bad = { ".*%.csv", ".*%.min.js" } -- Put all filetypes that slow you down in this array
      local filesize_threshold = 300 * 1024 -- 300KB
      local bad_files = function(filepath)
        for _, v in ipairs(_bad) do
          if filepath:match(v) then return false end
        end
        return true
      end

      local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}
        if opts.use_ft_detect == nil then opts.use_ft_detect = true end

        -- 1. Check if the file is in the bad_files array, and if so, don't highlight it
        opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)

        -- 2. Check the file size, and ignore it if it's too big(preview nothing).
        filepath = vim.fn.expand(filepath)
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then return end
          if stat.size > filesize_threshold then
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      end

      require("telescope").setup {
        defaults = {
          buffer_previewer_maker = new_maker,
        },
        extensions = {
          advanced_git_search = {
            diff_plugin = "diffview",
          },
        },
      }
      require("telescope").load_extension "advanced_git_search"
    end,
  },
}
