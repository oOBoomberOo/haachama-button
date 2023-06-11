export default tag Haachama
	x\number
	y\number
	angle\number
	icon="haachama"

	css pos:absolute
		t:0
		l:0
		of:hidden
		zi:1
		w:fit-content
		h:fit-content
	
	css img
		w:256px
		h:auto
	
	<self[x:{x} y:{y} rotate:{angle}deg]>
		<img src=`/avatar/{icon}` alt=icon>
