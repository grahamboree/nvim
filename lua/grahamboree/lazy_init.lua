local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- bootstrap lazy 
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "grahamboree.lazy",
    -- automatically check for plugin updates, but do not pop a notification
    checker = { enabled = true, notify = false },
    -- no plugin needs luarocks; skip the hererocks bootstrap and its health warnings
    rocks = { enabled = false },
})
