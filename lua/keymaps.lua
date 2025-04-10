local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

map('n', '<Space>', '<Nop>', default_opts)
-- Типа 'Нажимает' на ESC при быстром нажатии jj, чтобы не тянуться
map('i', 'jj', '<Esc>', { noremap = true })
-- Стрелочки откл. Использовать hjkl
map('', '<up>', '6zl6<C-Y>', { noremap = true, silent = false })
map('', '<down>', '6zh6<C-E>', { noremap = true, silent = false })
map('', '<left>', '6zh6<C-Y>', { noremap = true, silent = false })
map('', '<right>', '6zl6<C-E>', { noremap = true, silent = false })
-- Переключение вкладок с помощью Backspace или Alt-BS (akinsho/bufferline.nvim)
map('n', '<BS>', ':BufferLineCycleNext<CR>', default_opts)
map('n', '<A-BS>', ':BufferLineCyclePrev<CR>', default_opts)
-- Пролистнуть на страницу вниз / вверх (как в браузерах)
map('n', ',', '<PageDown>zz', default_opts)
map('n', '<A-,>', '<PageUp>zz', default_opts)
map('v', ',', '<PageDown>zz', default_opts)
map('v', '<A-,>', '<PageUp>zz', default_opts)
-- Пролистнуть на страницу вправо влево
map('n', 'H', '6zh', default_opts)
map('n', 'L', '6zl', default_opts)
map('v', 'H', '6zh', default_opts)
map('v', 'L', '6zl', default_opts)
-- Переводчик рус -> eng
map('v', 't', '<Plug>(VTranslate)', {})
-- My telescope mappings
map('n', '<leader>fa', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], default_opts)
map('n', '<leader>fp', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], default_opts)
map('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').registers()<cr>]], default_opts)
map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], default_opts)
map('n', '<leader>fl', [[<cmd>lua require('telescope.builtin').live_grep{type_filter = 'c'}<cr>]], default_opts)
map('n', '<leader>fw',
  [[<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor({postfix = ' -F -tc'})<cr>]],
  default_opts)
map('v', '<leader>fw',
  [[<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection({postfix = ' -F -tc'})<cr>]],
  default_opts)
-- Lsp mappings
map('n', '<leader>lr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], default_opts)
map('n', '<leader>ln', [[<cmd>lua vim.diagnostic.goto_next()<cr>]], default_opts)
map('n', '<leader>lp', [[<cmd>lua vim.diagnostic.goto_prev()<cr>]], default_opts)
map('n', '<leader>le', [[<cmd>lua vim.lsp.buf.rename()<cr>]], default_opts)
map('n', '<leader>la', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], default_opts)
map('n', '<leader>lh', [[<cmd>lua vim.lsp.buf.hover()<cr>]], default_opts)
--map('i', '<C-F>', [[<cmd>lua vim.lsp.buf.completion()<cr>]], default_opts)
-- Search only c-type files
-- Close current window
map('n', '<leader>c', ':close<CR>', default_opts)
map('n', '<leader>cb', ':BufferLineCycleNext<CR>:bd #<CR>', default_opts)
-- Системный буфер обмена
map('n', '<leader>y', '"+y', {})
map('n', '<leader>p', '"+p', {})
-- По включению/выключению восстановление/сохранение сессии
map('n', '<leader>sl', ':so .ses.vim<CR>', {})
map('n', '<leader>ss', ':wa<CR>:mks! .ses.vim<CR>:qa<CR>', {})

-----------------------------------------------------------
-- Фн. клавиши по F1 .. F12
-----------------------------------------------------------
-- По F1 очищаем последний поиск с подсветкой
map('n', '<F1>', ':nohl<CR>', default_opts)
-- <F2> перечитать конфигурацию nvim Может не работать, если echo $TERM  xterm-256color
map('n', '<F2>',
  ':so ~/.config/nvim/init.lua<CR>:so ~/.config/nvim/lua/settings.lua<CR>:so ~/.config/nvim/lua/keymaps.lua<CR>',
  { noremap = true })
-- <F3> Открыть всю nvim конфигурацию для редактирования
map('n', '<F3>',
  ':e ~/.config/nvim/lua/config/lazy.lua<CR>:rightbelow vsplit ~/.config/nvim/init.lua<CR>:split ~/.config/nvim/lua/settings.lua<CR>:split ~/.config/nvim/lua/plugins/plugins.lua<CR>:split ~/.config/nvim/lua/keymaps.lua<CR>',
  { noremap = true })
-- <F4> Поиск слова под курсором
map('n', '<F4>', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], default_opts)
-- <F5> Поиск слова в модальном окошке
map('n', '<F5>', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>]], default_opts)
-- <F6> разные вариации нумераций строк, можно переключаться
map('n', '<F6>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>', default_opts)
-- <F7> дерево файлов.
map('n', '<F7>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>', default_opts)
-- <F8>  Показ дерева классов и функций, плагин majutsushi/tagbar
map('n', '<F8>', ':TagbarToggle<CR>', default_opts)
-- <F11> Проверка орфографии  для русского и английского языка
map('n', '<F11>', ':set spell!<CR>', default_opts)
map('i', '<F11>', '<C-O>:set spell!<CR>', default_opts)
