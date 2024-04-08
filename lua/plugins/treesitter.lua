-- Customize Treesitter
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "nushell/tree-sitter-nu" },
  },
  build = ":TSUpdate",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
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
  end,
}
