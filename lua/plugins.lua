-----------------------------------------------------------
-- Установка менеджера плагинов
-----------------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer сам себя
    use 'wbthomason/packer.nvim'

    -----------------------------------------------------------
    -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
    -----------------------------------------------------------

    -- Цветовая схема
    use {
			'navarasu/onedark.nvim',
			config = function()
				require('onedark').setup{
					-- Main options --
					style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				}
				require('onedark').load()
			end,
		}
    --- Информационная строка внизу
    use {
			'nvim-lualine/lualine.nvim',
			requires = {'nvim-tree/nvim-web-devicons', opt = true},
			config = function()
				require('lualine').setup()
			end,
		}
    -- Табы вверху
    use {
			'akinsho/bufferline.nvim',
			tag = '*',
			requires = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('bufferline').setup{}
			end,
		}


    -----------------------------------------------------------
    -- НАВИГАЦИЯ
    -----------------------------------------------------------
    -- Файловый менеджер
    use {
			'nvim-tree/nvim-tree.lua',
			requires = 'nvim-tree/nvim-web-devicons',
			config = function()
				require('nvim-tree').setup{}
			end,
		}
    -- Навигация внутри файла по классам и функциям
    use 'preservim/tagbar'
    -- Замена fzf и ack
    use {
			'nvim-telescope/telescope.nvim',
			requires = { {'nvim-lua/plenary.nvim'},
									 {'nvim-telescope/telescope-live-grep-args.nvim'} },
			config = function()
				require'telescope'.setup {
					defaults = {
						-- Default configuration for telescope goes here:
						-- config_key = value,
						-- ..
					},
					pickers = {
						-- Default configuration for builtin pickers goes here:
						-- picker_name = {
						--   picker_config_key = value,
						--   ...
						-- }
						-- Now the picker_config_key will be applied every time you call this
						-- builtin picker
					},
					extensions = {
						live_grep_args = {
						auto_quoting = false, -- enable/disable auto-quoting
						}
						-- Your extension configuration goes here:
						-- extension_name = {
						--   extension_config_key = value,
						-- }
						-- please take a look at the readme of the extension you want to configure
					}
				}
				require'telescope'.load_extension('live_grep_args')
			end,
		}


    -----------------------------------------------------------
    -- LSP и автодополнялка
    -----------------------------------------------------------


    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use {
			'nvim-treesitter/nvim-treesitter',
			config = function()
				require'nvim-treesitter.configs'.setup {
					-- A list of parser names, or "all"
					ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

					-- Install parsers synchronously (only applied to `ensure_installed`)
					sync_install = false,

					-- Automatically install missing parsers when entering buffer
					auto_install = false,

					highlight = {
						-- `false` will disable the whole extension
						enable = true,
					},
				}
			end,
		}
    -- Collection of configurations for built-in LSP client
    use {
      'neovim/nvim-lspconfig',
			config = function()
        require'lspconfig'.clangd.setup{}
			end,
    }
    -- Установщик lsp-серверов, линтеров, форматтеров и т.д.
    --use 'williamboman/mason.nvim'
    --[[ Автодополнялка
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'saadparwaiz1/cmp_luasnip'
    --- Автодополнлялка к файловой системе
    use 'hrsh7th/cmp-path'
    -- Snippets plugin
    use 'L3MON4D3/LuaSnip'
		--]]



    -----------------------------------------------------------
    -- PYTHON
    -----------------------------------------------------------
    --[[- Шапка с импортами приводим в порядок
		use 'fisadev/vim-isort'
    -- Поддержка темплейтом jinja2
    use 'mitsuhiko/vim-jinja'


    -----------------------------------------------------------
    -- HTML и CSS
    -----------------------------------------------------------
    -- Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
    use 'idanarye/breeze.vim'
    -- Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>
    use 'alvan/vim-closetag'
    -- Подсвечивает #ffffff
    use 'ap/vim-css-color'
		--]]

    -----------------------------------------------------------
    -- РАЗНОЕ
    -----------------------------------------------------------
    -- Бесполезный плагин, чисто анимация
    use 'eandrju/cellular-automaton.nvim'
		--[[
    -- Даже если включена русская раскладка vim команды будут работать
    use 'powerman/vim-plugin-ruscmd'
    -- 'Автоформатирование' кода для всех языков
    use 'Chiel92/vim-autoformat'
    -- ]p - вставить на строку выше, [p - ниже
    use 'tpope/vim-unimpaired'
    -- Переводчик рус - англ
    use 'skanehira/translate.vim'
    --- popup окошки
    use 'nvim-lua/popup.nvim'
    -- Обрамляет или снимает обрамление. Выдели слово, нажми S и набери <h1>
    use 'tpope/vim-surround'
    -- Считает кол-во совпадений при поиске
    use 'google/vim-searchindex'
    -- Может повторять через . vimsurround
    use 'tpope/vim-repeat'
    -- Стартовая страница, если просто набрать vim в консоле
    use 'mhinz/vim-startify'
    -- Комментирует по gc все, вне зависимости от языка программирования
    use { 'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end }
    -- Обрамляет строку в теги по ctrl- y + ,
    use 'mattn/emmet-vim'
    -- Закрывает автоматом скобки
    use 'cohama/lexima.vim'
    -- Линтер, работает для всех языков
    use 'dense-analysis/ale'
--]]
    if packer_bootstrap then
        require('packer').sync()
    end
end)

--[[if packer_bootstrap then
    return
end--]]

