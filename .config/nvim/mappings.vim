"Exiting terminal mode with Esc"
tnoremap <Esc> <C-\><C-n>
tmap <C-W> <Esc><C-W>
inoremap <C-d> gD 
map <Tab> :NvimTreeFocus<cr>

" Move to previous/next
map <silent>    <A-Left>  :BufferLineCyclePrev<CR>
map <silent>    <A-Right> :BufferLineCycleNext<CR>
" Re-order to previous/next
map <silent>    <A-<> :BufferLineMovePrev<CR>
map <silent>    <A->> :BufferLineMoveNext<CR>
" Goto buffer in position...
map <silent>    <A-1> :BufferLineGoToBuffer 1<CR>
map <silent>    <A-2> :BufferLineGoToBuffer 2<CR>
map <silent>    <A-3> :BufferLineGoToBuffer 3<CR>
map <silent>    <A-4> :BufferLineGoToBuffer 4<CR>
map <silent>    <A-5> :BufferLineGoToBuffer 5<CR>
map <silent>    <A-6> :BufferLineGoToBuffer 6<CR>
map <silent>    <A-7> :BufferLineGoToBuffer 7<CR>
map <silent>    <A-8> :BufferLineGoToBuffer 8<CR>
map <silent>    <A-9> :BufferLineGoToBuffer 9<CR>
" Close buffer
map <silent>    <A-q> :bdelete<CR>

" Move to previous/next
tmap  <A-Left> <Esc><A-Left>
tmap  <A-Right> <Esc><A-Right>
" Re-order to previous/next
tmap  <A-<> <Esc><A-<>
tmap  <A->> <Esc><A->>
" Goto buffer in position...
tmap  <A-1> <Esc><A-1>
tmap  <A-2> <Esc> <A-2>
tmap  <A-3> <Esc> <A-3>
tmap  <A-4> <Esc> <A-4>
tmap  <A-5> <Esc> <A-5>
tmap  <A-6> <Esc> <A-6>
tmap  <A-7> <Esc> <A-7>
tmap  <A-8> <Esc> <A-8>
tmap  <A-9> <Esc> <A-9>
" Close buffer
tmap  <A-q> <Esc><A-q>

