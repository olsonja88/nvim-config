return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        go = { "gofumpt", "goimports-reviser" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        python = { "ruff_fix", "ruff_format" },
        rego = { "opa_fmt" },
        sql = { "pg_format" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "never",
      },
    })
  end,
}
