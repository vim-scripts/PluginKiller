" pluginkiller: determine which options are problematic for a plugin
" Author: Charles E. Campbell,Jr.
" Date:   Mar 08, 2006
" Version: 1
" GetLatestVimScripts: :AutoInstall: 1489 1 pluginkiller.vim
" ---------------------------------------------------------------------
"  Usage: {{{1
"    1) unix command line:  pluginkiller
"       -or- type:  vim --servername PLUGINKILLER pluginkiller.vim -c "so %"
"    2) plugin being tested window:  :ANX PK
"
"    Repeat steps 3,4 until pluginkiller identifies the culprit setting:
"    3) If plugin misbehaves:
"         pluginkiller window       : :PKb   (for PluginKiller Bad Behavior)
"         plugin being tested window: :PK    (reloads new settings)
"    4) If plugin behaved
"         pluginkiller window       : :PKg   (for PluginKiller Good Behavior)
"         plugin being tested window: :PK    (reloads new settings)
"
"    Use :PKr to restore the pluginkiller and normal option settings.
" ---------------------------------------------------------------------

" ---------------------------------------------------------------------
"  Public Interface: {{{1
com! -nargs=0 PK           so $VIMSCRIPT/pluginkiller.vim|call s:PluginKiller()
com! -nargs=0 PluginKiller so $VIMSCRIPT/pluginkiller.vim|call s:PluginKiller()
if has("clientserver") && expand("%") == "pluginkiller.vim"
 " 0-3: local  commands to pluginkiller window
 " 6-8: remote commands to pluginkiller window
 com! -nargs=0 PKr          call PluginKillerBinSrch(0)
 com! -nargs=0 PKg          call PluginKillerBinSrch(1)
 com! -nargs=0 PKb          call PluginKillerBinSrch(2)
 com! -nargs=0 PKRr         call PluginKillerBinSrch(6)
 com! -nargs=0 PKRg         call PluginKillerBinSrch(7)
 com! -nargs=0 PKRb         call PluginKillerBinSrch(8)
 let g:loaded_pluginkiller= "v1"
else
 " local commands to remote pluginkiller server
 com! -nargs=0 PKr          call PluginKillerBinSrch(3)|call PluginKillerBinSrch(0)
 com! -nargs=0 PKg          call PluginKillerBinSrch(4)
 com! -nargs=0 PKb          call PluginKillerBinSrch(5)
 augroup PluginKillerGroup
  au!
  au PluginKillerGroup RemoteReply *	let s:ready= remote_read(expand("<amatch>"))|PK
 augroup END
endif

" ---------------------------------------------------------------------
"  PluginKiller: {{{1
fun! s:PluginKiller()
"  call Dfunc("PluginKiller()")

  " The following title settings shouldn't hurt,
  " they're just to let you know that the pluginkiller
  " has done its deed.
  set title
  if !exists("s:oldtitle")
   let g:PluginKiller_oldtitle= &titlestring
  endif
  set titlestring=Plugin\ Killer\ Active

  if !exists("g:PluginKiller_keep_ai")
   " save initial settings
"   call Decho("saving initial option settings")
   let g:PluginKiller_keep_ai     = &ai
   let g:PluginKiller_keep_cin    = &cin
   let g:PluginKiller_keep_ci     = &ci
   let g:PluginKiller_keep_acd    = &acd
   let g:PluginKiller_keep_cb     = &cb
   let g:PluginKiller_keep_ch     = &ch
   let g:PluginKiller_keep_cwh    = &cwh
   let g:PluginKiller_keep_cf     = &cf
   let g:PluginKiller_keep_ea     = &ea
   let g:PluginKiller_keep_ead    = &ead
   let g:PluginKiller_keep_fo     = &fo
   let g:PluginKiller_keep_gd     = &gd
   let g:PluginKiller_keep_go     = &go
   let g:PluginKiller_keep_hls    = &hls
   let g:PluginKiller_keep_ic     = &ic
   let g:PluginKiller_keep_js     = &js
   let g:PluginKiller_keep_ls     = &ls
   let g:PluginKiller_keep_more   = &more
   let g:PluginKiller_keep_magic  = &magic
   let g:PluginKiller_keep_pi     = &pi
   let g:PluginKiller_keep_pvh    = &pvh
   let g:PluginKiller_keep_remap  = &remap
   let g:PluginKiller_keep_scr    = &scr
   let g:PluginKiller_keep_sj     = &sj
   let g:PluginKiller_keep_report = &report
   let g:PluginKiller_keep_siso   = &siso
   let g:PluginKiller_keep_smd    = &smd
   let g:PluginKiller_keep_siso   = &siso
   let g:PluginKiller_keep_so     = &so
   let g:PluginKiller_keep_ss     = &ss
   let g:PluginKiller_keep_sb     = &sb
   let g:PluginKiller_keep_spr    = &spr
   let g:PluginKiller_keep_sol    = &sol
   let g:PluginKiller_keep_swb    = &swb
   let g:PluginKiller_keep_sw     = &sw
   let g:PluginKiller_keep_sr     = &sr
   let g:PluginKiller_keep_tw     = &tw
   let g:PluginKiller_keep_top    = &top
   let g:PluginKiller_keep_ws     = &ws
  else
   " restore settings
"   call Decho("restoring initial option settings")
   let &ai     = g:PluginKiller_keep_ai
   let &cin    = g:PluginKiller_keep_cin
   let &ci     = g:PluginKiller_keep_ci
   let &acd    = g:PluginKiller_keep_acd
   let &cb     = g:PluginKiller_keep_cb
   let &ch     = g:PluginKiller_keep_ch
   let &cwh    = g:PluginKiller_keep_cwh
   let &cf     = g:PluginKiller_keep_cf
   let &ea     = g:PluginKiller_keep_ea
   let &ead    = g:PluginKiller_keep_ead
   let &fo     = g:PluginKiller_keep_fo
   let &gd     = g:PluginKiller_keep_gd
   let &go     = g:PluginKiller_keep_go
   let &hls    = g:PluginKiller_keep_hls
   let &ic     = g:PluginKiller_keep_ic
   let &js     = g:PluginKiller_keep_js
   let &ls     = g:PluginKiller_keep_ls
   let &more   = g:PluginKiller_keep_more
   let &magic  = g:PluginKiller_keep_magic
   let &pi     = g:PluginKiller_keep_pi
   let &pvh    = g:PluginKiller_keep_pvh
   let &remap  = g:PluginKiller_keep_remap
   let &scr    = g:PluginKiller_keep_scr
   let &sj     = g:PluginKiller_keep_sj
   let &report = g:PluginKiller_keep_report
   let &siso   = g:PluginKiller_keep_siso
   let &smd    = g:PluginKiller_keep_smd
   let &siso   = g:PluginKiller_keep_siso
   let &so     = g:PluginKiller_keep_so
   let &ss     = g:PluginKiller_keep_ss
   let &sb     = g:PluginKiller_keep_sb
   let &spr    = g:PluginKiller_keep_spr
   let &sol    = g:PluginKiller_keep_sol
   let &swb    = g:PluginKiller_keep_swb
   let &sw     = g:PluginKiller_keep_sw
   let &sr     = g:PluginKiller_keep_sr
   let &tw     = g:PluginKiller_keep_tw
   let &top    = g:PluginKiller_keep_top
   let &ws     = g:PluginKiller_keep_ws
  endif
"  set acd           " changes working directory when you open file, switch buffers, delete buffer, open/close window
  
  " -----------------------------
  " Plugin Killer Testing Options: start
  " -----------------------------
  set ai            " when inserting lines, you probably don't want ai
  set cin           " when inserting lines, you probably don't want cin
  set ci            " when inserting lines, you probably don't want ci
  set cb=autoselect " don't want to have clipboard changed when using, say norm! vy
  set ch=1          " try to avoid |hit-enter| prompts anyway
  set cwh=1         " if you're using it, maybe you want to see it >1 line?
  set cf            " you don't want confirm dialogs when changing things while in a plugin
  set ea            " windows are automatically being made the same size
  set ead=ver       " don't want plugins unexpectedly changing window sizes
  set ed            " makes 'g' and 'c' flags toggle each time flag is given
  set nofen         " folds disabled (all folds open)
  set fo=tcroqwan2vblmMB1  " if this is your problem, suggest your plugin uses fo=tcq
  set gd            " all substitutions have "g" flag appended (yuck)
  set go+=a         " another visual-selection messes with clipboard
  set hls           " don't want to change @/
  set ic            " ignores case -- does your plugin still work?
  set js            " does joining with two spaces clobber something?
  set ls=0          " does your plugin use the status line?  This'll do it in...
  set more          " yep, listings pauses will help plugins a lot - not!
  set nomagic       " there goes all your nifty regexps
  set pi            " always preserve indent...
  set pvh=1         " previewheight of 1 to make it go away.  Does your plugin want a preview window?
  set noremap       " prevents mapping recursion
  set scr=3         " make ctrl-u and ctrl-d do only three lines.  Got any maps using these?
  set sj=4          " now for a jumpy display.
  set nosol         " various commands move cursor to first non-blank of line
  set report=0      " is your plugin real noisy now?  this one reports all changes.
  set siso=5
  set smd           " show extra messages when in insert, replace, visual modes.
  set siso=30       " min qty screen columns to left
  set so=10
  set ss=10         " min qty columns to scroll horizontally
  set sb            " split windows below    -- does your new window open ok?
  set spr           " split windows to right -- does your new window open ok?
  set sol           " a number of motion commands move cursor to first non-blank of line
  set swb=split     " split current window before loading a buffer
  set sw=2          " qty spaces to use for each indent
  set sr            " round indent to multiple of 'sw'
  set tw=50         " medium size textwidth selected
  set top           " make ~ behave like an operator
  set nows          " no wrapscan (ie. search don't wrap around end-of-file)
  set ve=           " virtual edit is off
  " -----------------------------
  " Plugin Killer Testing Options: end
  " -----------------------------

"  call Dret("PluginKiller")
endfunc

" ---------------------------------------------------------------------
" PluginKillerBinSrch: {{{1
"   mode=0 : reset/init
"       =1 : last setting group yielded good performance from plugin
"       =2 : last setting group yielded bad  performance from plugin
"       =3 : client is requesting a PKr
"       =4 : client is requesting a PKg
"       =5 : client is requesting a PKb
"       =6 : server received a remote PKr request
"       =7 : server received a remote PKg request
"       =8 : server received a remote PKb request
fun! PluginKillerBinSrch(mode)
"  call Dfunc("PluginKillerBinSrch(mode=".a:mode.")")

  if expand("%") != "pluginkiller.vim"
   if !has("clientserver")
   	echohl WARNING | echo "***warning*** can't use remote control mode, your vim has -clientserver"
"    call Dret("PluginKillerBinSrch : attempt to use remote control mode, but no clientserver")
    return
   endif
   if     a:mode == 3
    call remote_send("PLUGINKILLER",":PKRr\<cr>")
"    call Dret("PluginKillerBinSrch : remote PKr")
   elseif a:mode == 4
    call remote_send("PLUGINKILLER",":PKRg\<cr>")
"    call Dret("PluginKillerBinSrch : remote PKg")
   elseif a:mode == 5
    call remote_send("PLUGINKILLER",":PKRb\<cr>")
"    call Dret("PluginKillerBinSrch : remote PKb")
   endif
   return
  endif

  let mode= a:mode
  if mode >= 6
   let mode= mode - 6
  endif

  " find the start,end of active test settings
  if !exists("s:setstart")
"   call Decho("find start,end of test settings")
   1
   let curline   = search('Plugin Killer Testing Options: start','W')
   let s:setstart= search('^"\=\s*set\>','W')
   let s:setend  = search('Plugin Killer Testing Options: end','W')
   let s:setend  = search('^\=\s*set\>','bW')
   if s:setstart == 0|echoerr "unable to find s:setstart!"|endif
   if s:setend   == 0|echoerr "unable to find s:setend!"  |endif
   if s:setstart == 0 || s:setend == 0
"    call Dret("PluginKillerBinSrch : unable to find set[start,end]")
    return
   endif
   exe curline
   exe "norm! zMzxz\<cr>"

   if exists("s:badzonestart")
   	unlet s:badzonestart
   endif
   if exists("s:badzoneend")
   	unlet s:badzoneend
   endif
  endif

  if mode == 0
   " reset/init - reset to all settings active
"   call Decho("reset: settings on lines ".s:setstart." to ".s:setend)
   exe "silent! ".s:setstart.",".s:setend.'s/^"//e'
   if exists("s:badzonestart")
    unlet s:badzonestart
   endif
   if exists("s:badzoneend")
    unlet s:badzoneend
   endif
   1
   call search('Plugin Killer Testing Options: start','w')
   exe "norm! zMzxz\<cr>"
   w
   if a:mode >= 6
   	call server2client(expand("<client>"),"ready")
   endif
"   call Dret("PluginKillerBinSrch")
   return
  endif

  " determine where the next badzone will be using binary search
  if !exists("s:badzonestart")
   " first pass (assume :PK yielded bad behavior on part of the plugin)
   let s:badzonestart = s:setstart
   let s:badzoneend   = s:setend
   exe s:setstart.",".s:setend.'s/^"//e'
  elseif mode == 1
   " last setting group yielded good performance from plugin
   let s:badzonestart= (s:badzoneend - s:badzonestart)/2 + s:badzonestart + 1
   exe s:badzonestart
  elseif mode == 2
   " last setting group yielded bad  performance from plugin
   let s:badzoneend   = (s:badzoneend - s:badzonestart)/2 + s:badzonestart
  endif
"  call Decho("settings[".s:setstart.",".s:setend."]")
"  call Decho("badzone [".s:badzonestart.",".s:badzoneend."]")
  let activestart    = s:badzonestart
  let activeend      = (s:badzoneend - s:badzonestart)/2 + s:badzonestart
"  call Decho("active  [".activestart.",".activeend."]")

  " when done, badzonestart == badzoneend.  Reactivate all settings
  if s:badzonestart == s:badzoneend
"   call Decho("bad setting<".getline(s:badzonestart).">")
"   call Decho("restoring pluginkiller lines ".s:setstart." to ".s:setend)
   exe "silent! ".s:setstart.",".s:setend.'s/^"//e'
   w
   let badsetting= s:badzonestart
   unlet s:badzonestart
   unlet s:badzoneend
   1
   call search('Plugin Killer Testing Options: start','w')
   exe "norm! zMzxz\<cr>"
   echohl WarningMsg | echomsg "problem setting: ".getline(badsetting) | echohl None
   if a:mode >= 6
   	call server2client(expand("<client>"),"ready")
   endif
"   call Dret("PluginKillerBinSrch")
   return
  endif

  " activate settings from [activestart,activeend]
"  call Decho("activate settings from [".activestart.",".activeend."]")
  exe "silent! ".activestart.",".activeend.'s/^"//e'

  " deactivate settings from [setstart,activestart)
  if activestart > s:setstart
   let asm1= activestart - 1
"   call Decho("de-activate settings from [".s:setstart.",".asm1."]")
   exe "silent! ".s:setstart.",".asm1.'v/^"/s/^/"/'
"   call Decho("deactivate [".s:setstart.",".asm1."]")
  endif

  " deactivate settings from (activeend,setend]
  if activeend < s:setend
   let aep1= activeend + 1
"   call Decho("de-activate settings from [".aep1.",".s:setend."]")
   exe "silent! ".aep1.",".s:setend.'v/^"/s/^/"/'
"   call Decho("deactivate [".aep1.",".s:setend."]")
  endif
  
  " display starting from s:badzonestart
  exe s:badzonestart
  exe "norm! zMzxz\<cr>"
  w

  if a:mode >= 6
   call server2client(expand("<client>"),"ready")
  endif
"  call Dret("PluginKillerBinSrch")
endfun

" ---------------------------------------------------------------------
"  PluginKiller Window Actions: {{{1
if has("clientserver")
 if expand("%") == "pluginkiller.vim"
  1
  call search('Plugin Killer Testing Options: start','W')
  exe "norm! zMzxz\<cr>"
  echomsg "pluginkiller server ready"
 endif
endif

" ---------------------------------------------------------------------
"  Modelines: {{{1
"  vim: fdm=marker
