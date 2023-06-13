import express from 'express';
import postgres from 'postgres';
import dotenv from 'dotenv';
import rateLimit from 'express-rate-limit';

dotenv.config()

const COUNTER_ID = process.env.COUNTER_ID
const DATABASE_URL = process.env.DATABASE_URL

const router = express.Router();
const sql = postgres(DATABASE_URL);
const limiter = rateLimit {
	windowMs: 1000 * 60,
	max: 60 * 50
}

router.use express.json({ limit: '1kb' });

router.get '/count', do(req, res)
	const counters = await sql`SELECT count FROM counters WHERE id = {COUNTER_ID} LIMIT 1`
	const count = counters..at(0)..count ?? 0
	res.header 'Cache-Control', 'no-store'
	res.json { count }

router.post '/increment', limiter, do(req, res)
	const counters = await sql`UPDATE counters SET count = count + 1 WHERE id = {COUNTER_ID} AND count < {Number.MAX_SAFE_INTEGER} RETURNING count`
	const count = counters[0]..count ?? 0
	res.header 'Cache-Control', 'no-store'
	res.json { count }

export default router;