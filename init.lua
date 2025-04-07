-- this is required for setting space as leader for some reason
vim.g.mapleader = " "

require("config.globals")
require("config.lazy")
require("config.keymap")

function valid_buf(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
    return
  end

  local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
  if buftype ~= "" then
    return
  end

  local modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
  if not modifiable then
    return
  end

  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return
  end

  return true
end

vim.api.nvim_create_autocmd("TextChanged", {
  callback = function(params)
    local buf = params.buf
    if valid_buf(buf) then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("write")
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "i:n",
  callback = function(params)
    local buf = params.buf
    if valid_buf(buf) then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("write")
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})
