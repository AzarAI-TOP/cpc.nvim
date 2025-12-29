-- Version limitation
if 1 ~= vim.fn.has("nvim-0.7") then
  error("cpc.nvim requires at least nvim-0.7.")
  return
end

-- Only load once
if vim.g.loaded_cpc == 1 then return end
vim.g.loaded_cpc = 1

local cpc = require("cpc")
-- Create the 'ChinesePunctuationConvert'('CPC' for short) command to trigger the conversion
vim.api.nvim_create_user_command(
  "CPC",
  cpc.convert_buffer,
  { desc = "Convert Chinese full-width punctuation to half-width in the entire buffer" }
)

vim.api.nvim_create_user_command(
  "ChinesePunctuationConvert",
  cpc.convert_buffer,
  { desc = "Convert Chinese full-width punctuation to half-width in the entire buffer" }
)
