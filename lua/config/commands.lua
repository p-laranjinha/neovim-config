-- write without formatting
vim.api.nvim_create_user_command("W", function(table)
	vim.g.disable_autoformatting = true
	vim.cmd.write({ bang = table.bang })
	vim.g.disable_autoformatting = false
end, {
	bang = true,
})
