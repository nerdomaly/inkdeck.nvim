-- Live word count + battery percentage in the statusline. Battery
-- matters here specifically because zen/focus mode fills the whole
-- screen, hiding the OS battery indicator while deep in a session.

local WARN_PCT = 30
local CRIT_PCT = 15

local M = {}

function M.word_count()
  return string.format("%d words", vim.fn.wordcount().words)
end

-- Fg-only groups (no reverse video) so a low battery reads as a color
-- shift, not an alert box. Linked to Diagnostic groups since those are
-- defined consistently across modern colorschemes, including any the
-- user swaps colorscheme.lua to.
local function link_battery_highlights()
  vim.api.nvim_set_hl(0, "InkdeckBatteryWarn", { link = "DiagnosticWarn", default = true })
  vim.api.nvim_set_hl(0, "InkdeckBatteryCrit", { link = "DiagnosticError", default = true })
end
link_battery_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = link_battery_highlights })

local battery_str = ""

local function read_first_line(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local line = f:read("l")
  f:close()
  return line
end

local function update_battery()
  local bat_dir = vim.fn.glob("/sys/class/power_supply/BAT*", false, true)[1]
  if not bat_dir then
    battery_str = ""
    return
  end
  local capacity = tonumber(read_first_line(bat_dir .. "/capacity"))
  if not capacity then
    battery_str = ""
    return
  end
  local charging = read_first_line(bat_dir .. "/status") == "Charging"

  local icon = "🔋"
  if charging then
    icon = "⚡"
  elseif capacity < CRIT_PCT then
    icon = "🪫"
  end

  local hl = ""
  if capacity < CRIT_PCT then
    hl = "%#InkdeckBatteryCrit#"
  elseif capacity < WARN_PCT then
    hl = "%#InkdeckBatteryWarn#"
  end
  local reset = hl ~= "" and "%*" or ""

  -- Goes through the %{%...%} recursive statusline form (for %#hl#
  -- switching), so a literal "%" has to be doubled here or the
  -- re-parse eats it.
  battery_str = string.format("%s%s %d%%%%%s", hl, icon, capacity, reset)
end

function M.battery()
  return battery_str
end

update_battery()
local timer = vim.uv.new_timer()
if timer then
  timer:start(0, 30000, vim.schedule_wrap(update_battery))
end

vim.opt.statusline = table.concat({
  "%f",
  "%m",
  "%=",
  "%{v:lua.require('config.statusline').word_count()}",
  "  ",
  "%{%v:lua.require('config.statusline').battery()%}",
  "  %l:%c",
})

return M
