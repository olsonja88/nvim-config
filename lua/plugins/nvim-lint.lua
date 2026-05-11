return {
  "mfussenegger/nvim-lint",
  keys = {
    { "<leader>l", function() require("lint").try_lint() end, desc = "Lint current file" },
  },
  config = function()
    require("lint").linters_by_ft = {
      go = { "golangcilint" },
      python = { "ruff" },
      rego = { "regal" },
      sql = { "sqlfluff" },
    }
  end,
}
