# telescope-messages.nvim

[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) picker for `:messages`, similar to `:Telescope help_tags`.

## Setup

Using [lazy](https://github.com/folke/lazy.nvim):

```lua
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "d4wns-l1ght/telescope-messages.nvim",
    },
    config = function()
        require("telescope").setup({})
        require("telescope").load_extension("messages")
    end,
}
```

## Usage

`:Telescope messages` or `require("telescope").extensions.messages.messages()`

## Similar plugins

If you just want to get `:messages` (or the output of any other command) into a buffer, you can check out [bufferize.vim](https://github.com/AndrewRadev/bufferize.vim)
