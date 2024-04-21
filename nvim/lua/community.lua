-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- MyConfig

  -- PACK
  -- # Normal Languages
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.typescript" },
  -- # Text Languages
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.markdown" },
  -- # Configuration Languages
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.json" },
  -- # Frameworks and Tools
  { import = "astrocommunity.pack.docker" },
  -- { import = "astrocommunity.pack.vue" }

  -- COMPLETION
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- THEME
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },

  -- UTILITY
  { import = "astrocommunity.utility.noice-nvim" },

  -- RECIPES
  { import = "astrocommunity.recipes.heirline-nvchad-statusline" }, -- Must after nocie-nvim, otherwise the heirline will have duplicated LSP components.
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  -- { import = "astrocommunity.recipes.vscode-icons" },
}
