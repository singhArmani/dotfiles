return {
	"seblj/roslyn.nvim",
	opts = {
		-- exe = {
		-- 	"dotnet",
		-- 	vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
		-- },
	},
	config = function(_, opts)
		-- Configure using the modern vim.lsp.config approach
		vim.lsp.config("roslyn", {
			on_attach = function()
				vim.cmd([[compiler dotnet]])
			end,
			settings = {
				["csharp|inlay_hints"] = {
					["csharp_enable_inlay_hints_for_implicit_object_creation"] = true,
					["csharp_enable_inlay_hints_for_implicit_variable_types"] = true,
					["csharp_enable_inlay_hints_for_lambda_parameter_types"] = true,
					["csharp_enable_inlay_hints_for_types"] = true,
					["dotnet_enable_inlay_hints_for_indexer_parameters"] = true,
					["dotnet_enable_inlay_hints_for_literal_parameters"] = true,
					["dotnet_enable_inlay_hints_for_object_creation_parameters"] = true,
					["dotnet_enable_inlay_hints_for_other_parameters"] = true,
					["dotnet_enable_inlay_hints_for_parameters"] = true,
					["dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix"] = true,
					["dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name"] = true,
					["dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent"] = true,
				},
			},
		})

		-- Setup roslyn with the provided opts
		require("roslyn").setup(opts)
	end,
}
