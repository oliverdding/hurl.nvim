# hurl.nvim

neovim plugin for intergating with [hurl](https://hurl.dev/)

## Install

1. Install `hurl` and make it in your `$PATH`

2. Install neovim plugin

    * with vim-plug

      ```vim
      Plug 'oliverdding/hurl.nvim'
      ```

    * with packer.nvim

      ```lua
      use {"oliverdding/hurl.nvim"}
      ```

    * manaully

      ```bash
      git clone https://github.com/oliverdding/hurl.nvim.git ~/.local/share/nvim/site/pack/hurl.nvim
      ```

## Configuration

I recommend add the mapping to your init file.

```
noremap <leader>p :Glow<CR>
```

or you can manaully execute the hurl by

```vim
:Hurl [path-to-md-file]
```
