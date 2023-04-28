local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map('n', '<Space>', '<Nop>', default_opts)
-- Системный буфер обмена shift - Y
map('v', 'S-Y', '"+y', {})
-- Типа 'Нажимает' на ESC при быстром нажатии jj, чтобы не тянуться
map('i', 'jj', '<Esc>', {noremap = true})
-- Стрелочки откл. Использовать hjkl
map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})
-- Автоформат + сохранение по CTRL-s , как в нормальном, так и в insert режиме
map('n', '<C-s>', ':Autoformat<CR>:w<CR>',  default_opts)
map('i', '<C-s>', '<esc>:Autoformat<CR>:w<CR>', default_opts)
-- Переключение вкладок с помощью TAB или shift-tab (akinsho/bufferline.nvim)
map('n', '<Tab>', ':BufferLineCycleNext<CR>', default_opts)
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', default_opts)
-- Пролистнуть на страницу вниз / вверх (как в браузерах)
map('n', ',', '<PageDown>zz', default_opts)
map('n', '<A-,>', '<PageUp>zz', default_opts)
map('v', ',', '<PageDown>zz', default_opts)
map('v', '<A-,>', '<PageUp>zz', default_opts)
-- " Переводчик рус -> eng
map('v', 't', '<Plug>(VTranslate)', {})
-- my telescope mappings
map('n', '<leader>fa', [[ <cmd>lua require('telescope.builtin').find_files()<cr> ]], default_opts)
map('n', '<leader>fp', [[ <cmd>lua require('telescope.builtin').buffers()<cr> ]], default_opts)
map('n', '<leader>fr', [[ <cmd>lua require('telescope.builtin').registers()<cr> ]], default_opts)
map('n', '<leader>ff', [[ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr> ]], default_opts)
-- search only c-type files
map('n', '<leader>fl', [[ <cmd>lua require('telescope.builtin').live_grep{type_filter = 'c'}<cr> ]], default_opts)
-- Close current window
map('n', '<leader>c', ':close<CR>',  default_opts)

-----------------------------------------------------------
-- Фн. клавиши по F1 .. F12
-----------------------------------------------------------
-- По F1 очищаем последний поиск с подсветкой
map('n', '<F1>', ':nohl<CR>', default_opts)
-- <F2> перечитать конфигурацию nvim Может не работать, если echo $TERM  xterm-256color
map('n', '<F2>', ':so ~/.config/nvim/init.lua<CR>:so ~/.config/nvim/lua/plugins.lua<CR>:so ~/.config/nvim/lua/settings.lua<CR>:so ~/.config/nvim/lua/keymaps.lua<CR>', { noremap = true })
-- <F3> Открыть всю nvim конфигурацию для редактирования
map('n', '<F3>', ':rightbelow vsplit ~/.config/nvim/init.lua<CR>:split ~/.config/nvim/lua/plugins.lua<CR>:split ~/.config/nvim/lua/settings.lua<CR>:split ~/.config/nvim/lua/keymaps.lua<CR>', { noremap = true })
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

