vim.g.mapleader = " "

local is_mac = vim.fn.has("macunix") == 1
local is_linux = vim.fn.has("unix") == 1 and not is_mac

vim.opt.ruler = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.complete = { "t", ".", "w", "b", "u" }
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.splitright = true
vim.opt.splitbelow = true

-- timeout to try to fix mac
vim.opt.timeout = true
vim.opt.timeoutlen = 500 -- ms for key mappings
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 20 -- ms for key codes like Escape

-- Statusline
vim.opt.laststatus = 2
vim.opt.statusline = table.concat({
	"%-10.3n ", -- buffer number
	"%f", -- relative filename
	"%h%m%r%w", -- flags: help, modified, readonly, preview
	"[%{strlen(&ft)?&ft:'none'}]", -- filetype
	"%=", -- switch to right-aligned
	"%-14(%l,%c%V%)", -- line, column, virtual column
	"%-10L", -- total lines
	"%p%%", -- percentage through file
})

-- Python makeprg (ruff)
local python_make = vim.api.nvim_create_augroup("python_make", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = python_make,
	pattern = "python",
	callback = function()
		vim.opt_local.makeprg = "uvx ruff check --output-format=concise"
		vim.opt_local.errorformat = "%f:%l:%c: %m"
		vim.keymap.set("n", ";m", ":make<CR><CR><CR> :cope <CR>", { buffer = true })
	end,
})

-- Keymaps  (from binds.vim)
local map = vim.keymap.set

-- visual move lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- netrw explore variants
map("n", "<leader>se", ":Sexplore<CR>", { desc = "Split explore" })
map("n", "<leader>ve", ":Vexplore!<CR>", { desc = "Vertical explore" })
map("n", "<leader>te", ":Texplore<CR>", { desc = "Tab explore" })

-- copy/paste via system clipboard tools
if is_mac then
	map("v", "<leader>y", ":w !pbcopy <CR> <CR> `<", { desc = "Copy selection (pbcopy)" })
	map("n", "<leader>p", 'i<C-r>=trim(system("pbpaste"))<CR><Esc>', { desc = "Paste (pbpaste)" })
elseif is_linux then
	map("v", "<leader>y", ":w !wl-copy <CR> <CR> `<", { desc = "Copy selection (wl-copy)" })
	map("n", "<leader>p", 'i<C-r>=trim(system("wl-paste"))<CR><Esc>', { desc = "Paste (wl-paste)" })
end

-- quickfix navigation
map("n", "<Right>", ":cnext<CR>zz", { desc = "Next quickfix" })
map("n", "<Left>", ":cprev<CR>zz", { desc = "Prev quickfix" })

-- arg list navigation
map("n", "<Up>", ":prev<CR>", { desc = "Prev arg" })
map("n", "<Down>", ":next<CR>", { desc = "Next arg" })

-- ctrl-b to make current file
map("n", "<C-b>", ":make! %<CR><CR> :cope<CR>", { desc = "Make current file" })

-- split navigation
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")

-- shortcut to save
map("n", ";w", ":update<CR>", { desc = "Save if modified" })

-- diff
map("n", "<leader>dt", ":windo diffthis<CR>", { desc = "Diff this (all windows)" })
map("n", "<leader>do", ":windo diffoff<CR>", { desc = "Diff off (all windows)" })

-- split line with K (opposite of J)
map("n", "K", "i<CR><Esc>", { desc = "Split line at cursor" })

-- toggles
map("n", "<leader>3", ":set relativenumber!<CR>", { desc = "Toggle relative number" })
map("n", "<leader>h", ":set hlsearch!<CR>", { desc = "Toggle hlsearch" })
map("n", "<leader>w", ":set wrap!<CR>", { desc = "Toggle wrap" })

-- bring search results to midscreen
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- move through tabs
map("n", "<S-Tab>", "gt")

-- surround (quick wrap of visual selection in punctuation pairs)
local surround_pairs = {
	["'"] = { "'", "'" },
	['"'] = { '"', '"' },
	["("] = { "(", ")" },
	[")"] = { "(", ")" },
	["{"] = { "{", "}" },
	["}"] = { "{", "}" },
	["["] = { "[", "]" },
	["]"] = { "[", "]" },
}
for key, pair in pairs(surround_pairs) do
	local open, close = pair[1], pair[2]
	local rhs = "`>a" .. close .. "<Esc>`<i" .. open .. "<Esc>"
	map("n", "<leader>s" .. key, rhs)
	map("v", "<leader>s" .. key, rhs)
end

-- alternate file
map("n", "<leader>a", ":e #<CR>", { desc = "Alternate file" })

-- set pwd variants
map("n", "<leader>ch", ":cd %:h<CR>", { desc = "cd to file dir" })
map("n", "<leader>th", ":tcd %:h<CR>", { desc = "tcd to file dir" })
map("n", "<leader>lh", ":lcd %:h<CR>", { desc = "lcd to file dir" })

-- Comment toggle (from vimrc_mac)
local function toggle_comment(char)
	local line = vim.fn.getline(".")
	local escaped = vim.fn.escape(char, "\\/")
	if line:match("^%s*" .. vim.pesc(char)) then
		local new_line = vim.fn.substitute(line, [[^\(\s*\)\(]] .. escaped .. [[\+\)\(.\+\)$]], [[\1\3]], "")
		vim.fn.setline(vim.fn.line("."), new_line)
	else
		vim.fn.setline(vim.fn.line("."), char .. line)
	end
end

local comment_group = vim.api.nvim_create_augroup("CommentKeymaps", { clear = true })

local comment_chars = {
	python = "#",
	vim = '"',
	c = "//",
	cpp = "//",
    lua = "--",
}

for ft, char in pairs(comment_chars) do
	vim.api.nvim_create_autocmd("FileType", {
		group = comment_group,
		pattern = ft,
		callback = function()
			map("n", "<leader>/", function()
				toggle_comment(char)
			end, { buffer = true })
			map("v", "<leader>/", function()
				toggle_comment(char)
			end, { buffer = true })
		end,
	})
end

-- Plugins
vim.pack.add({
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/neovim/nvim-lspconfig",
})

require("gruvbox").setup()
vim.cmd.colorscheme("gruvbox")

-- telescope
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = require('telescope.actions').move_selection_next,
                ['<C-k>'] = require('telescope.actions').move_selection_previous,
            }
        }
    }
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-F>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- treesitter
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(args)
        if args.data.spec.name == "nvim-treesitter.nvim" or args.data.spec.name == "nvim-treesitter" then
            vim.cmd("TSUpdate")
        end
    end,
})
local ts = require("nvim-treesitter")
ts.install({ 'python', 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'bash' })
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'python', 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'bash' },
    callback = function()
        vim.treesitter.start() --highlighting
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" --indentation
    end,
})

-- lsp
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.lsp.enable({ 'pyright', "clangd" })
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf }
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true})
            vim.keymap.set('i', '<C-n>', vim.lsp.completion.get, { buffer = args.buf, desc = 'Trigger completion' })
        end
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
})

