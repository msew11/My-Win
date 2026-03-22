th.git = th.git or {}
th.git.modified = ui.Style():fg("yellow")
th.git.deleted = ui.Style():fg("red")
th.git.added = ui.Style():fg("green")
th.git.untracked = ui.Style():fg("magenta")
th.git.ignored = ui.Style():fg("gray")

th.git.unknown_sign = " "
th.git.modified_sign = " "
th.git.deleted_sign = " "
th.git.added_sign = " "
th.git.untracked_sign = " "
th.git.ignored_sign = " "
th.git.clean_sign = ""

-- 官方 Git 插件：显示文件列表右侧状态 (Linemode)
require("git"):setup {
	order = 1500,
}

-- Githead 插件：显示顶部 Header 的分支和详细统计
require("githead"):setup({
  order = {
    "__spacer__",
    "stashes",
    "__spacer__",
    "state",
    "__spacer__",
    "staged",
    "__spacer__",
    "unstaged",
    "__spacer__",
    "untracked",
    "__spacer__",
    "branch",
    "remote_branch",
    "__spacer__",
    "tag",
    "__spacer__",
    "commit",
    "__spacer__",
    "behind_ahead_remote",
    "__spacer__",
  },
  branch_borders = "()",
  branch_prefix = "on ",
  branch_symbol = " ",
  branch_color = "#7aa2f7",
  remote_branch_color = "#9ece6a",
  always_show_remote_branch = true,
  always_show_remote_repo = true,

  tag_symbol = "󰓼 ",
  always_show_tag = true,
  tag_color = "#bb9af7",

  commit_symbol = " ",
  always_show_commit = true,
  commit_color = "#e0af68",

  staged_color = "#73daca",
  staged_symbol = " ",

  unstaged_color = "#e0af68",
  unstaged_symbol = " ",

  untracked_color = "#f7768e",
  untracked_symbol = " ",

  state_color = "#f5c359",
  state_symbol = "󱐋 ",

  stashes_color = "#565f89",
  stashes_symbol = "⚑ ",
})

-- 全边框 UI
require("full-border"):setup {
	type = ui.Border.ROUNDED,
}
