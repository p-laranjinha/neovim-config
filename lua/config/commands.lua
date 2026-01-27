local write_without_formatting = function(bang)
	if not vim.g.autoformat then
		vim.cmd.write({ bang = bang })
	else
		vim.g.autoformat = false
		vim.cmd.write({ bang = bang })
		vim.g.autoformat = true
	end
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
