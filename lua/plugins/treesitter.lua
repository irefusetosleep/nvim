return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    highlight = {
        enable = true,
    },
}
