local M = {}

-- Default configurations
M.config = {
  create_default_mappings = true, -- whether to create default keymaps
  default_mapping_prefix = "<leader>cp", -- keymaps
  enable_notifications = true, -- whether to notify user after conversion
  exclude_punctuation = {}, -- Punctuations to be converted
  custom_mappings = {}, -- Custom punctuations to be converted
}

-- Mapping from Chinese full-width character to English half-width ones
M.punctuation_map = {
  ["，"] = ",",
  ["。"] = ".",
  ["；"] = ";",
  ["："] = ":",
  ["！"] = "!",
  ["？"] = "?",
  ["（）"] = "()",
  ["【】"] = "[]",
  ["《》"] = "<>",
  ["“”"] = '""',
  ["‘’"] = "''",
  -- ["￥"] = "$", -- Related to currency thus disabled
}

--- Convert text
---@param text string
---@return string
function M.convert_text(text)
  -- Use efficient string replacement by iterating over the punctuation_map once
  for cn_punct, en_punct in pairs(M.punctuation_map) do
    -- Directly replace all occurrences of the full-width punctuation
    text = text:gsub(cn_punct, en_punct)
  end
  return text
end

--- Efficiently convert the buffer, only modifying lines that contain full-width punctuation
function M.convert_buffer()
  local buf = vim.api.nvim_get_current_buf()
  local start_line, end_line = vim.api.nvim_buf_get_mark(buf, "<"), vim.api.nvim_buf_get_mark(buf, ">")
  local lines = vim.api.nvim_buf_get_lines(buf, start_line[1] - 1, end_line[1], false)
  local converted_lines = {}

  -- Efficiently convert only lines that contain full-width punctuation
  for _, line in ipairs(lines) do
    if M.contains_chinese_punctuation(line) then
      table.insert(converted_lines, M.convert_text(line))
    else
      table.insert(converted_lines, line)
    end
  end

  vim.api.nvim_buf_set_lines(buf, start_line[1] - 1, end_line[1], false, converted_lines)

  -- Notify user if enabled
  if M.config.enable_notifications then vim.notify("Chinese punctuation converted!", vim.log.levels.INFO) end
end

--- Check if the line contains any Chinese punctuation
---@param line string
---@return boolean
function M.contains_chinese_punctuation(line)
  for cn_punct, _ in pairs(M.punctuation_map) do
    if line:find(cn_punct) then return true end
  end
  return false
end

--- Add custom mapping
---@param cn_punct string
---@param en_punct string
function M.add_mapping(cn_punct, en_punct)
  -- Directly add the new mapping
  M.punctuation_map[cn_punct] = en_punct
end

--- Check if the character given is included in full-width mappings
---@param char string
---@return boolean
function M.is_chinese_punctuation(char)
  -- Check if the character is in the punctuation map
  return M.punctuation_map[char] ~= nil
end

--- Setup the plugin
---@param config table? configuration
function M.setup(config)
  M.config = vim.tbl_deep_extend("force", M.config, config or {})

  if M.config.create_default_mappings then
    -- Default keymaps
    vim.keymap.set("n", M.config.default_mapping_prefix, function()
      M.convert_buffer()
    end, { desc = "Convert entire buffer" })

    vim.keymap.set("v", M.config.default_mapping_prefix, function()
      M.convert_buffer()
    end, { desc = "Convert selected text" })
  end
end

return M
