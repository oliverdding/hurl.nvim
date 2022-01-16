# hurl.nvim

neovim plugin for intergating with [hurl](https://hurl.dev/)

EA stage: There are many [arguments](https://hurl.dev/docs/man-page.html) for hurl, and I have no good idea how to deal with it right now...

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
noremap <leader>p :Hurl<CR>
```

or you can manaully execute the hurl by

```vim
:Hurl [path-to-hurl-file]
```

## Inspiration

Thanks to [glow.nvim](https://github.com/ellisonleao/glow.nvim)
