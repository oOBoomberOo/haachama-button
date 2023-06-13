import Chooser from "random-seed-weighted-chooser";

def item weight\number, name, volume = 1, icon = null
	const makeAudio = do
		const audio = new Audio(`/sounds/{name}`)
		audio.volume = volume
		audio

	const image = `/avatar/{icon or "haachama"}`
	{ name, volume, icon, weight, makeAudio, image }

export const pools = [
	item 0.10, "pepeloni"
	item 0.15, "ame", 1.0, "ame"
	item 0.15, "aqua"
	item 0.15, "choco"
	item 0.10, "coco", 0.5, "coco"
	item 0.10, "you_know_the_pepeloni"
	item 0.05, "fubuki_special", 1.0, "fubuki"
	item 0.10, "fubuki", 0.6, "fubuki"
	item 0.25, "gura", 0.6, "gura"
	item 0.05, "original_special", 0.15
	item 0.90, "original", 0.6
	item 0.10, "rushia"
	item 0.20, "subaru"
	item 0.10, "domino_pepeloni"
	item 0.10, "pepeloni!"
	item 0.10, "i_like_pepeloni"
]

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
