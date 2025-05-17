local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	-- clg => console.log({ })
	s("clg", {
		t("console.log({ "),
		i(1),
		t(" })"),
	}, {
		description = "console.log with object wrapper",
	}),

	-- log => console.log("")
	s("log", {
		t('console.log("'),
		i(1),
		t('")'),
	}, {
		description = "console.log with string",
	}),
}
