return {
	"hrsh7th/nvim-cmp",
	dependencies = { "onsails/lspkind.nvim", "nvim-tree/nvim-web-devicons" },
	event = { "InsertEnter", "BufEnter", "BufReadPre", "BufNewFile" },
	config = function()
		-- require("matheusq.snippets")

		vim.opt.completeopt = { "menu", "menuone", "noselect" }
		vim.opt.shortmess:append("c")

		local lspkind = require("lspkind")
		lspkind.init({})

		local cmp = require("cmp")

		local max_items = 5
		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp", keyword_length = 1, max_item_count = max_items },
				{ name = "buffer", keyword_length = 3, max_item_count = max_items },
				{ name = "luasnip", keyword_length = 2, max_item_count = max_items },
			},
			mapping = {
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-y>"] = cmp.mapping(
					cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					{ "i", "c" }
				),
			},

			window = {
				completion = {
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					col_offset = -3,
					side_padding = 0,
					max_items = 10,
				},
			},
			completion = {
				completeopt = "menu,menuone,noinsert", -- Customize 'completeopt' as needed
				keyword_length = 1, -- Minimum length of the word to trigger completion
				max_items = 10,
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					-- Add lspkind formatting
					local kind = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					})(entry, vim_item)

					-- Add nvim-web-devicons
					local icons = require("nvim-web-devicons")
					local icon, hl_group = icons.get_icon(entry:get_completion_item().label)
					if icon then
						kind.kind = " " .. icon
						kind.kind_hl_group = hl_group
					else
						-- Split the kind text if icon is not found
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"
					end

					return kind
				end,
			},

			-- formatting = {
			-- 	format = lspkind.cmp_format({
			-- 		mode = "symbol_text", -- show symbol and text
			-- 		maxwidth = 50, -- limit completion item width
			-- 		ellipsis_char = "...", -- when text is truncated
			-- 		before = function(entry, vim_item)
			-- 			-- Add nvim-web-devicons
			-- 			local icons = require("nvim-web-devicons")
			-- 			local icon, hl_group = icons.get_icon(entry:get_completion_item().label)
			-- 			if icon then
			-- 				vim_item.kind = icon .. " " .. vim_item.kind
			-- 				vim_item.kind_hl_group = hl_group
			-- 			end
			-- 			return vim_item
			-- 		end,
			-- 	}),
			-- },

			-- Enable luasnip to handle snippet expansion for nvim-cmp
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
		})
	end,
}
