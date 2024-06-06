require("manuel.core.options")
require("manuel.core.keymap")
require("manuel.core.providers")
require("manuel.lazy")

--nvim colors
vim.api.nvim_set_hl(0, "lineNr", { fg = "#fab387" })

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.pug = {
	install_info = {
		url = "~/.config/Parsers/tree-sitter-pug",
		files = { "src/parser.c" },
		branchs = "main",
		generate_requires_npm = false,
		requires_generate_from_grammar = true,
	},
	filetype = "pug",
}
