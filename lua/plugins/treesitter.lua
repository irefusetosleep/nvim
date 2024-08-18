return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ensure_installed = {"javascript", "lua", "rust"},
    highlight = {
        enable = true,
    },
}
