-- example lazy.nvim install setup
return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("kanagawa")
    -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
    -- vim.cmd.colorscheme("lackluster-mint")

    require('lualine').setup({
      options = {
        theme = "kanagawa",
      },
    })
  end,
}
