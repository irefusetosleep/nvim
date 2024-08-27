return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ensure_installed = {"javascript", "lua", "rust", "luau", "csharp_ls"},
    highlight = {
        enable = true,
    },
}
