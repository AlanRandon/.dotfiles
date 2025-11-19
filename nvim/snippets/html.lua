---@diagnostic disable: undefined-global

return {
	s(
		"html5",
		fmt(
			[[
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>{}</title>
		<meta name="description" content="{}">
	</head>
	<body>
		{}
	</body>
</html>
]],
			{ i(1, "title"), i(2, "description"), i(3, "body") }
		),
		{ desc = "HTML boilerplate" }
	),
	s(
		"og",
		fmt(
			[[
	<meta property="og:title" content="{}">
	<meta property="og:type" content="website">
	<meta property="og:url" content="{}">
	<meta property="og:description" content="{}">
	<meta property="og:image" content="{}">
	<meta property="og:image:alt" content="{}">
]],
			{
				i(1, "title"),
				i(2, "url"),
				i(3, "description"),
				i(4, "/path/to/image.png"),
				i(5, "image alt text"),
			}
		),
		{ desc = "[Open Graph](https://ogp.me/) metadata" }
	),
}
