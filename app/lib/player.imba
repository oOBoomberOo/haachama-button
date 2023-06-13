import Chooser from "random-seed-weighted-chooser";

def item weight\number, name, volume = 1, icon = null
	const makeAudio = do
		const audio = new Audio(`/sounds/{name}`)
		audio.volume = volume
		audio

	const image = `/avatar/{icon or "haachama"}`
	{ name, volume, icon, weight, makeAudio, image }

export const pools = [
	item 0.10, "haachama-pepeloni"
	item 0.15, "ame", 1.0, "ame"
	item 0.15, "aqua"
	item 0.15, "choco"
	item 0.15, "coco", 0.5, "coco"
	item 0.10, "fubuki_special", 1.0, "fubuki"
	item 0.10, "fubuki", 0.6, "fubuki"
	item 0.15, "gura", 0.6, "gura"
	item 0.15, "nene-oneechamachama", 0.4
	item 0.05, "haachama-loud", 0.15
	item 0.90, "haachama", 0.6
	item 0.10, "rushia", 0.7
	item 0.15, "subaru", 1.0, "subaru"
	item 0.10, "haachama-you_know_the_pepeloni"
	item 0.10, "haachama-domino_pepeloni"
	item 0.10, "haachama-pepeloni!"
	item 0.10, "haachama-i_like_pepeloni"
	item 0.10, "haachama-kunkakunka", 0.4
	item 0.10, "haachama-wangywangy", 0.3
	item 0.15, "marine", 0.15
	item 0.15, "aqua_haachama"
	item 0.03, "haachama-killed-akai-haato", 0.45
	item 0.25, "haachama-faqboi", 0.8
]

pools.sort do $1.name.localeCompare $2.name

export def preload
	await Promise.allSettled
		for pool of pools
			Promise.allSettled [
				window.fetch `/sounds/{pool.name}`
				window.fetch `/avatar/{pool.icon or "haachama"}`
			]

export def select
	Chooser.chooseWeightedObject pools


export def play item, onComplete
	const audio\HTMLAudioElement = item.makeAudio()
	audio.addEventListener 'ended', onComplete
	await audio.play!

export tag DebugTool
	data = pools

	css d:grid
		l:0
		r:0
		pos:absolute
		g:5px
		gtc:repeat(auto-fit, 120px)
		gar:auto

	<self>
		for entry of data
			<DebugVoice data=entry>
			
export tag DebugVoice
	def handle
		try await play data

	css d:flex
		fld:column
		ai:center

		@hover
			cursor:pointer
			button bg:red6

	css img
		h:64px
	
	css button
		bd:none
		rd:10px
		bg:red5
		p:5px
		c:white
		ws:nowrap
		of:hidden
		tof:ellipsis
		w:100%

	<self @click=handle>
		<img src=data.image>
		<button> "{data.name}.mp3"
