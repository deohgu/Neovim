-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Change inner word without yanking
map("n", "ciw", '"_ciw', { desc = "Change inner word without yanking" })
