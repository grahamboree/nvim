return {
    -- Edit the filesystem like a buffer. Replaces netrw.
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- must load at startup to take over directory buffers
    opts = {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
            show_hidden = true,
        },
    },
    keys = {
        { "<leader>pv", "<cmd>Oil<cr>", desc = "File explorer (parent dir)" },
        { "-",          "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
}
