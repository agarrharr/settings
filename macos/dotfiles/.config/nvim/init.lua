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

-- Section: Functions

-- Open file in Xcode after saving for Swift files
function OpenInXcode()
    -- Get the current file path
    local current_file = vim.fn.expand('%')

    -- Escape special characters in the file path
    local escaped_file = vim.fn.shellescape(current_file)

    -- Run the xed command
    vim.fn.system("xed -b " .. escaped_file)

    change_xcode_scheme()
end

-- Define the autocommand to call OpenInXcode after saving Swift files
vim.cmd[[
  autocmd BufWritePost *.swift lua OpenInXcode()
]]

-- Define the Lua function to execute the AppleScript
function change_xcode_scheme()
    -- Define the AppleScript code as a string
    local applescript_code = [[
	tell application "Xcode"
		-- Get the list of all open documents in Xcode
		set allDocuments to documents
		
		-- Get the path of the current document in Xcode
		set currentDocument to missing value
		-- Loop backwards over the list of docments (because the beginning of the list contains documents that aren't actually open)
		repeat with i from (count of allDocuments) to 1 by -1
			set aDocument to item i of allDocuments
			try
				-- Check to see if it has any selected characters, because if it does, that's the active one (unless you have multiple panes open)
				if selected character range of aDocument is not {} then
					set currentDocument to aDocument
					exit repeat
				end if
			end try
		end repeat
		if currentDocument is missing value then
			display dialog "No active document found." buttons {"OK"} default button "OK"
			return
		end if
		set currentDocumentPath to path of currentDocument
		
		-- Split the path into parts
		set AppleScript's text item delimiters to "/"
		set pathParts to text items of currentDocumentPath
		set AppleScript's text item delimiters to ""
		
		-- Get the list of all schemes in Xcode
		set allSchemes to {}
		tell workspace document 1
			repeat with i from 1 to count of schemes
				set schemeName to name of scheme i
				set end of allSchemes to schemeName
			end repeat
		end tell
		
		-- Iterate over each path part in reverse order (from file to root) to check if it matches any scheme
		set foundScheme to missing value
		repeat with i from (count of pathParts) to 1 by -1
			set currentPart to item i of pathParts
			
			-- Check if the current part matches any scheme
			if currentPart is in allSchemes then
				-- Save the scheme and exit the loop
				set foundScheme to currentPart
				exit repeat
			end if
		end repeat
		
		-- If a matching scheme was found, set the active scheme
		if foundScheme is not missing value then
			set workspaceDocument to missing value
			
			-- Iterate through the open documents to find the workspace document
			repeat with doc in allDocuments
				-- Check if the document represents a workspace
				if class of doc is workspace document then
					-- Check if the document name contains the workspace project name
					if name of doc contains "Countable" then
						-- Store the workspace document and its path
						set workspaceDocument to doc
						exit repeat
					end if
				end if
			end repeat
			
			-- Check if a workspace document was found
			if workspaceDocument is not missing value then
				-- Set the active scheme
				set activeSchemeName to foundScheme
				set activeScheme to scheme activeSchemeName of workspaceDocument
				set active scheme of workspaceDocument to activeScheme
			else
				display dialog "The workspace document was not found in Xcode." buttons {"OK"} default button 1
			end if
		else
			display dialog "No scheme found matching any ancestor directory of the active document." buttons {"OK"} default button 1
		end if
	end tell
	]]

    -- Execute the AppleScript code
    local command = "osascript -e " .. vim.fn.shellescape(applescript_code)
    vim.fn.system(command)
end

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
