" General Vim config
" ------------------
let g:python3_host_prog="/Users/timgent/.asdf/shims/python3"

" Use space as the '<Leader>' because that's easier than \
nnoremap <SPACE> <Nop>
let mapleader=" "

" Use jk to exit insert mode
:inoremap jk <esc>
:inoremap Jk <esc>
:inoremap jK <esc>
:inoremap JK <esc>

" Sets where splits are created to something sensible
set splitbelow
set splitright

" Something to do with auto-indenting?
filetype plugin indent on
" Show line numbers
set number
set signcolumn=auto
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

" Ctrl-c copying to clipboard for highlighted text
noremap <C-c> "*y

" Enable mouse wheel scrolling
set mouse=a

" Elixir Mix format on file save
let g:mix_format_on_save = 1

"Handy shortcut for clearing search highlighting
nnoremap <Leader><Leader> :noh<return>

"Shortcut for copying the file name
:nmap cp :let @*=@%<cr>

"Shortcut for removing buffers for test runs
nnoremap <Leader>d :BDelete! regex=^term<return>

" Shortcuts for switching tabs
nnoremap H gT
nnoremap L gt

" CoC terrible error box fix
highlight CocErrorFloat ctermfg=Black  guifg=#ff0000

" Shortcut for vim projectionist go to test file
nnoremap <Leader>gt :A<CR>

" FZF Config
" -----------
nnoremap <C-p> :Files<CR>
" CTRL-A CTRL-Q to select all and build quickfix list (in theory...)
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
" Ignore gitignored files with fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

" GitGutter config
" TODO: This doesn't seem to work...
" autocmd VimEnter * GitGutterSignsDisable


" NERDTree shortcuts
" -------------------
map <F5> :NERDTreeToggle<CR>

" WinResizer config
" -----------------
let g:winresizer_start_key  = '<leader>w'

" vim-test config
" ---------------
let test#strategy = "dispatch" 
" let test#elixir#exunit#executable = 'mix test.watch' " Enable this to run ExUnit tests with a test watcher
" let g:test#neovim#start_normal = 1 " Enable this to always open test window in normal mode
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif
let test#neovim#term_position = "vert botright 130"

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Old kep mappings...
" nmap <silent> <leader>t<C-n> :TestNearest<CR>
" nmap <silent> <leader>t<C-f> :TestFile<CR>
" nmap <silent> <leader>t<C-s> :TestSuite<CR>
" nmap <silent> <leader>t<C-l> :TestLast<CR>
" nmap <silent> <leader>t<C-g> :TestVisit<CR>

" Vim-ultest config 
" -----------------
" nmap ]t <Plug>(ultest-next-fail)
" nmap [t <Plug>(ultest-prev-fail)

" Coc custom configuration 
nnoremap <silent> <leader>co  :<C-u>CocList outline<CR>


" vim-autoformat config 
noremap <F3> :Autoformat<CR>

" Coc-prettier config
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument


" Plugins
" --------
call plug#begin()
" Language server support and code navigation
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Auto-format with mix
Plug 'mhinz/vim-mix-format'
" Shortcuts to switch panes Ctrl+h/j/k/l
Plug 'christoomey/vim-tmux-navigator'
Plug 'troydm/zoomwintab.vim'
" Enables F3 shortcut to maximise a single pane, same to go back to previous
" view
Plug 'szw/vim-maximizer'
" F5 file explorer
Plug 'preservim/nerdtree'
" Ctrl+p file search
Plug 'junegunn/fzf.vim'
" Makes nested parentheses easier to read
Plug 'luochen1990/rainbow'
" Enter and backspace for selecting closest text objects
Plug 'gcmt/wildfire.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-dispatch'
Plug 'simeji/winresizer'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'brooth/far.vim'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'zeis/vim-kolor'
" Surround with brackets, quotes, etc easily
Plug 'tpope/vim-surround'
" Switch to alternate files
Plug 'tpope/vim-projectionist'
" :Econtroller
" :Eview
Plug 'c-brenn/fuzzy-projectionist.vim'
" Plug 'andyl/vim-projectionist-elixir'
" Multicursor editing
Plug 'mg979/vim-visual-multi'
" Run tests in vim!
Plug 'vim-test/vim-test'
" Shortcuts for commenting lines out
Plug 'tpope/vim-commentary'
Plug 'kazhala/close-buffers.nvim'
Plug 'Chiel92/vim-autoformat'
Plug 'HerringtonDarkholme/yats.vim' " Typescript syntax highlighting. TODO: Does this add anything?
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
" Elixir syntax highlighting
Plug 'elixir-editors/vim-elixir'
call plug#end()

" Svelte config 
let g:svelte_indent_script = 0
let g:svelte_indent_style = 0
let g:svelte_preprocessors = ['typescript']

" Vim CoC default configuration
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
