return {
  "rcarriga/nvim-notify",
  opts = {
    timeout = 500,
    render = "compact",
  },
  config = function()
    vim.cmd([[highlight NotifyInfoIcon guifg=#3388FF]])
    vim.cmd([[highlight NotifyInfoTitle guifg=#3388FF]])
  end,
}
