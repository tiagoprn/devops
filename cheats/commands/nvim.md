**disable conceal for JSON and other filetypes in real time**: `:lua vim.opt_local.conceallevel = 0`
**open current work in cursor if that is a file**: `gf`
**select multiple tabs with telescope**: <tab> to select files, then <C-q> to send them to quickfix. Then: `:cdo tabedit`
**(which-key) show all available mappings in visual mode**: <Alt+v>
**run external bash command on visual selection** (e.g. `sort` or `uniq`): `:!sort`
