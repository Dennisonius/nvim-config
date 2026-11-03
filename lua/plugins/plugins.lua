return {
  -----------------------------------------------------------
  -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
  -----------------------------------------------------------

  -- Цветовая схема
  {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function()
      require('onedark').setup {
        -- Main options --
        style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      }
      require('onedark').load()
    end,
  },

  { 'nvim-tree/nvim-web-devicons',                  lazy = true },

  --- Информационная строка внизу
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end,
  },

  -- Табы вверху
  {
    'akinsho/bufferline.nvim',
    version = '*',
    config = function()
      require('bufferline').setup {
        options = {
          mode = "buffers", -- set to "tabs" to only show tabpages instead
          sort_by = 'directory'-- | 'tabs'
          -- sort_by = 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
          --     -- add custom logic
          --     local modified_a = vim.fn.getftime(buffer_a.path)
          --     local modified_b = vim.fn.getftime(buffer_b.path)
          --     return modified_a > modified_b
          -- end,
        }
      }
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
      require('nvim-tree').setup {
        filters = {
          git_ignored = false,
        },
        -- on_attach = my_on_attach,

        on_attach = function(bufnr)
          local api = require "nvim-tree.api"

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- default mappings
          api.config.mappings.default_on_attach(bufnr)

          -- custom mappings
          vim.keymap.set("n", "<leader>wl", function() api.tree.resize({relative = 20})end, opts("20 Wider"))
          vim.keymap.set("n", "<leader>wh", function() api.tree.resize({relative = -20})end, opts("20 Narrower"))

        end,

      }
    end,
  },

  -- Навигация внутри файла по классам и функциям
  { 'preservim/tagbar',                             lazy = false },

  -- Замена fzf и ack
  { 'nvim-lua/plenary.nvim',                        lazy = true },

  { 'nvim-telescope/telescope-live-grep-args.nvim', lazy = true },

  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    config = function()
      require 'telescope'.setup {
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
            auto_quoting = false,   -- enable/disable auto-quoting
          }
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
        }
      }
      require 'telescope'.load_extension('live_grep_args')
    end,
  },

  -----------------------------------------------------------
  -- LSP и автодополнялка
  -----------------------------------------------------------

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter'.install { "bash", "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }
    end,
  },

  -- Collection of configurations for built-in LSP client
  {
    'neovim/nvim-lspconfig',
    opts = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local ret = {
        servers = {
          -- configuration for all lsp servers
          clangd = {
            capabilities = capabilities,
          },
          pylsp = {
            capabilities = capabilities,
          },
          lua_ls = {
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
          },
          neocmake = {
            capabilities = capabilities,
            default_config = {
              cmd = { "neocmakelsp", "--stdio" },
              filetypes = { "cmake" },
              root_dir = function(fname)
                return vim.fs.dirname(vim.fs.find('.svn', { path = fname, upward = true })[1])
              end,
              single_file_support = true, -- suggested
              -- on_attach = on_attach,      -- on_attach is the on_attach function you defined
              init_options = {
                format = {
                  enable = true
                },
                lint = {
                  enable = true
                },
                scan_cmake_in_package = true -- default is true
              },
            },
          },
        },
      }
      return ret
    end,
    config = function(_, opts)
      for server, server_opts in pairs(opts.servers) do
        -- Pass the custom settings to Neovim
        if not vim.tbl_isempty(server_opts) then
          vim.lsp.config(server, server_opts)
        end
        -- Start the server
        vim.lsp.enable(server)
      end
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
    -- HTML и CSS
    -----------------------------------------------------------

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true,
        enable_commands = false,
        commented = false,
      }
      require("dap").adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }
    end,
  },
  -----------------------------------------------------------
  -- РАЗНОЕ
  -----------------------------------------------------------
  -- Бесполезный плагин, чисто анимация
  { 'eandrju/cellular-automaton.nvim', lazy = false },
  -- { 'github/copilot.vim',              lazy = false },
  -- add lua copilot plugin
  {
    'zbirenbaum/copilot.lua',
    lazy = false,
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          }
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l><C-l>",
            accept_word = "<C-l><C-w>",
            accept_line = false,
            next = "<C-l><C-j>",
            prev = "<C-l><C-k>",
            dismiss = "<C-l><C-s>",
          },
        },
        filetypes = {
          ["*"] = true,
          --["python"] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {},
      }
    end,
  },
  -- add avante.nvim
  {
    "yetone/avante.nvim",
    --[[ build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
        --]]
    event = "VeryLazy",
    mode = "legacy", -- Switch from "agentic" to "legacy"
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      -- for example
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        moonshot = {
          endpoint = "https://api.moonshot.ai/v1",
          model = "kimi-k2-0711-preview",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 32768,
          },
        },
        copilot = {
          -- No extra config needed
        },
        deepseek = {
          __inherited_from = "openai",
          api_key_name = os.getenv('DEEPSEEK_API_KEY'),
          endpoint = "https://api.deepseek.com",
          model = "deepseek-coder",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim",      -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
  --[[
    -- Даже если включена русская раскладка vim команды будут работать
    use 'powerman/vim-plugin-ruscmd'
    -- 'Автоформатирование' кода для всех языков
    use 'Chiel92/vim-autoformat'
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
    -- Обрамляет строку в теги по ctrl- y + ,
    use 'mattn/emmet-vim'
    -- Закрывает автоматом скобки
    use 'cohama/lexima.vim'
    -- Линтер, работает для всех языков
    use 'dense-analysis/ale'
--]]
}

