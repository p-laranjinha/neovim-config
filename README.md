# neovim-config

This config was heavily inspired by [radleylewis's nvim repo](https://github.com/radleylewis/nvim) which includes a 3 part youtube tutorial ([Part 1: Install, Keymaps, Lazy & Plugins](https://www.youtube.com/watch?v=cdAMq2KcF4w); [Part 2: LSP, Linters, Formatters, AI Assist & Completion](https://www.youtube.com/watch?v=qp1OcolI6x0); [Part 3: TMUX, Git & Debugging](https://www.youtube.com/watch?v=JN4Zbs0ypwM)).

I've also gotten help with defining keymaps from [LazyVim](https://www.lazyvim.org/keymaps).

Additionally, I've taken from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim/blob/3338d3920620861f8313a2745fd5d2be39f39534/lua/kickstart/plugins/debug.lua), [ThePrimeagen's config](https://github.com/ThePrimeagen/init.lua/blob/46e2a614548c5d76206e5028a55b49d0a92aac42/lua/theprimeagen/lazy/dap.lua), and [LazyVim](https://github.com/LazyVim/LazyVim/blob/c64a61734fc9d45470a72603395c02137802bc6f/lua/lazyvim/plugins/extras/dap/core.lua) to setup DAP.

## How to add an LSP/formatter/linter

1. Find what you want to want in Mason and add it to [./lua/servers/init.lua](./lua/servers/init.lua).
2. If it's an LSP:
   - Add a file to [./lua/servers/](./lua/servers/) with the correct information and import it in
     [./lua/servers/init.lua](./lua/servers/init.lua).
     - Usually you can just copy from another in that folder with just the capabilities and
       filetypes, and modify it slightly.
3. If it's a formatter/linter:
   - Add a **require** and a language in [./lua/servers/efm-langserver.lua](./lua/servers/efm-langserver.lua).
     - Find possible requires at [https://github.com/creativenull/efmls-configs-nvim/blob/main/doc/SUPPORTED_LIST.md](https://github.com/creativenull/efmls-configs-nvim/blob/main/doc/SUPPORTED_LIST.md).
     - Find possible languages at [https://github.com/neovim/neovim/blob/master/runtime/lua/vim/filetype.lua](https://github.com/neovim/neovim/blob/master/runtime/lua/vim/filetype.lua).
