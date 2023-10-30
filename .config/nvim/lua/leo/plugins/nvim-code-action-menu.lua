return {
  {
    "weilbith/nvim-code-action-menu",
    keys = {
      { "ga", "<cmd>CodeActionMenu<cr>" },
    },
    init = function()
      vim.g.code_action_menu_window_border = "rounded"
      vim.g.code_action_menu_show_action_kind = false
      vim.g.code_action_menu_show_details = false
    end,
  },
}
