return {
    {
        "ThePrimeagen/harpoon",
        config = function()
            local mark = require('harpoon.mark')
            local ui = require('harpoon.ui')
            vim.keymap.set('n', '<leader>ha', mark.add_file,
                { noremap = true, silent = true, desc = '[H]arpoon [A]add current file' })
            vim.keymap.set('n', '<leader>hr', mark.rm_file,
                { noremap = true, silent = true, desc = '[H]arpoon [R]remove current file' })
            vim.keymap.set('n', '<leader>hc', mark.clear_all,
                { noremap = true, silent = true, desc = '[H]arpoon [C]lear' })
            vim.keymap.set('n', '<leader>hs', ui.toggle_quick_menu,
                { noremap = true, silent = true, desc = '[H]arpoon [S]earch list' })
            vim.keymap.set('n', '<leader>hn', ui.nav_next,
                { noremap = true, silent = true, desc = '[H]arpoon [N]ext file' })
            vim.keymap.set('n', '<leader>hp', ui.nav_prev,
                { noremap = true, silent = true, desc = '[H]arpoon [P]rev file' })
            vim.keymap.set('n', '<leader>h1', function() ui.nav_file(1) end,
                { noremap = true, silent = true, desc = '[H]arpoon file 1' })
            vim.keymap.set('n', '<leader>h2', function() ui.nav_file(2) end,
                { noremap = true, silent = true, desc = '[H]arpoon file 2' })
            vim.keymap.set('n', '<leader>h3', function() ui.nav_file(3) end,
                { noremap = true, silent = true, desc = '[H]arpoon file 3' })
            vim.keymap.set('n', '<leader>h4', function() ui.nav_file(4) end,
                { noremap = true, silent = true, desc = '[H]arpoon file 4' })
        end
    }
}
