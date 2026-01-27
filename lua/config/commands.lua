local write_without_formatting = function(bang)
	vim.g.disable_autoformatting = true
	vim.cmd.write({ bang = bang })
	vim.g.disable_autoformatting = false
end
vim.api.nvim_create_user_command("W", function(table)
	write_without_formatting(table.bang)
end, {
	bang = true,
})
vim.api.nvim_create_user_command("Wq", function(table)
	write_without_formatting(table.bang)
	vim.cmd.quit({ bang = table.bang })
end, {
	bang = true,
})
