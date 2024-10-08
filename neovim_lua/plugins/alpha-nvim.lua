return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		--[[ ^w^ MeoVim ^w^ ]]
		local meovim = {
			[[             o\             ]],
			[[   _________/__\__________  ]],
			[[  |                  - (  | ]],
			[[ ,'-.                 . `-| ]],
			[[(____".       ,-.    '   || ]],
			[[  |          /\,-\   ,-.  | ]],
			[[  |      ,-./     \ /'.-\ | ]],
			[[  |     /-.,\      /     \| ]],
			[[  |    /     \    ,-.     \ ]],
			[[  |___/_______\__/___\_____\]],
		}
		local greetpan = {
			[[ _____                                ]],
			[[/     \                            こ ]],
			[[vvvvvvv  /|__/|                    ん ]],
			[[   I   /O,O   |                    に ]],
			[[   I /_____   |      /|/|          ち ]],
			[[  J|/^ ^ ^ \  |    /00  |    _//|  は ]],
			[[   |^ ^ ^ ^ |W|   |/^^\ |   /oo |   . ]],
			[[    \m___m__|_|    \m_m_|   \mm_|     ]],
		}
		local catvim = {
			[[                                                      ████                                ]],
			[[                                                      ██░░████                            ]],
			[[                                                      ██░░░░░░██                          ]],
			[[                                                      ██░░░░░░░░██                        ]],
			[[                                                      ██░░░░░░░░░░▓▓░░                    ]],
			[[                                                      ██  ░░░░░░░░░░▓▓░░                  ]],
			[[                                                      ██    ░░░░░░░░░░██                  ]],
			[[                                                      ██    ░░░░░░░░░░░░██                ]],
			[[                                                      ██      ░░░░░░░░░░░░██              ]],
			[[                                                      ██  ░░    ░░░░░░░░░░░░██            ]],
			[[                ░░██████████████████████        ██████████░░      ░░░░░░░░░░██            ]],
			[[                ░░██░░░░░░░░░░░░░░░░░░  ██    ██          ██            ░░░░░░██          ]],
			[[                ░░██  ░░░░░░░░░░░░░░      ████              ████              ██          ]],
			[[                ░░██  ░░░░░░░░░░░░        ██░░                ░░▓▓              ██        ]],
			[[                  ██  ░░░░░░░░░░        ▓▓░░                    ░░▓▓            ██        ]],
			[[                ░░██░░  ░░░░░░░░    ░░██                                        ██        ]],
			[[                ░░▓▓░░  ░░░░░░░░      ▓▓                                        ▓▓░░      ]],
			[[                    ██  ░░  ░░                                                    ██      ]],
			[[                    ██░░                                                          ██      ]],
			[[                    ██░░                                                          ██      ]],
			[[                    ██░░    ░░                                                      ██    ]],
			[[                      ██      ██                                                    ██    ]],
			[[                      ██░░    ██                                                    ██    ]],
			[[                      ██░░    ██                                                    ██    ]],
			[[                      ░░▒▒    ██                                                    ░░▒▒  ]],
			[[                        ▓▓    ██                                                      ██  ]],
			[[                        ▓▓    ██                                                      ██  ]],
			[[                        ▒▒    ██                                                      ██  ]],
			[[                        ░░██  ██                                                      ██  ]],
			[[                            ████                                                      ██  ]],
			[[                              ██                                ████                  ██  ]],
			[[                              ██                              ████                      ██]],
			[[                              ██      ██████                ████        ████            ██]],
			[[                              ██          ██████                      ██                ██]],
			[[                              ██              ██                                        ██]],
			[[                              ██  ██▓▓              ██                  ██            ██  ]],
			[[                              ██  ░░░░▓▓            ░░                  ░░▓▓▓▓      ▓▓░░  ]],
			[[                ░░████████████                                                    ██      ]],
			[[              ██▓▓          ██      ▓▓                                          ██        ]],
			[[          ▓▓▓▓              ██  ▓▓▓▓░░                                        ▓▓░░        ]],
			[[        ▓▓                  ░░██░░░░                                  ▓▓▓▓▓▓▓▓░░          ]],
			[[      ██                        ████            ████████████    ██████    ░░██            ]],
			[[    ██                              ██████    ██░░░░░░░░░░░░████░░░░      ░░██            ]],
			[[    ██                                ██  ████░░░░░░░░░░░░░░░░██░░░░      ░░██            ]],
			[[  ▓▓                                  ██  ██░░░░░░░░░░░░░░░░░░██░░░░  ▓▓██▓▓  ▓▓          ]],
			[[  ██                                  ██  ██░░░░░░░░░░░░░░░░░░░░▓▓▓▓▒▒░░░░░░  ██          ]],
			[[▓▓░░                                ▓▓██▒▒▒▒░░░░░░░░░░░░░░░░░░░░██░░░░        ░░▒▒        ]],
			[[██                                  ▓▓  ██░░░░░░░░░░██░░░░░░░░░░░░██            ██        ]],
			[[  ██                                ▓▓  ██░░░░░░░░██████░░░░░░░░░░██            ██        ]],
			[[    ██                              ▓▓    ██░░░░░░██████░░░░░░░░░░██            ██        ]],
			[[    ░░▓▓                            ▓▓    ██░░░░░░░░██░░░░░░░░░░▓▓░░            ░░██      ]],
			[[      ██                            ▓▓    ▒▒▓▓░░░░░░██░░░░░░░░░░██                ██      ]],
			[[        ██                          ▓▓        ██░░░░██░░░░░░░░██                  ██      ]],
			[[        ██                          ▓▓        ██░░░░██░░░░▓▓██                    ██      ]],
			[[          ▓▓                        ▓▓          ▓▓▓▓██▓▓▓▓                        ██      ]],
			[[          ██░░░░                    ▓▓                                            ██      ]],
			[[            ██░░                  ██                                              ██      ]],
			[[            ██░░░░                ██                                              ██      ]],
			[[              ██░░░░            ░░██                                            ██        ]],
			[[                ▓▓░░░░░░░░░░░░░░░░░░▓▓                                          ██        ]],
			[[                ░░▓▓░░░░░░░░░░░░░░░░▓▓                                        ▓▓░░        ]],
			[[                    ██░░░░░░░░░░░░░░▓▓                                    ████            ]],
			[[                      ██████████████  ██                          ████████                ]],
			[[                      ░░░░░░  ░░░░░░  ░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░                ]],
			[[                                        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                        ]],
			[[                                                                                          ]],
			[[                                                                                          ]],
			[[                                                                                          ]],
			[[                                                                                          ]],
		}

		--[[ #icons ]]
		local icons = {
			autocomplete = {
				Text = "󰦨 ",
				Method = "󰅲 ",
				Function = "󰊕 ",
				Constructor = " ",
				Field = " ",
				Variable = "󰫧 ",
				Class = "󰠱 ",
				Interface = " ",
				Module = " ",
				Property = " ",
				Unit = " ",
				Value = "󰎠 ",
				Enum = " ",
				Keyword = "󰌋 ",
				Snippet = " ",
				Color = "󰏘 ",
				File = "󰈙 ",
				Reference = "",
				Folder = "󰉋",
				EnumMember = " ",
				Constant = "󰏿 ",
				Struct = " ",
				Event = " ",
				Operator = "󰆕 ",
				TypeParameter = " ",
			},
			diagnostics = {
				DiagnosticSignError = "",
				DiagnosticSignWarn = "",
				DiagnosticSignInfo = "",
				DiagnosticSignHint = "󰌵 ",
			},
			dashboard = {
				NewFile = "󰝒",
				FindFile = "󰱼",
				FindText = "󱎸",
				RestoreSession = "󰁯",
				Settings = "",
				Quit = "󰄛",
			},
			statusline = { "", "", "╲", "╱" },
			-- statusline = { "", "", "╲╲", "╲╲" },
			-- statusline = { "▓▒░", "░▒▓", "░", "░" },
		}
		local alpha_th = require("alpha.themes.theta")
		local alpha_db = require("alpha.themes.dashboard")
		local alpha_time = tostring(os.date("%A %I:%M %p"))
		alpha_th.header.val = greetpan
		alpha_th.buttons.val = {
			{
				type = "text",
				val = "╭" .. string.rep("─", 48 - string.len(alpha_time)) .. alpha_time .. "╮",
				opts = { hl = "FloatBorder", position = "center" },
			},
			alpha_db.button("e", icons.dashboard.NewFile .. "  New file", ":ene <BAR> startinsert <CR>"),
			alpha_db.button("f", icons.dashboard.FindFile .. "  Find file", ":Telescope find_files <CR>"),
			alpha_db.button("g", icons.dashboard.FindText .. "  Find text", ":Telescope live_grep <CR>"),
			alpha_db.button("r", icons.dashboard.RestoreSession .. "  Restore session", ":lua SessionLoad() <CR>"),
			alpha_db.button("s", icons.dashboard.Settings .. "  Settings", ":e ~/.config/nvim/init.lua<CR>"),
			alpha_db.button("q", icons.dashboard.Quit .. "  Quit", ":qa<CR>"),
			{
				type = "text",
				val = "╰" .. string.rep("─", 48) .. "╯",
				opts = { hl = "FloatBorder", position = "center" },
			},
		}
		require("alpha").setup(alpha_th.config)
	end,
}
