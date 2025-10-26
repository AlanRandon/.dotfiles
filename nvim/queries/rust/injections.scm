; extends

(macro_invocation
  macro: (scoped_identifier
    path: (identifier) @_sqlx (#eq? @_sqlx "sqlx")
    name: (identifier) @_query (#match? @_query "(query|query_as)"))
  (token_tree
   (string_literal
     (string_content) @injection.content
       (#set! injection.language "sql"))))

(macro_invocation
  macro: (scoped_identifier
    path: (identifier) @_sqlx (#eq? @_sqlx "sqlx")
    name: (identifier) @_query (#match? @_query "(query|query_as)"))
  (token_tree
   (raw_string_literal
     (string_content) @injection.content
       (#set! injection.language "sql"))))
