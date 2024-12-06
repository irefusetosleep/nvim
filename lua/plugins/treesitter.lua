return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ensure_installed = {"html", "css", "javascript", "lua_ls", "rust", "luau", "csharp_ls"},
    highlight = {
        enable = true,
    },
}
