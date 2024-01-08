local Util = require("lazyvim.util")

-- Define the utility function for creating keymaps
local function map_telescope(key, func, desc)
  return { key, func, desc = desc }
end

local function formattedName(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)
end

-- Define a function to return the Telescope keymaps
local function get_telescope_keymaps()
  return {
    -- Buffers
    map_telescope("<leader><space>", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", "Switch Buffer"),
    map_telescope("<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", "Switch Buffer"),

    -- Grep and Find
    map_telescope("<leader>/", Util.telescope("live_grep"), "Grep (root dir)"),
    map_telescope("<leader>sg", Util.telescope("live_grep"), "Grep (root dir)"),
    map_telescope("<leader>sG", Util.telescope("live_grep", { cwd = false }), "Grep (cwd)"),

    -- Files
    map_telescope(
      "<leader>sf",
      "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>",
      "Search All Files (entry point)"
    ),
    map_telescope("<leader>sF", Util.telescope("files", { cwd = false }), "Find Files (cwd)"),

    -- Search specific files
    map_telescope("<leader>sc", Util.telescope.config_files(), "Search Config File"),

    -- History and Commands
    map_telescope("<leader>:", "<cmd>Telescope command_history<cr>", "Command History"),
    map_telescope("<leader>sc", "<cmd>Telescope command_history<cr>", "Command History"),
    map_telescope("<leader>sC", "<cmd>Telescope commands<cr>", "Commands"),

    -- Diagnostics
    map_telescope("<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", "Document diagnostics"),
    map_telescope("<leader>sD", "<cmd>Telescope diagnostics<cr>", "Workspace diagnostics"),

    -- Git
    map_telescope("<leader>sgc", "<cmd>Telescope git_commits<CR>", "commits"),
    map_telescope("<leader>sgs", "<cmd>Telescope git_status<CR>", "status"),

    -- Misc
    map_telescope('<leader>s"', "<cmd>Telescope registers<cr>", "Registers"),
    map_telescope("<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer"),
    map_telescope("<leader>sh", "<cmd>Telescope help_tags<cr>", "Help Pages"),
    map_telescope("<leader>sH", "<cmd>Telescope highlights<cr>", "Search Highlight Groups"),
    map_telescope("<leader>sk", "<cmd>Telescope keymaps<cr>", "Key Maps"),
    map_telescope("<leader>sM", "<cmd>Telescope man_pages<cr>", "Man Pages"),
    map_telescope("<leader>sm", "<cmd>Telescope marks<cr>", "Jump to Mark"),
    map_telescope("<leader>so", "<cmd>Telescope vim_options<cr>", "Options"),
    map_telescope("<leader>sR", "<cmd>Telescope resume<cr>", "Resume"),

    -- Word and Selection
    map_telescope("<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), "Word (root dir)"),
    map_telescope("<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), "Word (cwd)"),
    map_telescope("<leader>sw", Util.telescope("grep_string"), { mode = "v", desc = "Selection (root dir)" }),
    map_telescope(
      "<leader>sW",
      Util.telescope("grep_string", { cwd = false }),
      { mode = "v", desc = "Selection (cwd)" }
    ),

    -- Colorscheme
    map_telescope("<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), "Colorscheme with preview"),

    -- Symbols
    map_telescope("<leader>ss", function()
      require("telescope.builtin").lsp_document_symbols({
        symbols = require("lazyvim.config").get_kind_filter(),
      })
    end, "Goto Symbol"),
    map_telescope("<leader>sS", function()
      require("telescope.builtin").lsp_dynamic_workspace_symbols({
        symbols = require("lazyvim.config").get_kind_filter(),
      })
    end, "Goto Symbol (Workspace)"),
  }
end

-- Telescope plugin configuration
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          Util.on_load("telescope.nvim", function()
            require("telescope").load_extension("fzf")
          end)
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-frecency.nvim",
    },
    file_ignore_patterns = { "%.git/." },
    keys = get_telescope_keymaps(),
    opts = function()
      local actions = require("telescope.actions")
      local icons = require("leo.core.icons")

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { hidden = true, default_text = line })()
      end

      return {
        defaults = {
          previewer = false,
          prompt_prefix = " " .. icons.ui.Telescope .. " ",
          selection_caret = icons.ui.BoldArrowRight .. " ",
          file_ignore_patterns = { "%.git/.", "node_modules", "package-lock.json", "pnpm-lock.json" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          layout_config = {
            preview_cutoff = 120,
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },

          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_selected_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<esc>"] = actions.close,
            },
            n = {
              ["q"] = actions.close,
            },
          },
          pickers = {
            find_files = {
              previewer = false,
              path_display = formattedName,
              layout_config = {
                height = 0.4,
                preview_cutoff = 120,
              },
            },
            git_files = {
              previewer = false,
              path_display = formattedName,
              layout_config = {
                height = 0.4,
                prompt_position = "top",
                preview_cutoff = 120,
              },
            },
            buffers = {
              path_display = formattedName,
              mappings = {
                i = {
                  ["<c-d>"] = actions.delete_buffer,
                },
                n = {
                  ["<c-d>"] = actions.delete_buffer,
                },
              },
              previewer = false,
              initial_mode = "normal",
              -- theme = "dropdown",
              layout_config = {
                height = 0.4,
                width = 0.6,
                preview_cutoff = 120,
              },
            },
            current_buffer_fuzzy_find = {
              previewer = true,
              layout_config = {
                preview_cutoff = 120,
              },
            },
            live_grep = {
              only_sort_text = true,
              previewer = true,
            },
            grep_string = {
              only_sort_text = true,
              previewer = true,
            },
            lsp_references = {
              show_line = false,
              previewer = true,
            },
            treesitter = {
              show_line = false,
              previewer = true,
            },
            colorscheme = {
              enable_preview = true,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              previewer = false,
              initial_mode = "normal",
              sorting_strategy = "ascending",
              layout_strategy = "horizontal",
              layout_config = {
                horizontal = {
                  width = 0.5,
                  height = 0.4,
                  preview_width = 0.6,
                },
              },
            }),
          },
          frecency = {
            default_workspace = "CWD",
            show_scores = true,
            show_unindexed = true,
            disable_devicons = false,
            ignore_patterns = {
              "*.git/*",
              "*/tmp/*",
              "*/lua-language-server/*",
            },
          },
        },
      }
    end,
  },
}
