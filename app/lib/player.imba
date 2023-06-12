import Chooser from "random-seed-weighted-chooser";

def item duration, weight\number, name, volume = 1, icon = null
	const makeAudio = do
		const audio = new Audio(`/sounds/{name}`)
		audio.volume = volume
		audio

	const image = `/avatar/{icon or "haachama"}`
	{ name, duration, volume, icon, weight, makeAudio, image }

export const pools = [
	item 1.75, 0.15, "ame", 1.0, "ame"
	item 1.20, 0.15, "aqua"
	item 2.25, 0.15, "choco"
	item 1.46, 0.10, "coco", 0.5, "coco"
	item 1.99, 0.05, "fubuki_special", 1.0, "fubuki"
	item 1.46, 0.10, "fubuki", 0.6, "fubuki"
	item 2.76, 0.05, "gura", 0.2, "gura"
	item 3.38, 0.05, "original_special", 0.15
	item 1.32, 0.90, "original", 0.6
	item 1.32, 0.10, "rushia"
	item 1.48, 0.20, "subaru"
	item 1.00, 0.10, "pepeloni"
	item 1.06, 0.10, "you_know_the_pepeloni"
	item 1.60, 0.10, "domino_pepeloni"
	item 1.00, 0.10, "pepeloni!"
	item 1.00, 0.10, "i_like_pepeloni"
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


export def play item
	const audio = item.makeAudio()
	try await audio.play!
