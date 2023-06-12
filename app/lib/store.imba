const formatter = Intl.NumberFormat 'en-US'

export class Store
	constructor key\string, storage = window.localStorage
		#key = key
		#storage = storage

	set value value
		#storage.setItem #key, value.toString!
	get value
		const raw = #storage.getItem #key
		BigInt raw or 0n

	def format
		formatter.format value


export default def store key, storage = window.localStorage
	new Store key, storage
