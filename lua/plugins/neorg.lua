return {
	"nvim-neorg/neorg",
	dependencies = {
		{ "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
		--"juniorsundar/neorg-extras",
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = {
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {},
			["core.qol.toc"] = {},
			["core.export"] = {},
			["core.presenter"] = { config = {zen_mode = "zen-mode" }},
			["core.tangle"] = {},
			["core.summary"] = {},
			["core.export.markdown"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/notes/notes",
						work = "~/notes/work",
						aws = "~/curso/aws",
					},
					default_workspace = "notes",
				},
			},
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			},
			["core.integrations.nvim-cmp"] = {},
			["core.journal"] = {
				config = {
					strategy = "flat",
				},
			},
			--[[["external.templates"] = {
				config = {
					default_subcommand = "load",
				},
			},
			["external.many-mans"] = {
				config = {
					treesitter_fold = true,
				},
			},
			["external.agenda"] = {},
			["external.roam"] = {
				config = {
					fuzzy_finder = "Telescope",
				},
			},]]--
		},
	},
	keys = {
		{
			"<leader>no",
			"<cmd>Neorg index<cr>",
			desc = "Neorg: Open index",
		},
		{
			"<leader>nr",
			"<cmd>Neorg return<cr>",
			desc = "Neorg: return",
		},
	},
	cmd = "Neorg",
}
