--vim.cmd "colorscheme base16-eighties"

local colorscheme = "base16-eighties"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
