return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_ignored = true,
        hide_by_name = {
          "node_modules",
          ".git",
        },
      },
    },
  },
}
