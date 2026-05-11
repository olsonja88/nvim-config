-- Load Base Mappings
require("config.mappings")

-- For finding GitLab LSP
vim.env.PATH = "/opt:" .. vim.env.PATH

-- Load Plugins
require("config.lazy")

--- Load Plugin Mappings
require("config.plugin-mappings")

-- Load LSPs
require("config.lspconfig")

-- General config
vim.o.number = true
vim.o.relativenumber = true

-- Setting default theme
vim.cmd("colorscheme terafox")
