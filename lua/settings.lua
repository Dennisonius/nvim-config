local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec2 -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options
-- Направление перевода с русского на английский
g.translate_source = 'ru'
g.translate_target = 'en'
-- Компактный вид у тагбара и Отк. сортировка по имени у тагбара
g.tagbar_compact = 1
g.tagbar_sort = 0
-- <leader> = whitespace
g.mapleader = ' '

-- Конфиг ale + eslint
g.ale_fixers = { javascript = { 'eslint' } }
g.ale_sign_error = '❌'
g.ale_sign_warning = '⚠️'
g.ale_fix_on_save = 1
-- Запуск линтера, только при сохранении
g.ale_lint_on_text_changed = 'never'
g.ale_lint_on_insert_leave = 0

cmd([[ let g:clipboard = {
			\   'name': 'WslClipboard',
			\   'copy': {
			\      '+': 'clip.exe',
			\      '*': 'clip.exe',
			\    },
			\   'paste': {
			\      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			\      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			\   },
			\   'cache_enabled': 0,
			\ }
]])

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------
opt.colorcolumn = '80'                                                  -- Разделитель на 80 символов
opt.cursorline = true                                                   -- Подсветка строки с курсором
opt.spelllang = { 'en_us', 'ru' }                                       -- Словари рус eng
opt.number = true                                                       -- Включаем нумерацию строк
opt.relativenumber = true                                               -- Вкл. относительную нумерацию строк
opt.so = 999                                                            -- Курсор всегда в центре экрана
opt.undofile = true                                                     -- Возможность отката назад
opt.splitright = true                                                   -- vertical split вправо
opt.splitbelow = true                                                   -- horizontal split вниз
opt.wrap = false                                                        -- не переносить строку, если не помещается на весь экран
opt.fileencodings = { 'ucs-bom', 'utf-8', 'defalut', 'cp1251', 'latin1' } -- добавит cp1251
-----------------------------------------------------------
-- Цветовая схема
-----------------------------------------------------------
opt.termguicolors = true --  24-bit RGB colors
cmd 'colorscheme onedark'
-----------------------------------------------------------
-- Табы и отступы
-----------------------------------------------------------
cmd([[
filetype indent plugin on
syntax enable
]])
opt.expandtab = true   -- use spaces instead of tabs
opt.shiftwidth = 4     -- shift 4 spaces when tab
opt.tabstop = 4        -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
cmd [[
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]]
-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------
-- Запоминает где nvim последний раз редактировал файл
cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], { output = false })

-----------------------------------------------------------
-- Установки для плагинов
-----------------------------------------------------------
-- LSP settings

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup({
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' }
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 20 },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline', max_item_count = 20 }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-----------------------------------------------------------
-- Установки для Neovide
-----------------------------------------------------------
if g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.o.guifont = "DejaVuSansMono NFM:h11"
  g.neovide_cursor_animation_length = 0
end
