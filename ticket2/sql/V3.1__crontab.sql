create extension if not exists pg_cron;

-- refresh представления каждую минуту:
select cron.schedule('refresh_mat_view', '* * * * *',$$ REFRESH MATERIALIZED VIEW CONCURRENTLY flights_tickets_passengers_mv $$);