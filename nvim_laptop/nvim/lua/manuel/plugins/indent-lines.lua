return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "|",
			highlight = "Function",
			smart_indent_cap = true,
			priority = 1,
		},

		whitespace = {
			highlight = {
				"Whitespace",
				"NonText",
			},
		},

		scope = {
			enabled = false,
		},
	},
}
