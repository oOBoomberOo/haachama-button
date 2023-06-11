import express from 'express';
import postgres from 'postgres';

const router = express.Router();
const db = postgres();

router.use express.json({ limit: '1kb' });

router.get '/count', do(req, res)
	res.json({ count: 42 })

export default router;