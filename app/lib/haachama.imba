import * as player from "./player"

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

export class HaachamaSet
	content = new Set!

	def random(min, max)
		Math.random() * (max - min + 1) + min

	def add entry
		const size = 256

		const x = random(0, window.innerWidth - size)
		const y = random(0, window.innerHeight - size)
		const angle = random(0, 360)
		const icon = entry.icon or "haachama"

		const data = { x, y, angle, icon }

		try
			await player.play entry, do
				content.delete data
				imba.commit!
		catch e
			console.warn `Failed to play entry`, e.message
		finally
			content.add data

export def haachamaSet
	new HaachamaSet!
