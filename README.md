# Neovim config

Requires Neovim 0.12 or newer (roslyn.nvim needs 0.12).

## External tools

Plugins are installed by lazy.nvim and language servers by Mason on first
launch. These must already be on `PATH`:

```sh
brew install neovim ripgrep fd tree-sitter-cli clang-format dotnet
```

| Tool | Used by |
|---|---|
| `rg`, `fd` | Telescope file finding and live grep |
| `tree-sitter` | nvim-treesitter, to compile parsers (needs a C compiler too) |
| `clang-format` | conform, for C and C++ |
| `dotnet` | the Roslyn C# language server |
| `make`, `cc` | building telescope-fzf-native and treesitter parsers |

Mason installs the rest on startup via mason-tool-installer: clangd,
lua-language-server, roslyn-language-server and stylua.

### Windows

Clone to `%LOCALAPPDATA%\nvim` instead. The same tools come from winget:

```powershell
winget install Neovim.Neovim BurntSushi.ripgrep.MSVC sharkdp.fd LLVM.LLVM Microsoft.DotNet.SDK.10 Kitware.CMake
```

LLVM provides both `clang-format` and the C compiler treesitter needs.
Two more things are required:

- the `tree-sitter` CLI, from its GitHub releases or `cargo install
  tree-sitter-cli`, on `PATH`
- the Microsoft C++ Build Tools, which CMake uses to build
  telescope-fzf-native

The config picks the right build command and clangd compiler globs by
checking `jit.os`, so nothing needs editing. On Windows the shell is set to
pwsh (or Windows PowerShell if pwsh is absent) rather than cmd.exe, so `:!`,
`:terminal` and the `p4 edit` autocmd behave like a modern shell. `p4.exe`
must be on `PATH`.

## First launch

1. Clone to `~/.config/nvim` and start `nvim`.
2. lazy.nvim bootstraps itself and installs every plugin pinned in
   `lazy-lock.json`.
3. Treesitter compiles its parsers and Mason installs its tools in the
   background. Restart once they finish.

## Layout

```
init.lua                    entry point, requires grahamboree
lua/grahamboree/
  init.lua                  autocmds, LSP attach keymaps, diagnostics, colorscheme
  set.lua                   options
  remap.lua                 keymaps that do not belong to a plugin
  utils.lua                 helpers (window maximize, source/header switch)
  lazy_init.lua             lazy.nvim bootstrap
  lazy/*.lua                one plugin spec per file
after/lsp/<server>.lua      per-server LSP settings
```

## Notes

- Per-server LSP config lives in `after/lsp/` rather than `lsp/`. Neovim
  merges `lsp/<name>.lua` files in runtimepath order with later files
  winning, and the config directory comes first, so a top-level
  `lsp/clangd.lua` loses its `cmd` to nvim-lspconfig's copy. `after/` is
  last and wins.
- `after/lsp/roslyn.lua` sets `DOTNET_ROOT` from whichever `dotnet` is on
  `PATH`. Without it the Mason-installed server can pick up a stale
  install under `/usr/local/share/dotnet` and refuse to start.
- Neovim's own LSP mappings are used where they exist: `grn` rename,
  `gra` code action, `grr` references, `gri` implementation, `gO` document
  symbols, `K` hover, `<C-W>d` line diagnostics. `<leader>l…` covers the
  rest; press `<leader>` and wait for which-key.
