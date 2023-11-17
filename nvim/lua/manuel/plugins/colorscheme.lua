return {

	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				style = "storm",
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},
	vim.api.nvim_set_hl(0, "lineNr", { fg = "orange" }),
}

--transparent color settings
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--end,
-- }
