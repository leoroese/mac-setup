return {
  -- NOTE: First, some plugins that don't require any configuration
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
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
        map('n', '<leader>gp', gs.prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        map('n', '<leader>gn', gs.next_hunk,
          { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        map('n', '<leader>ph', gs.preview_hunk,
          { buffer = bufnr, desc = '[P]review [H]unk' })
        map('n', '<leader>gd', gs.diffthis,
          { buffer = bufnr, desc = '[G]it [D]iff this' })
        map('n', '<leaader>gD', function() gs.diffthis('~') end,
          { buffer = bufnr, desc = '[G]it [D]iff root' })
        map('n', '<leader>gb', gs.blame_line,
          { buffer = bufnr, desc = '[G]it [B]lame' })
        map('n', '<leader>gtd', gs.toggle_deleted,
          { buffer = bufnr, desc = '[G]it [T]oggle [D]eleted' })
      end,
    },
  },


}
