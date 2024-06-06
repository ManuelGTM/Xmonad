return {
	"rcarriga/nvim-notify",

	config = function()
		require("notify").setup({
			background_colour = "FloatShadow",
			render = "compact",
			timeout = 1,
		})
	end,
}
