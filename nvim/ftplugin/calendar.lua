---@diagnostic disable: undefined-global
for lhs, rhs in pairs({
	["<c-e>"] = "<c-^>",
	["<cr>"] = function()
		local ymd = vim.api.nvim_eval("b:calendar.day().get_ymd()")
		local date = string.format("%d-%02d-%02d", ymd[1], ymd[2], ymd[3])
		vim.fn["wiki#journal#open"](date)
	end,
}) do
	vim.keymap.set("n", lhs, rhs, { buffer = true })
end
