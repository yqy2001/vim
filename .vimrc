

set number
set relativenumber
set cursorline
set hlsearch

set autoindent
"split navigations
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Enable Folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码补全
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu                             " vim自身命名行模式智能补全
set completeopt=menuone,preview,noselect " 补全时不显示窗口，只显示补全列表
set omnifunc=syntaxcomplete#Complete     " 设置全能补全
set shortmess+=c                         " 设置补全静默
set cpt+=kspell                          " 设置补全单词

" config complete {{{
inoremap <silent><expr>/ complete_info(["selected"])["selected"]!=-1&&getline(line('.'))[col('.')-2]=='/'?
			\ "\<bs>/\<c-x>\<c-f>":
			\ "/\<c-x>\<c-f>"
let g:cmpX=-1|let g:cmpY=-1
function! s:feed_popup()
	if getline('.')[col('.')-1]=='/'|return|endif
	let x = col('.') - 1|let y = line('.') - 1
	if g:cmpX==x&&g:cmpY==y|return|endif
	let s:min_complete=2
	let s:context=strpart(getline('.'), 0, col('.') - 1)
	let s:match= matchlist(s:context, '\(\k\{' . s:min_complete . ',}\)$')
	if empty(s:match)|return|endif
	silent! call feedkeys("\<c-n>", 'n')
	let g:cmpX=x|let g:cmpY=y
	return
endfunction
augroup Complete
	au!
	au CursorMovedI * nested call s:feed_popup()
	au FileType text setlocal spell|setlocal nospell
augroup END
inoremap <silent><expr><TAB>
			\ pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"}}}


" tokyonight color inside,donnot change it {{{
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2
let s:tmux = executable('tmux') && $TMUX !=# ''
let g:colors_name = 'tokyonight'|let s:configuration = {}
let s:configuration.style = get(g:, 'tokyonight_style', 'night')
let s:configuration.transparent_background = get(g:, 'tokyonight_transparent_background', 0)
let s:configuration.menu_selection_background = get(g:, 'tokyonight_menu_selection_background', 'green')
let s:configuration.disable_italic_comment = get(g:, 'tokyonight_disable_italic_comment', 0)
let s:configuration.enable_italic = get(g:, 'tokyonight_enable_italic', 0)
let s:configuration.cursor = get(g:, 'tokyonight_cursor', 'auto')
let s:configuration.current_word = get(g:, 'tokyonight_current_word', get(g:, 'tokyonight_transparent_background', 0) == 0 ? 'grey background' : 'bold')
if s:configuration.style ==# 'night'
	let s:palette = {
				\ 'black':      ['#06080a',   '237',  'DarkGrey'],
				\ 'bg0':        ['#1a1b26',   '235',  'Black'],
				\ 'bg1':        ['#232433',   '236',  'DarkGrey'],
				\ 'bg2':        ['#2a2b3d',   '236',  'DarkGrey'],
				\ 'bg3':        ['#32344a',   '237',  'DarkGrey'],
				\ 'bg4':        ['#3b3d57',   '237',  'Grey'],
				\ 'bg_red':     ['#ff7a93',   '203',  'Red'],
				\ 'diff_red':   ['#803d49',   '52',   'DarkRed'],
				\ 'bg_green':   ['#b9f27c',   '107',  'Green'],
				\ 'diff_green': ['#618041',   '22',   'DarkGreen'],
				\ 'bg_blue':    ['#7da6ff',   '110',  'Blue'],
				\ 'diff_blue':  ['#3e5380',   '17',   'DarkBlue'],
				\ 'fg':         ['#a9b1d6',   '250',  'White'],
				\ 'red':        ['#F7768E',   '203',  'Red'],
				\ 'orange':     ['#FF9E64',   '215',  'Orange'],
				\ 'yellow':     ['#E0AF68',   '179',  'Yellow'],
				\ 'green':      ['#9ECE6A',   '107',  'Green'],
				\ 'blue':       ['#7AA2F7',   '110',  'Blue'],
				\ 'purple':     ['#ad8ee6',   '176',  'Magenta'],
				\ 'grey':       ['#444B6A',   '246',  'LightGrey'],
				\ 'none':       ['NONE',      'NONE', 'NONE']
				\ }
elseif s:configuration.style ==# 'storm'
	let s:palette = {
				\ 'black':      ['#06080a',   '237',  'DarkGrey'],
				\ 'bg0':        ['#24283b',   '235',  'Black'],
				\ 'bg1':        ['#282d42',   '236',  'DarkGrey'],
				\ 'bg2':        ['#2f344d',   '236',  'DarkGrey'],
				\ 'bg3':        ['#333954',   '237',  'DarkGrey'],
				\ 'bg4':        ['#3a405e',   '237',  'Grey'],
				\ 'bg_red':     ['#ff7a93',   '203',  'Red'],
				\ 'diff_red':   ['#803d49',   '52',   'DarkRed'],
				\ 'bg_green':   ['#b9f27c',   '107',  'Green'],
				\ 'diff_green': ['#618041',   '22',   'DarkGreen'],
				\ 'bg_blue':    ['#7da6ff',   '110',  'Blue'],
				\ 'diff_blue':  ['#3e5380',   '17',   'DarkBlue'],
				\ 'fg':         ['#a9b1d6',   '250',  'White'],
				\ 'red':        ['#F7768E',   '203',  'Red'],
				\ 'orange':     ['#FF9E64',   '215',  'Orange'],
				\ 'yellow':     ['#E0AF68',   '179',  'Yellow'],
				\ 'green':      ['#9ECE6A',   '107',  'Green'],
				\ 'blue':       ['#7AA2F7',   '110',  'Blue'],
				\ 'purple':     ['#ad8ee6',   '176',  'Magenta'],
				\ 'grey':       ['#444B6A',   '246',  'LightGrey'],
				\ 'none':       ['NONE',      'NONE', 'NONE']
				\ }
endif
if (has('termguicolors') && &termguicolors) || has('gui_running')  " guifg guibg gui cterm guisp
	function! s:HL(group, fg, bg, ...)
		let hl_string = [ 'highlight', a:group, 'guifg=' . a:fg[0], 'guibg=' . a:bg[0], ]
		if a:0 >= 1
			if a:1 ==# 'undercurl'
				if !s:tmux|call add(hl_string, 'gui=undercurl')
				else|call add(hl_string, 'gui=underline')
				endif
				call add(hl_string, 'cterm=underline')
			else|call add(hl_string, 'gui=' . a:1)|call add(hl_string, 'cterm=' . a:1)
			endif
		else|call add(hl_string, 'gui=NONE')|call add(hl_string, 'cterm=NONE')
		endif
		if a:0 >= 2|call add(hl_string, 'guisp=' . a:2[0])|endif
		execute join(hl_string, ' ')
	endfunction
elseif s:t_Co >= 256
	function! s:HL(group, fg, bg, ...)
		let hl_string = [ 'highlight', a:group, 'ctermfg=' . a:fg[1], 'ctermbg=' . a:bg[1]]
		if a:0 >= 1
			if a:1 ==# 'undercurl'|call add(hl_string, 'cterm=underline')
			else|call add(hl_string, 'cterm=' . a:1)
			endif
		else|call add(hl_string, 'cterm=NONE')
		endif
		execute join(hl_string, ' ')
	endfunction
else  " ctermfg ctermbg cterm
	function! s:HL(group, fg, bg, ...)
		let hl_string = [ 'highlight', a:group, 'ctermfg=' . a:fg[2], 'ctermbg=' . a:bg[2]]
		if a:0 >= 1
			if a:1 ==# 'undercurl'|call add(hl_string, 'cterm=underline')
			else|call add(hl_string, 'cterm=' . a:1)
			endif
		else|call add(hl_string, 'cterm=NONE')
		endif
		execute join(hl_string, ' ')
	endfunction
endif
if s:configuration.transparent_background
	call s:HL('Normal', s:palette.fg, s:palette.none)
	call s:HL('Terminal', s:palette.fg, s:palette.none)
	call s:HL('EndOfBuffer', s:palette.bg0, s:palette.none)
	call s:HL('FoldColumn', s:palette.grey, s:palette.none)
	call s:HL('Folded', s:palette.grey, s:palette.none)
	call s:HL('SignColumn', s:palette.fg, s:palette.none)
	call s:HL('ToolbarLine', s:palette.fg, s:palette.none)
else
	call s:HL('Normal', s:palette.fg, s:palette.bg0)
	call s:HL('Terminal', s:palette.fg, s:palette.bg0)
	call s:HL('EndOfBuffer', s:palette.bg0, s:palette.bg0)
	call s:HL('FoldColumn', s:palette.grey, s:palette.bg1)
	call s:HL('Folded', s:palette.grey, s:palette.bg1)
	call s:HL('SignColumn', s:palette.fg, s:palette.bg1)
	call s:HL('ToolbarLine', s:palette.fg, s:palette.bg2)
endif
call s:HL('ColorColumn', s:palette.none, s:palette.bg1)
call s:HL('Conceal', s:palette.grey, s:palette.none)
if s:configuration.cursor ==# 'auto'|call s:HL('Cursor', s:palette.none, s:palette.none, 'reverse')
elseif s:configuration.cursor ==# 'red'|call s:HL('Cursor', s:palette.bg0, s:palette.red)
elseif s:configuration.cursor ==# 'green'|call s:HL('Cursor', s:palette.bg0, s:palette.green)
elseif s:configuration.cursor ==# 'blue'|call s:HL('Cursor', s:palette.bg0, s:palette.blue)
endif
highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
call s:HL('CursorColumn', s:palette.none, s:palette.bg1)
call s:HL('CursorLine', s:palette.none, s:palette.bg1)
call s:HL('LineNr', s:palette.grey, s:palette.none)
if &relativenumber == 1 && &cursorline == 0|call s:HL('CursorLineNr', s:palette.fg, s:palette.none)
else|call s:HL('CursorLineNr', s:palette.fg, s:palette.bg1)
endif
call s:HL('DiffAdd', s:palette.none, s:palette.diff_green)
call s:HL('DiffChange', s:palette.none, s:palette.diff_blue)
call s:HL('DiffDelete', s:palette.none, s:palette.diff_red)
call s:HL('DiffText', s:palette.none, s:palette.none, 'reverse')
call s:HL('Directory', s:palette.green, s:palette.none)
call s:HL('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call s:HL('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call s:HL('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call s:HL('MoreMsg', s:palette.blue, s:palette.none, 'bold')
call s:HL('IncSearch', s:palette.bg0, s:palette.bg_red)
call s:HL('Search', s:palette.bg0, s:palette.bg_green)
call s:HL('MatchParen', s:palette.none, s:palette.bg4)
call s:HL('NonText', s:palette.bg4, s:palette.none)
call s:HL('Whitespace', s:palette.bg4, s:palette.none)
call s:HL('SpecialKey', s:palette.bg4, s:palette.none)
call s:HL('Pmenu', s:palette.fg, s:palette.bg2)
call s:HL('PmenuSbar', s:palette.none, s:palette.bg2)
if s:configuration.menu_selection_background ==# 'blue'
	call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_blue)
	call s:HL('WildMenu', s:palette.bg0, s:palette.bg_blue)
elseif s:configuration.menu_selection_background ==# 'green'
	call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_green)
	call s:HL('WildMenu', s:palette.bg0, s:palette.bg_green)
elseif s:configuration.menu_selection_background ==# 'red'
	call s:HL('PmenuSel', s:palette.bg0, s:palette.bg_red)
	call s:HL('WildMenu', s:palette.bg0, s:palette.bg_red)
endif
call s:HL('PmenuThumb', s:palette.none, s:palette.grey)
call s:HL('Question', s:palette.yellow, s:palette.none)
call s:HL('SpellBad', s:palette.red, s:palette.none, 'undercurl', s:palette.red)
call s:HL('SpellCap', s:palette.yellow, s:palette.none, 'undercurl', s:palette.yellow)
call s:HL('SpellLocal', s:palette.blue, s:palette.none, 'undercurl', s:palette.blue)
call s:HL('SpellRare', s:palette.purple, s:palette.none, 'undercurl', s:palette.purple)
call s:HL('StatusLine', s:palette.fg, s:palette.bg3)
call s:HL('StatusLineTerm', s:palette.fg, s:palette.bg3)
call s:HL('StatusLineNC', s:palette.grey, s:palette.bg1)
call s:HL('StatusLineTermNC', s:palette.grey, s:palette.bg1)
call s:HL('TabLine', s:palette.fg, s:palette.bg4)
call s:HL('TabLineFill', s:palette.grey, s:palette.bg1)
call s:HL('TabLineSel', s:palette.bg0, s:palette.bg_red)
call s:HL('VertSplit', s:palette.black, s:palette.none)
call s:HL('Visual', s:palette.none, s:palette.bg3)
call s:HL('VisualNOS', s:palette.none, s:palette.bg3, 'underline')
call s:HL('QuickFixLine', s:palette.blue, s:palette.none, 'bold')
call s:HL('Debug', s:palette.yellow, s:palette.none)
call s:HL('debugPC', s:palette.bg0, s:palette.green)
call s:HL('debugBreakpoint', s:palette.bg0, s:palette.red)
call s:HL('ToolbarButton', s:palette.bg0, s:palette.bg_blue)
call s:HL('Type', s:palette.blue, s:palette.none, 'italic')
call s:HL('Structure', s:palette.blue, s:palette.none, 'italic')
call s:HL('StorageClass', s:palette.blue, s:palette.none, 'italic')
call s:HL('Identifier', s:palette.orange, s:palette.none, 'italic')
call s:HL('Constant', s:palette.orange, s:palette.none, 'italic')
call s:HL('PreProc', s:palette.red, s:palette.none)
call s:HL('PreCondit', s:palette.red, s:palette.none)
call s:HL('Include', s:palette.red, s:palette.none)
call s:HL('Keyword', s:palette.red, s:palette.none)
call s:HL('Define', s:palette.red, s:palette.none)
call s:HL('Typedef', s:palette.red, s:palette.none)
call s:HL('Exception', s:palette.red, s:palette.none)
call s:HL('Conditional', s:palette.red, s:palette.none)
call s:HL('Repeat', s:palette.red, s:palette.none)
call s:HL('Statement', s:palette.red, s:palette.none)
call s:HL('Macro', s:palette.purple, s:palette.none)
call s:HL('Error', s:palette.red, s:palette.none)
call s:HL('Label', s:palette.purple, s:palette.none)
call s:HL('Special', s:palette.purple, s:palette.none)
call s:HL('SpecialChar', s:palette.purple, s:palette.none)
call s:HL('Boolean', s:palette.purple, s:palette.none)
call s:HL('String', s:palette.yellow, s:palette.none)
call s:HL('Character', s:palette.yellow, s:palette.none)
call s:HL('Number', s:palette.purple, s:palette.none)
call s:HL('Float', s:palette.purple, s:palette.none)
call s:HL('Function', s:palette.green, s:palette.none)
call s:HL('Operator', s:palette.red, s:palette.none)
call s:HL('Title', s:palette.red, s:palette.none, 'bold')
call s:HL('Tag', s:palette.orange, s:palette.none)
call s:HL('Delimiter', s:palette.fg, s:palette.none)
call s:HL('Comment', s:palette.grey, s:palette.none, 'italic')
call s:HL('SpecialComment', s:palette.grey, s:palette.none, 'italic')
call s:HL('Todo', s:palette.blue, s:palette.none, 'italic')
call s:HL('Ignore', s:palette.grey, s:palette.none)
call s:HL('Underlined', s:palette.none, s:palette.none, 'underline')
call s:HL('Fg', s:palette.fg, s:palette.none)
call s:HL('Grey', s:palette.grey, s:palette.none)
call s:HL('Red', s:palette.red, s:palette.none)
call s:HL('Orange', s:palette.orange, s:palette.none)
call s:HL('Yellow', s:palette.yellow, s:palette.none)
call s:HL('Green', s:palette.green, s:palette.none)
call s:HL('Blue', s:palette.blue, s:palette.none)
call s:HL('Purple', s:palette.purple, s:palette.none)
call s:HL('RedItalic', s:palette.red, s:palette.none, 'italic')
call s:HL('BlueItalic', s:palette.blue, s:palette.none, 'italic')
call s:HL('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
let s:terminal = {
			\ 'black':s:palette.black,'red':s:palette.red,'yellow':s:palette.yellow,'green':s:palette.green,
			\ 'cyan':s:palette.orange,'blue':s:palette.blue,'purple':s:palette.purple,'white':s:palette.fg
			\ }
let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
			\ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
			\ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]



