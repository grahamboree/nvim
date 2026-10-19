return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        -- Root of the dotnet install that the `dotnet` on PATH belongs to.
        -- Homebrew puts the launcher in bin/ and the runtime in libexec/.
        local function dotnet_root()
            if vim.env.DOTNET_ROOT then return vim.env.DOTNET_ROOT end
            local exe = vim.fn.resolve(vim.fn.exepath("dotnet"))
            if exe == "" then return nil end
            for _, dir in ipairs({ vim.fn.fnamemodify(exe, ":h"), vim.fn.fnamemodify(exe, ":h:h") .. "/libexec" }) do
                if vim.fn.isdirectory(dir .. "/shared/Microsoft.NETCore.App") == 1 then return dir end
            end
        end

        local cmp = require("cmp")

        require("fidget").setup({
            notification = {
                override_vim_notify = true,
            },
        })

        -- Server configuration uses the native vim.lsp.config API (Neovim 0.11+).
        -- mason-lspconfig v2 calls vim.lsp.enable() for every installed server,
        -- so anything set here is picked up when the server attaches.

        -- Shared across all servers: advertise nvim-cmp's completion capabilities.
        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        vim.lsp.config("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--query-driver=/usr/bin/c++,/usr/bin/cc,/usr/bin/clang,/usr/bin/clang++",
                "--inlay-hints=true",
            },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                    },
                },
            },
        })

        vim.lsp.config("roslyn", {
            -- Mason's apphost otherwise picks the old /usr/local/share/dotnet install
            cmd_env = { DOTNET_ROOT = dotnet_root() },
            settings = {
                ["csharp|inlay_hints"] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                    csharp_enable_inlay_hints_for_types = true,
                    dotnet_enable_inlay_hints_for_parameters = true,
                },
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                },
                ["csharp|background_analysis"] = {
                    dotnet_analyzer_diagnostics_scope = "openFiles",
                    dotnet_compiler_diagnostics_scope = "openFiles",
                },
            },
        })

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
            },
            -- roslyn.nvim manages the Roslyn server itself; stop mason-lspconfig
            -- from also enabling nvim-lspconfig's roslyn_ls for the same binary.
            automatic_enable = {
                exclude = { "roslyn_ls" },
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                -- Neovim's built-in snippet engine handles LSP snippets.
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<up>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<down>"] = cmp.mapping.select_next_item(cmp_select),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                -- Tab confirms a completion, or jumps to the next snippet tabstop.
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    elseif vim.snippet.active({ direction = 1 }) then
                        vim.snippet.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if vim.snippet.active({ direction = -1 }) then
                        vim.snippet.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }),
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
        })
    end,
}
