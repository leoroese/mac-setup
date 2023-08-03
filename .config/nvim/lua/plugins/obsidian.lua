return {
    "epwalsh/obsidian.nvim",
    lazy = true,
    -- event = { "BufReadPre ~/dev/obsidian/Lore Repo/**.md" },
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    event = { "BufReadPre " .. vim.fn.expand "~" .. "/dev/obsidian/Lore Repo/**.md" },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        dir = "~/dev/obsidian/Lore Repo", -- no need to call 'vim.fn.expand' here
        -- see below for full list of options 👇
        notes = "100 zettel repo",
        daily_notes = {
            folder = "200 personal/daily",
            template = "templates/daily.md",
        },
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return suffix
        end,
        disable_frontmatter = true,
        -- Optional, alternatively you can customize the frontmatter data.
        note_frontmatter_func = function(note)
            -- This is equivalent to the default frontmatter function.
            local out = { id = note.id, aliases = note.aliases, tags = note.tags }
            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end
            return out
        end,
        -- Optional, completion.
        completion = {
            -- If using nvim-cmp, otherwise set to false
            nvim_cmp = true,
            -- Trigger completion at 2 chars
            min_chars = 2,
            -- Where to put new notes created from completion. Valid options are
            --  * "current_dir" - put new notes in same directory as the current buffer.
            --  * "notes_subdir" - put new notes in the default notes subdirectory.
            new_notes_location = "current_dir",
            -- Whether to add the output of the node_id_func to new notes in autocompletion.
            -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
            prepend_note_id = false
        },
        mappings = {},
        config = function()
            --     vim.keymap.set("n", "<leader>oo", function() require('obsidian.command').open() end, { noremap = true, silent = true })
            -- vim.keymap.set("n", "<leader>bn",
            --     "<Cmd>ObsidianNew<CR>",
            --     { noremap = true, silent = true, desc = "[Obsidian] [N]ew"})
            --     vim.keymap.set("n", "<leader>os", function() require("obsidian.command").search() end,
            --     { noremap = true, silent = true })
            --     vim.keymap.set("n", "<leader>od", function() require("obsidian.command").today() end,
            --     { noremap = true, silent = true })
            --     vim.keymap.set("n", "<leader>ob", function() require("obsidian.command").backlinks() end,
            --     { noremap = true, silent = true })
            --     vim.keymap.set("n", "<leader>ot", function() require("obsidian.command").template() end,
            --     { noremap = true, silent = true })
            --     vim.keymap.set("n", "<leader>oq", function() require("obsidian.command").quick_switch() end,
            --     { noremap = true, silent = true })
            --     vim.keymap.set("n", "<leader>ol", function() require("obsidian.command").link_new() end,
            --     { noremap = true, silent = true })
            -- vim.keymap.set("n", "gf", function()
            --     if require("obsidian").util.cursor_on_markdown_link() then
            --         return "<cmd>ObsidianFollowLink<CR>"
            --     else
            --         return "gf"
            --     end
            -- end, { noremap = false, expr = true })
        end,
        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            vim.fn.jobstart({ "open", url }) -- Mac OS
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
        end,
        -- Optional, set to true if you use the Obsidian Advanced URI plugin.
        -- https://github.com/Vinzent03/obsidian-advanced-uri
        use_advanced_uri = true,
        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = true,
        -- Optional, by default commands like `:ObsidianSearch` will attempt to use
        -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
        -- first one they find. By setting this option to your preferred
        -- finder you can attempt it first. Note that if the specified finder
        -- is not installed, or if it the command does not support it, the
        -- remaining finders will be attempted in the original order.
        finder = "telescope.nvim",
    },
    --  config = function()
    --      vim.keymap.set('n', '<leader>of', require('obsidian.mapping').gf_passthrough, { desc = '[O]bsidian [F]ollow' })
    --       vim.keymap.set('n', '<leader>on', )., { desc = '[O]bsidian [N]ew' })
    -- end
}
