th.git = th.git or {}
th.git.modified = ui.Style():fg("blue")
th.git.deleted = ui.Style():fg("red"):bold()
th.git.unknown_sign = " "
th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.clean_sign = "✔"

require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}

require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}

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

  branch_borders = "{}",
  branch_prefix = "|",
  branch_color = "#7aa2f7",
  remote_branch_color = "#9ece6a",
  always_show_remote_branch = true,
  always_show_remote_repo = true,

  tag_symbol = "󰓼",
  always_show_tag = true,
  tag_color = "#bb9af7",

  commit_symbol = "",
  always_show_commit = true,
  commit_color = "#e0af68",

  staged_color = "#73daca",
  staged_symbol = "●",

  unstaged_color = "#e0af68",
  unstaged_symbol = "✗",

  untracked_color = "#f7768e",
  untracked_symbol = "?",

  state_color = "#f5c359",
  state_symbol = "󱐋",

  stashes_color = "#565f89",
  stashes_symbol = "⚑",
})
