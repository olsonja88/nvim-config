-- Go: gopls (formatting disabled — handled by conform/gofumpt)
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  root_dir = vim.fs.root(0, { 'go.mod', '.git' }),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        inaccessible = true,
      },
      staticcheck = true,
    },
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

-- TypeScript: ts_ls (formatting disabled — handled by conform/prettier)
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  root_dir = vim.fs.root(0, { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }),
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    vim.bo[bufnr].shiftwidth = 2
    vim.bo[bufnr].tabstop = 2
    vim.bo[bufnr].softtabstop = 2
    vim.bo[bufnr].expandtab = true
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Python: basedpyright (matches project's pyproject.toml typeCheckingMode = "basic")
vim.lsp.config('basedpyright', {
  cmd = { 'basedpyright-langserver', '--stdio' },
  root_dir = vim.fs.root(0, { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' }),
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
})

-- ESLint: eslint (TypeScript/JavaScript linting diagnostics)
vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  root_dir = vim.fs.root(0, { 'eslint.config.mjs', 'eslint.config.js', '.eslintrc.js', '.eslintrc.json', 'package.json', '.git' }),
  settings = {
    eslint = {
      enable = true,
    },
  },
})

-- JSON: jsonls
vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  root_dir = vim.fs.root(0, { 'package.json', '.git' }),
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

-- YAML: yamlls
vim.lsp.config('yamlls', {
  cmd = { 'yaml-language-server', '--stdio' },
  root_dir = vim.fs.root(0, { '.git' }),
  settings = {
    yaml = {
      schemas = require('schemastore').yaml.schemas(),
      validate = true,
    },
  },
})

-- Enable all configured LSP servers
vim.lsp.enable({ 'gopls', 'ts_ls', 'basedpyright', 'eslint', 'jsonls', 'yamlls' })

-- HTML: 4-space indentation
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})
