return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>l",  group = "LSP" },
            { "<leader>lw", group = "workspace" },
            { "<leader>lr", group = "rename/references" },
            { "<leader>p",  group = "find/files" },
            { "<leader>x",  group = "diagnostics" },
            { "<leader>v",  group = "diagnostics nav" },
        },
    },
}
