local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")
local make_entry = require("telescope.make_entry")

local M = {}

M.messages = function(opts)
  opts = opts or {}

  local messages_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(
    messages_bufnr,
    0,
    -1,
    false,
    vim.split(vim.api.nvim_exec2("messages", { output = true }).output, "\n")
  )
  vim.api.nvim_set_option_value("buftype", "nofile", { scope = "local", buf = messages_bufnr }) -- No file associated
  vim.api.nvim_set_option_value("bufhidden", "wipe", { scope = "local", buf = messages_bufnr }) -- Wipe from memory when abandoned
  vim.api.nvim_set_option_value("modifiable", false, { scope = "local", buf = messages_bufnr }) -- Make it unmodifiable
  vim.api.nvim_set_option_value("swapfile", false, { scope = "local", buf = messages_bufnr }) -- Don't create a swap file

  local lines = vim.api.nvim_buf_get_lines(messages_bufnr, 0, -1, false)
  local lines_with_numbers = {}

  for lnum, line in ipairs(lines) do
    table.insert(lines_with_numbers, {
      lnum = lnum,
      bufnr = messages_bufnr,
      text = line,
    })
  end
  local original_win = vim.api.nvim_get_current_win()
  local original_buf = vim.api.nvim_get_current_buf()

  pickers
    .new(opts, {
      prompt_title = "Messages",
      finder = finders.new_table({
        results = lines_with_numbers,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.text,
            ordinal = entry.text,
            lnum = entry.lnum,
            bufnr = entry.bufnr,
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
      previewer = conf.grep_previewer(opts),
      attach_mappings = function()
        action_set.select:enhance({
          post = function()
            local selection = action_state.get_selected_entry()
            if not selection then
              return
            end

            vim.cmd("split")
            local win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_buf(win, messages_bufnr)
            vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
            vim.api.nvim_win_set_buf(original_win, original_buf)
          end,
        })
        return true
      end,
    })
    :find()
end

M.messages()

return M
