return {
  "andweeb/presence.nvim",
  config = function()
    require("presence").setup({
      main_image = "file",
      neovim_image_text = "ball fart",
      buttons = true,
      log_level = nil,

      state = function()
        return vim.fn.getcwd()
      end,

      details = function()
        local filename = vim.fn.expand('%:t')
        local filetype = vim.bo.filetype
        return filename ~= "" and filename .. " (" .. filetype .. ")" or "No file open"
      end,

      large_image_text = "ball fart"
    })
  end
}
