import Haachama from "./haachama";
import Scoreboard from "./score"
import * as player from "./player"

def random(min, max)
	Math.random() * (max - min + 1) + min

def wait(ms, fn)
	setTimeout(fn, ms)

class Score
	constructor storage, global = "global", personal = "personal"
		#storage = storage
		#globalKey = global
		#personalKey = personal

	def setScore key, score = 0n
		#storage.setItem key, score.toString()

	def getScore key
		const data = #storage.getItem(key)
		
		if data
			BigInt(data)
		else
			0n
	
	def getCount response\Response
		unless response.status is 200
			const error = await response.text()
			throw new Error(error)

		const data = await response.json()
		BigInt(data.count)

	get score
		getScore #globalKey
	set score value
		setScore #globalKey, value

	get personal
		getScore #personalKey
	set personal value
		setScore #personalKey, value
	
	def fetch
		try
			clearInterval #interval

			const res = await window.fetch('/count')

			const fps = 10
			const frameRate = 1000 / fps

			const prev = score
			const next = await getCount(res)

			if prev >= next
				score = next
				return

			const step = (next - prev) / BigInt(fps) + 1n

			#interval = setInterval(&, frameRate) do
				if score >= next
					clearInterval #interval
				else
					score += step
					imba.commit!
		catch e
			console.error `Failed to fetch score: {e}`

	def increment
		personal += 1n
		score += 1n

		try
			const res = await window.fetch '/increment', { method: 'POST' }
			score = await getCount(res)
		catch e
			console.error `Failed to increment score: {e}`

export default tag Counter
	score\Score = new Score(window.localStorage)
	haachama = new Set()
	
	def mount
		await score.fetch()

		#timer = setInterval(&, 1000) do
			await score.fetch!
	
	def unmount
		clearInterval(#timer)
	
	def increment
		await score.increment!
		const item = player.select!
		addHaachama item
	
	def addHaachama item
		const size = 256
		const age = item.duration * 1000

		const x = random(0, window.innerWidth - size)
		const y = random(0, window.innerHeight - size)
		const angle = random(0, 360)
		const icon = item.icon or "haachama"

		const data = { x, y, angle, icon }

		haachama.add(data)

		player.play(item)

		wait age, do
			haachama.delete(data)
			imba.commit!

	
	css ta:center
		g:15px
		d:flex
		fld:column
		ai:center
		c:var(--text)

	css .score
		m:0 p:0
		c:var(--primary)
		txs: 1px 1px var(--text), 1px -1px var(--text), -1px 1px var(--text), -1px -1px var(--text)

	css button
		p:3 5
		fs:2xl
		bg:var(--primary)
		c:var(--text)
		ol:none
		bd:none
		rd:15px
		w:fit-content
	css button@hover
		cursor:pointer
		bg:red6
	css button@active
		bg:red7
		transform:translateY(2px)
	
	<self[c@suspended: red4]>
		<global>
			for data of haachama
				<Haachama x=data.x y=data.y angle=data.angle icon=data.icon>

		<Scoreboard[fs:48px] bind=score.score>
		<Scoreboard[fs:24px] bind=score.personal>
		<button @click=increment> "HAACHAMA!"

