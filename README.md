# cpc.nvim - Chinese Punctuation Conversion for Neovim

[![Neovim 0.7+](https://img.shields.io/badge/Neovim-0.7.0+-blue)](https://neovim.io)
[![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<!-- [![Latest Release](https://img.shields.io/github/v/release/YOUR_USERNAME/cpc.nvim)](https://github.com/YOUR_USERNAME/cpc.nvim/releases) -->

## 🛠 Requirements ->

- **Neovim**: 0.7.0 or higher
- **Lua**: 5.1 or higher (included with Neovim)
- **Dependencies**: None (pure Lua implementation)

## ✨ Features

- 🔄 **One-click Conversion**: Quickly convert Chinese full-width punctuation to English half-width
- 🎯 **Accurate Conversion**: Covers all common Chinese punctuation marks
- 📝 **Smart Recognition**: Supports whole buffer or selected region conversion
- ⚡ **Zero Latency**: Built with native Lua, no external dependencies
- 🔧 **Highly Configurable**: Supports custom mappings and extended rules
- 📊 **Real-time Feedback**: Instant notifications after operation

## 📦 Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "AzarAI-TOP/cpc.nvim",
    opts = {}
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "AzarAI-TOP/cpc.nvim",
    config = function()
        require("cpc").setup({
            -- Optional configuration
        })
    end
}
```

### Manual Installation

```bash
cd ~/.local/share/nvim/site/pack/git-plugins/start
git clone https://github.com/AzarAI-TOP/cpc.nvim.git
```

## 🚀 Quick Start

```vim
" Convert Chinese punctuation in entire buffer
:ChinesePunctuationConvert

" Or use the shorter command
:CPC
```

## ⚙️ Configuration

the following is the default configuration:

```lua
{
    -- Whether to create default key mappings (default: true)
    create_default_mappings = true,

    -- Default key mapping prefix (default: "<leader>cp")
    default_mapping_prefix = "<leader>cp",

    -- Enable notifications after conversion (default: true)
    enable_notifications = true,

    -- Custom punctuation mapping rules
    custom_mappings = {
        -- Add or override mapping rules
        -- ["Chinese_punctuation"] = "English_punctuation"
    },

    -- Whether to convert full-width space (default: true)
    convert_fullwidth_space = true,

    -- Punctuation to exclude from conversion (default: {})
    exclude_punctuation = {}, -- Example: {"!", "?"} to keep exclamation and question marks
}
```

### Key Mappings

Default key mappings:

| Mode    | Shortcut     | Description                           |
| ------- | ------------ | ------------------------------------- |
| Normal  | `<leader>cp` | Convert entire buffer                 |
| Visual  | `<leader>cp` | Convert selected text                 |
| Command | `:CPC`       | Convert entire buffer (command alias) |

Custom key mappings:

```lua
-- Add custom mappings after setup
vim.keymap.set("n", "<leader>tc", "<cmd>ChinesePunctuationConvert<CR>", { desc = "Convert Chinese punctuation" })
vim.keymap.set("v", "<leader>tc", ":<C-U>call cpc#visual_conversion()<CR>", { desc = "Convert selected punctuation" })
```

## 📖 Commands

| Command                      | Alias           | Description                                  |
| ---------------------------- | --------------- | -------------------------------------------- |
| `:ChinesePunctuationConvert` | `:CPC`          | Convert entire buffer                        |
| `:CPCVisual`                 | None            | Convert selected region (use in visual mode) |
| `:CPCAddMapping`             | <chinese_punct> | <english_punct> None Add custom mapping      |
| `:CPCShowMappings`           | None            | Show all current mapping rules               |

## 🔧 Advanced Usage

### Add Custom Punctuation Mapping

```vim
" Add custom punctuation conversion rule
:CPCAddMapping § $

" Or add in Lua configuration
require("cpc").add_mapping("§", "$")
```

### View Current Mapping Rules

```vim
" View all punctuation mapping rules
:CPCShowMappings
```

### Convert Only Specific File Types

```lua
-- Use in autocmd
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.md", "*.txt" },
    callback = function()
        require("cpc").convert_buffer()
    end,
})
```

### Programmatic Usage

```lua
local cpc = require("cpc")

-- Convert entire buffer
cpc.convert_buffer()

-- Convert specific text
local text = "This is Chinese text,with full-width punctuation!"
local converted = cpc.convert_text(text)
print(converted) -- Output: "This is Chinese text,with full-width punctuation!"

-- Add custom mapping
cpc.add_mapping("※", "*")

-- Check if character is Chinese punctuation
local is_cn_punct = cpc.is_chinese_punctuation(",") -- true
```

## 📊 Supported Punctuation Conversion

| Chinese Punctuation | English Punctuation | Description            |
| ------------------- | ------------------- | ---------------------- |
| `,`                 | `,`                 | Comma                  |
| `.`                 | `.`                 | Full stop              |
| `;`                 | `;`                 | Semicolon              |
| `:`                 | `:`                 | Colon                  |
| `!`                 | `!`                 | Exclamation mark       |
| `?`                 | `?`                 | Question mark          |
| `()`                | `()`                | Parenthesis            |
| `[]`                | `[]`                | Square bracket         |
| `<>`                | `<>`                | Angle bracket          |
| `,`                 | `,`                 | Enumeration comma      |
| `“”`                | `""`                | Double quotation mark  |
| `‘’`                | `''`                | Single quotation mark  |
| `￥`                | `$`                 | Dollar sign (Disabled) |
