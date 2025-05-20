local options = {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "make",
        "fish",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false, -- Disable legacy regex highlighting
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
