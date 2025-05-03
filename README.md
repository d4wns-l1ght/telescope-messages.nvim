# telescope-messages.nvim

Telescope picker for `:messages`, similar to `help_tags`.

## setup

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
