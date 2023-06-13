import { Store } from "./store"
import { CountUp } from "countup.js"

export default class DistributedCounter
	refreshInterval = 1000

	constructor element, target\Store, count, increment
		#element = element
		#target = target
		#count = count
		#increment = increment
	
	options = {
		duration: 1.0
	}
	
	def init
		const next = await #count!

		#counter = new CountUp #element, next, {
			startVal: Number(#target.value),
			...options
		}

		#counter.start do
			#target.value = await #count!

		#timer = setInterval(&, refreshInterval) do
			const next = await #count!
			#counter.update next

			if #target.value != next
				imba.commit!
	
	def destroy
		clearInterval #timer

	def increment
		if #target.value >= Number.MAX_SAFE_INTEGER
			return

		const next = await #increment!
		#target.value = next
		#counter..update next
	
