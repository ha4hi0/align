command! -range -nargs=? Align :<line1>,<line2>call s:align_func(<f-args>)

function! s:align_func(...) range abort
	let target = '='
	if a:0 > 0
		let target = a:1
	endif
	let maxnum = 0
	let linelist = []
	for i in range(a:firstline, a:lastline)
		let line = getline(i)
		let colnum = match(line, '=')
		:call setpos('.', [0, i, colnum, 0])
		let colnum = wincol()
		if colnum != -1
			let alist = add(linelist, [i, colnum])
			if colnum>maxnum
				let maxnum = colnum
			endif
		endif	
	endfor
	for l in linelist
		:call setline(l[0], substitute(getline(l[0]), target, repeat(' ', maxnum-l[1]).target, ""))
	endfor
endfunction
