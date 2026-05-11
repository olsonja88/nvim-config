-- Keymap helper function
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- General Keybindings
vim.g.mapleader = ","
keymap("n", "<C-h>", "<C-w>h", opts) -- Navigate to left window
keymap("n", "<C-j>", "<C-w>j", opts) -- Navigate to bottom window
keymap("n", "<C-k>", "<C-w>k", opts) -- Navigate to top window
keymap("n", "<C-l>", "<C-w>l", opts) -- Navigate to right window
keymap("v", "<C-y>", '"+y', opts) -- Visual mode: Copy to system clipboard
keymap("n", "<C-y>", '"+yy', opts) -- Normal mode: Copy current line to clipboard
vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true }) -- Split window vertically
vim.keymap.set('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true }) -- Split window horizontally

-- Build Functions
local function capitalize_first_letter(str)
  return str:sub(1, 1):upper() .. str:sub(2)
end

local function build_service(service)
  local title = capitalize_first_letter(service)
  vim.notify('Build in process...', vim.log.levels.INFO, {
    title = title,
  })

  local errs = {}
  local command = string.format('make %s && make dev-load && kubectl -n inkit rollout restart deploy -lapp=%s', service, service)
  vim.fn.jobstart(command, {
    on_stderr = function(_, data, _)
      if data then
        for _, line in ipairs(data) do
          if line ~= '' then
            table.insert(errs, line)
          end
        end
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify('Build succeeded!', vim.log.levels.INFO, { title = title })
      else
        local err_message = table.concat(errs, '\n')
        vim.notify('Build failed!\n' .. err_message, vim.log.levels.ERROR, { title = title, timeout = 0 })
      end
    end,
    detach = true,
  })
end

-- Build Keybindings
vim.keymap.set('n', '<leader>bA', function()
  build_service 'accounts'
end, { desc = 'Build Accounts' })
vim.keymap.set('n', '<leader>ba', function()
  build_service 'auth'
end, { desc = 'Build Auth' })
vim.keymap.set('n', '<leader>bp', function()
  build_service 'proxy'
end, { desc = 'Build Proxy' })
vim.keymap.set('n', '<leader>bE', function()
  build_service 'events-worker'
end, { desc = 'Build Events Worker' })