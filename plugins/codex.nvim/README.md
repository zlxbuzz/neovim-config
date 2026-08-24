# codex.nvim

Neovim bridge for the Codex CLI.

## Features

- Open an interactive Codex CLI session from Neovim.
- Send visual selections or prompts to Codex.
- Include the current file path automatically for `:CodexAsk`.
- Run `codex exec -` and write output to a scratch buffer.
- Start `codex review --uncommitted`.
- Collect current file metadata, diagnostics, current-file git diff, and buffer content for fix prompts.

## Setup

When used from this Neovim config, `lua/plugins/codex.lua` adds this directory
to `runtimepath` and calls:

```lua
require("codex").setup({
  no_alt_screen = true,
  terminal = {
    provider = "float",
    width = 0.72,
    height = 0.75,
    border = "rounded",
    close_on_exit = true,
    close_existing = true,
    title = " 󰚩 Codex ",
    zindex = 80,
  },
})
```

Standalone plugin usage:

```lua
require("codex").setup({
  command = "codex",
  env = {
    OPENAI_API_KEY = vim.env.OPENAI_API_KEY,
  },
  cwd = "git_root",
  no_alt_screen = true,
  terminal = {
    provider = "float",
    width = 0.72,
    height = 0.75,
    border = "rounded",
    close_on_exit = true,
    close_existing = true,
    title = " 󰚩 Codex ",
    zindex = 80,
  },
})
```

`width` and `height` accept ratios between `0` and `1`, or fixed cell counts.
`close_on_exit` closes the Codex terminal window after the CLI exits.
`close_existing` keeps only one Codex floating terminal open at a time.
`env` is passed to both interactive terminal sessions and `codex exec`.
Prefer reading secrets from environment variables instead of hard-coding keys in
this repository.

## Commands

- `:Codex [prompt]`
- `:CodexAsk [prompt]`
- `:'<,'>CodexAskSelection`
- `:CodexExplain`
- `:CodexFix`
- `:CodexReview [prompt]`
- `:CodexExec [prompt]`
- `:CodexApply`
- `:CodexClose`

Close the floating terminal with `<C-q>`, `<Esc><Esc>`, `:CodexClose`, or the
Neovim config keymap `<leader>ic`.
