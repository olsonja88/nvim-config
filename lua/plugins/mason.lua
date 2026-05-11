return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",  -- Mason LSP config integration
    "neovim/nvim-lspconfig",              -- LSP support for Neovim
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = { "gopls", "ts_ls", "basedpyright", "jsonls", "yamlls", "eslint" },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Formatters
        "gofumpt",
        "goimports-reviser",
        "prettier",
        "ruff",
        -- Linters
        "golangci-lint",
        "regal",
        "sqlfluff",
      },
    })
  end,
}
