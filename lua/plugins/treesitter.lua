return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ensure_installed = {"lua", "python", "javascript", "rust"}, -- Add other languages as needed
    highlight = {
        enable = true,
    },
}
