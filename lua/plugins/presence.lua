return {
  "andweeb/presence.nvim",
  config = function()
    require("presence").setup({
      main_image = "file",
      auto_update = true,

      editing_text = "Editing %s",
      workspace_text = "Working on %s",
      line_number_text = "Line %l out of %L",

    })
  end
}
