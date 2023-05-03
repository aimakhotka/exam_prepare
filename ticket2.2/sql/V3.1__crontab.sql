create extension if not exists pg_cron;

-- refresh представления каждую минуту:
select cron.schedule('refresh_mat_view', '* * * * *',$$ REFRESH MATERIALIZED VIEW CONCURRENTLY joined_data $$);