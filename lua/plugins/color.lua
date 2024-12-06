-- example lazy.nvim install setup
return {
  "slugbyte/lackluster.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("lackluster")
    -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
    -- vim.cmd.colorscheme("lackluster-mint")

    require('lualine').setup({
      options = {
        theme = "lackluster",
      },
    })
  end,
}
