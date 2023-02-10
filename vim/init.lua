-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.polyglot_disabled = {'markdown'}

require('lazy').setup('plugins')


-- [[ Setting options ]]
vim.o.autoread = true -- Reload files on change
vim.o.breakindent = true -- Enable break indent
vim.o.cpoptions = vim.o.cpoptions .. '$' -- Add $ on text change to reduce text shifting around
vim.o.mouse = 'a' -- Enable mouse mode
vim.wo.number = true -- Make line numbers default
vim.o.undofile = true -- Save undo history
vim.o.gdefault = true -- /g is active on :s
vim.o.hidden = true -- Hidden buffers
vim.o.lazyredraw = true -- Faster macros
vim.o.scrolloff = 1 -- Start scrolling before last line
vim.o.backup = false -- No backup, we use git
vim.o.swapfile = false -- No swap
vim.o.cursorline = true
vim.o.numberwidth = 3
vim.o.termguicolors = true
vim.o.splitright = true
vim.o.splitbelow = true

local no_comments_oO_group = vim.api.nvim_create_augroup('no_comments_oO', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.o.formatoptions = vim.o.formatoptions:gsub('o', '') -- Don't start newline with comment with oO
  end,
  group = no_comments_oO_group,
  pattern = '*',
})


-- Searching config
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.magic = true

-- Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.cmd [[colorscheme themer_jellybeans]]

-- Fast reaction time
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 100

-- System clipboard
vim.o.clipboard = 'unnamed,unnamedplus'

-- Edit this file
vim.keymap.set('n', '<leader>ev', ':edit $MYVIMRC <cr>', { silent = true })

-- Keymaps for better default experience
-- Disable space default behavior
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Toggle search
vim.keymap.set('n', '<leader><cr>', ':set hlsearch!<cr>', { silent = true })

-- Exit with jk
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'kj', '<ESC>')
vim.keymap.set('c', 'jk', '<cr>')
vim.keymap.set('c', 'kj', '<cr>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Quick save and quit
vim.keymap.set('n', '<leader>q', ':Sayonara!<cr>')
vim.keymap.set('n', '<leader>Q', ':qa!<cr>')
vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>c', ':close<cr>')

-- Close buffer
vim.keymap.set('n', '<leader>c', ':close<cr>')

-- Search with Ag
vim.keymap.set('n', '<leader>a', ':Ag!<space>')

-- Reselect after indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Select pasted text
vim.keymap.set('n', 'gV', '`[V+`]')

-- Make commandline look a little bit more like bash
vim.keymap.set('c', '<c-a>', '<home>')
vim.keymap.set('c', '<c-e>', '<end>')

-- Swap 0/^
vim.keymap.set('n', '0', '^')
vim.keymap.set('n', '^', '0')

-- Set filetype
vim.keymap.set('n', '<leader>ft', ':Telescope filetypes<cr>')

-- Buffer navigation
vim.keymap.set('n', '<leader>n', ':bn<cr>')
vim.keymap.set('n', '<leader>p', ':bp<cr>')

-- Fast switch
vim.g.switch_mapping = '-'

-- Keep position
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

-- Git
vim.keymap.set('n', '<leader>gB', ':Gitsigns toggle_current_line_blame<cr>')
vim.keymap.set('n', '<leader>gb', ':Git blame<cr>')

-- Align
vim.keymap.set('n', 'ga', '<Plug>(LiveEasyAlign)')
vim.keymap.set('x', 'ga', '<Plug>(LiveEasyAlign)')
vim.keymap.set('x', '<CR>', '<Plug>(LiveEasyAlign)')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- require("scrollbar").setup()

local navic = require("nvim-navic")
-- Set lualine as statusline
-- See `:help lualine.txt`
require("lualine").setup({
  sections = {
    lualine_c = {
      'filename',
      { navic.get_location, cond = navic.is_available },
    }
  }
})

-- Enable colored `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
require("indent_blankline").setup {
  show_trailing_blankline_indent = false,
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  current_line_blame = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>gD', gs.diffthis) -- [G]it [D]iff
    map('n', '<leader>gd', function() gs.diffthis('~') end) -- [G]it [D]iff all
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

require('telescope').setup {
  defaults = {
		vimgrep_arguments = vimgrep_arguments,
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
			find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git", "--strip-cwd-prefix" }
    }
  },
}

require('telescope').load_extension('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })


vim.keymap.set('n', '<c-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'lua', 'typescript', 'rust', 'go', 'python' },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      -- TODO: I'm not sure for this one.
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      '#E06C75',
      '#E5C07B',
      '#98C379',
      '#56B6C2',
      '#61AFEF',
      '#C678DD',
    }, -- table of hex strings

    -- termcolors = {} -- table of colour name strings
  }
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  navic.attach(client, bufnr)

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('<C-]>', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting,
    { desc = 'Format current buffer with LSP' })
end

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  float = {
    source = 'always',
  },
})
-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { 'terraformls', 'clangd', 'pyright', 'rust_analyzer', 'sumneko_lua', 'tsserver' }

-- Ensure the servers above are installed
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Terraform
require'lspconfig'.tflint.setup{}

-- Python

require 'lspconfig'.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities, -- send the lsp what neovim allows
}

-- Example custom configuration for lua
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- nvim-cmp setup
vim.o.completeopt = 'menu,menuone,noselect'

local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false, -- Do not autoselect with enter
    },
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp'},
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'git' },
    { name = 'buffer', keyword_length = 3},
    { name = 'tmux' , keyword_length = 3},
  },

  view = {
    entries = 'custom'
  },

  formatting = {
    format = lspkind.cmp_format({
      -- mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      with_text = true,

      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        tmux = "[tmux]",
        luasnip = "[snip]",
      },
      experimental = {
        ghost_text = false
      },
      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
}

require('dressing').setup()
require('colorizer').setup({})

require 'nvim-lastplace'.setup {}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.code_actions.refactoring,
  null_ls.builtins.code_actions.shellcheck,
  null_ls.builtins.diagnostics.codespell.with({
    -- args = {"--dictionary", "-", "--ignore-words", "$HOME/.codespell-ignore"}
    command = "codespell-nvim",
    arg = { "-" },
    -- args = {"--dictionary=-"}
  }),

  null_ls.builtins.diagnostics.jsonlint,
  null_ls.builtins.diagnostics.flake8.with({
    extra_args = { "--max-line-length", "99" }
  }),
  -- null_ls.builtins.diagnostics.mypy,
  null_ls.builtins.formatting.jq,
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.black
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
  sources = sources,
  -- on_attach = function(client, bufnr)
  --   if client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
  --         vim.lsp.buf.formatting_sync()
  --       end,
  --     })
  --   end
  -- end,
})

-- Refactoring
require('refactoring').setup({})

-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})



-- vim.cmd [[call wilder#enable_cmdline_enter()
-- set wildcharm=<Tab>
-- cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
-- cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
-- call wilder#set_option('modes', ['/'])
--
-- call wilder#set_option('pipeline', [
--       \   wilder#branch(
--       \     wilder#cmdline_pipeline({
--       \       'fuzzy': 1,
--       \       'sorter': wilder#python_difflib_sorter(),
--       \     }),
--       \   ),
--       \ ])
--
-- let s:highlighters = [
--         \ wilder#pcre2_highlighter(),
--         \ wilder#basic_highlighter(),
--         \ ]
--
-- call wilder#set_option('renderer', wilder#renderer_mux({
--       \ ':': wilder#popupmenu_renderer({
--       \   'highlighter': s:highlighters,
--       \ }),
--       \ '/': wilder#wildmenu_renderer({
--       \   'highlighter': s:highlighters,
--       \ }),
--       \ }))
-- ]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
