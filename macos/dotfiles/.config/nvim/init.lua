-- Section: General

-- Enable line numbers
vim.opt.number = true

-- Set leader key to Space
vim.g.mapleader = ' '

-- Save undo history
vim.opt.undofile = true
vim.g.netrw_list_hide='.*\\.un\\~$\\|.*\\.swp$'

-- Set up indicator for 132 columns
vim.opt.colorcolumn = '133'

-- Copy to system clipboard when yanking
vim.opt.clipboard:append('unnamed')

-- Always show trailing spaces; <Leader>i also shows tabs and line ends
local listchars_trailing = 'tab:  ,trail:-'
local listchars_all = 'tab:▸ ,trail:-,eol:¬'
vim.opt.list = true
vim.opt.listchars = listchars_trailing
vim.keymap.set('n', '<Leader>i', function()
    vim.wo.listchars = vim.wo.listchars == listchars_all and listchars_trailing or listchars_all
end, { desc = 'Toggle tabs and line ends' })

-- Section: Keys

-- Mappings to open config files
vim.api.nvim_set_keymap('n', '<Leader>ve', ':tabnew $MYVIMRC<CR>', { silent = true, desc = 'Edit init.lua' })
vim.api.nvim_set_keymap('n', '<Leader>vt', ':tabnew ~/.tmux.conf<CR>', { silent = true, desc = 'Edit .tmux.conf' })
vim.api.nvim_set_keymap('n', '<Leader>vz', ':tabnew ~/.zshrc<CR>', { silent = true, desc = 'Edit .zshrc' })
vim.api.nvim_set_keymap('n', '<Leader>vg', ':tabnew ~/.gitconfig<CR>', { silent = true, desc = 'Edit .gitconfig' })

vim.api.nvim_set_keymap('n', '<Leader>vs', ':source $MYVIMRC<CR>', { silent = true, desc = 'Reload init.lua' })

-- Mapping for opening splits and moving into it
vim.api.nvim_set_keymap('n', '<Leader>sv', '<C-w>v<C-w>l', { silent = true, desc = 'Split side by side' })
vim.api.nvim_set_keymap('n', '<Leader>ss', '<C-w>s<C-w>j', { silent = true, desc = 'Split top and bottom' })

-- Mappings for moving around panes
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, desc = 'Go to the pane left' })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, desc = 'Go to the pane below' })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, desc = 'Go to the pane above' })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, desc = 'Go to the pane right' })
-- Mappings for movement in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Esc><C-w>h', { noremap = true, desc = 'Go to the pane left' })
vim.api.nvim_set_keymap('i', '<C-j>', '<Esc><C-w>j', { noremap = true, desc = 'Go to the pane below' })
vim.api.nvim_set_keymap('i', '<C-k>', '<Esc><C-w>k', { noremap = true, desc = 'Go to the pane above' })
vim.api.nvim_set_keymap('i', '<C-l>', '<Esc><C-w>l', { noremap = true, desc = 'Go to the pane right' })

-- Mappings for moving lines up and down (keeps indentation)
vim.keymap.set('n', '<Leader>j', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<Leader>k', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<Leader>j', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', silent = true })
vim.keymap.set('v', '<Leader>k', ":m '<-2<CR>gv=gv", { desc = 'Move selection up', silent = true })

-- Section: Functions

-- Strip trailing whitespaces
function StripTrailingWhitespaces()
    local _s = vim.fn.getreg('/')
    local l = vim.fn.line(".")
    local c = vim.fn.col(".")
    vim.cmd('%s/\\s\\+$//e')
    vim.fn.setreg('/', _s)
    vim.api.nvim_win_set_cursor(0, {l, c})
end
vim.api.nvim_set_keymap('n', '<Leader>w', ':lua StripTrailingWhitespaces()<CR>', { silent = true, desc = 'Strip trailing whitespace' })

require("_lazy")
