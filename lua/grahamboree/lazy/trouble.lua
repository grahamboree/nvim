return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (project)" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
        { "<leader>xs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols" },
        { "<leader>xl", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP definitions / references" },
    },
}
