CREATE TABLE IF NOT EXISTS counters(
	/* id: varchar(32) primary key */
	id varchar(32) primary key,
	/* count: bigint! = 0 */
	count bigint not null default 0
);

INSERT INTO counters(id) VALUES('haachama') ON CONFLICT DO NOTHING;
