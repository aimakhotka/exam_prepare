create extension if not exists pg_cron;

-- INSERT INTO cron.job (schedule, command, nodename, nodeport, database, username) VALUES ('*/5 * * * *', 'REFRESH MATERIALIZED VIEW CONCURRENTLY flights_tickets_passengers_mv;', '', 5432, 'airline_tickets', 'postgres');

-- refresh представления каждую минуту:
select cron.schedule('refresh_mat_view', '* * * * *',$$ REFRESH MATERIALIZED VIEW CONCURRENTLY flights_tickets_passengers_mv $$);