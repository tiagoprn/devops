- search in history: `<C-r>`
- auto-complete from previous query: `right arrow (->)`
- show one column per line (better for legibility): `\T vertical`
- export a query result as a `CSV` file: `\T csv; \o /tmp/output.csv;`. Then, type and run the query.
  -- other alternatives to `CSV`:
     `pipe` (github-flavored markdown),
     `plain` (no borders),
     `tsv` (CSV using tabs as separators - use with \o),
     `html` (use with \o): `\T html; \Tr html; \o -o /tmp/output.html;`,
     `jira` (Jira markup)
