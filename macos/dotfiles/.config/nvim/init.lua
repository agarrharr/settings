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

-- Toggle invisible characters
vim.api.nvim_set_keymap('n', '<Leader>i', ':set list<CR>:set listchars=tab:▸\\ ,eol:¬<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>io', ':set list<CR>:set listchars=tab:\\ \\ ,trail:-<CR>', { noremap = true })

-- Section: Keys

-- Mappings to open config files
vim.api.nvim_set_keymap('n', '<Leader>ev', ':tabnew $MYVIMRC<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>et', ':tabnew ~/.tmux.conf<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ez', ':tabnew ~/.zshrc<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>eg', ':tabnew ~/.gitconfig<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<Leader>vs', ':source $MYVIMRC<CR>', { silent = true })

-- Mapping for opening splits and moving into it
vim.api.nvim_set_keymap('n', '<Leader>sv', '<C-w>v<C-w>l', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ss', '<C-w>s<C-w>j', { silent = true })

-- Mappings for moving around panes
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })
-- Mappings for movement in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Esc><C-w>h', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Esc><C-w>j', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Esc><C-w>k', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Esc><C-w>l', { noremap = true })

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
vim.api.nvim_set_keymap('n', '<Leader>w', ':lua StripTrailingWhitespaces()<CR>', { silent = true })

require("_lazy")
