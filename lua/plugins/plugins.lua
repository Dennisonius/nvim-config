return {
    -----------------------------------------------------------
    -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
    -----------------------------------------------------------

    -- Цветовая схема
    {
			"navarasu/onedark.nvim",
      lazy = false,
			config = function()
				require('onedark').setup{
					-- Main options --
					style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				}
				require('onedark').load()
			end,
		},

		{'nvim-tree/nvim-web-devicons', lazy = true},

    --- Информационная строка внизу
    {
			'nvim-lualine/lualine.nvim',
			config = function()
				require('lualine').setup()
			end,
		},

    -- Табы вверху
    {
			'akinsho/bufferline.nvim',
			version = '*',
			config = function()
				require('bufferline').setup{}
			end,
		},

    -----------------------------------------------------------
    -- НАВИГАЦИЯ
    -----------------------------------------------------------
    -- Файловый менеджер
    {
			'nvim-tree/nvim-tree.lua',
      lazy = false,
			config = function()
				require('nvim-tree').setup{}
			end,
		},

    -- Навигация внутри файла по классам и функциям
    { 'preservim/tagbar', lazy = false },

    -- Замена fzf и ack
    {'nvim-lua/plenary.nvim', lazy = true },

    {'nvim-telescope/telescope-live-grep-args.nvim', lazy = true },

    {
			'nvim-telescope/telescope.nvim',
      lazy = false,
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
		},

    -----------------------------------------------------------
    -- LSP и автодополнялка
    -----------------------------------------------------------

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    {
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
		},

    -- Collection of configurations for built-in LSP client
    {
      'neovim/nvim-lspconfig',
			config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require'lspconfig'.clangd.setup{
          capabilities = capabilities,
        }
        require'lspconfig'.pylsp.setup{
          capabilities = capabilities,
        }
        require'lspconfig'.lua_ls.setup{
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                  'vim',
                  'require'
                },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            },
          },
        }
			end,
    },

    -- Автодополнялка
    { 'hrsh7th/nvim-cmp' },
    -- Источники для автодополнения в конкретных ситуациях
    { 'hrsh7th/cmp-nvim-lsp' },
    --{ 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },

    -- Установщик lsp-серверов, линтеров, форматтеров и т.д.
    {
      'williamboman/mason.nvim',
      lazy = false,
			config = function()
        require('mason').setup()
			end,
    },

    --[[ Сниппеты?
    use 'saadparwaiz1/cmp_luasnip'
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
    { 'eandrju/cellular-automaton.nvim', lazy = false },
    { 'github/copilot.vim', lazy = false },
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
}

