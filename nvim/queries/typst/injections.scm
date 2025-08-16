; extends

; #dg.render(`digraph { ... }`.text)
(code
	(call
		item: (field (ident) @_dg (#eq? @_dg "dg")
			field: (ident) @_render (#eq? @_render "render"))
		(group (field
			 (raw_span
				(blob) @injection.content (#set! injection.language "dot"))
			 field: (ident) @_text (#eq? @_text "text")))))
