local wk = require("which-key")
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- Telescope
wk.add({
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search by content" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "List open buffers" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help tags" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Search recent files" },
  { "<leader>ft", "<cmd>Telescope tags<cr>", desc = "Search tags" },
  { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Search commands" },
  { "<leader>fgf", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
  { "<leader>fgb", "<cmd>Telescope git_branches<cr>", desc = "Find git branches" },
  { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Open diagnostics"},
})

-- Harpoon
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
    }):find()
end
wk.add({
  { "<leader>a", function() harpoon:list():add() end, desc = "Mark current file" },
  { "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Open Harpoon menu" },
  { "<leader>h", function() harpoon:list():select(1) end, desc = "Go to marked file 1" },
  { "<leader>2", function() harpoon:list():select(2) end, desc = "Go to marked file 2" },
  { "<leader>n", function() harpoon:list():select(3) end, desc = "Go to marked file 3" },
  { "<leader>4", function() harpoon:list():select(4) end, desc = "Go to marked file 4" },
  { "<C-S-P>", function() harpoon:list():prev() end, desc = "Go to previous marked file" },
  { "<C-S-N>", function() harpoon:list():next() end, desc = "Go to next marked file" },
  { "<leader>E", function() toggle_telescope(harpoon:list()) end, desc = "Open Harpoon window in Telescope" },
})

-- LSP
wk.add({
  { "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to definition" },
  { "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "Go to references" },
  { "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Go to implementation" },
  { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename symbol" },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code actions" },
  { "<leader>cf", function() require("conform").format({ timeout_ms = 500, lsp_format = "never" }) end, desc = "Format document" },
  { "<leader>dv", "<cmd>lua vim.diagnostic.open_float()<cr>", desc="Diagnose at cursor"}
})

-- dap
wk.add({
  { "<F5>", "<cmd>lua require'dap'.continue()<cr>", desc = "Debug continue" },
  { "<F10>", "<cmd>lua require'dap'.step_over()<cr>", desc = "Debug step over" },
  { "<F11>", "<cmd>lua require'dap'.step_into()<cr>", desc = "Debug step into" },
  { "<F12>", "<cmd>lua require'dap'.step_out()<cr>", desc = "Debug step out" },
  { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
  { "<leader>dl", "<cmd>lua require'dap'.repl.open()<cr>", desc = "Open debug REPL" },
})

-- render-markdown
wk.add({
  { "<leader>m", group = "Markdown" },
  { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown rendering"},
  { "<leader>me", "<cmd>RenderMarkdown enable<cr>",  desc = "Enable markdown rendering"},
  { "<leader>md", "<cmd>RenderMarkdown disable<cr>", desc = "Disable markdown rendering"},
})

--nvimtree
wk.add({
	{ "<leader>ot", "<cmd>NvimTreeToggle<cr>", desc = "Open nvim tree" },
})
wk.add({
	{ "<leader>tff", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in nvim tree"},
})
wk.add({
	{ "<leader>tc", "<cmd>NvimTreeCollapse<cr>", desc = "Collapse nvim tree"},
})
