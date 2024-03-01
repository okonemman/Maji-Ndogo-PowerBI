
SELECT 
    type_of_water_source,
    round(SUM(number_of_people_served) / (SELECT 
            SUM(number_of_people_served)
        FROM
            water_source) * 100, 0) AS per_cent
FROM
    water_source
GROUP BY type_of_water_source

SELECT 
    type_of_water_source,
    SUM(number_of_people_served) AS tot_pple_served,
    RANK() over
(order by sum(number_of_people_served)) as rank_by_pop
from water_source
group by type_of_water_source
order by tot_pple_served

select type_of_water_source, sum(number_of_people_served), rank() over (order by sum(number_of_people_served)desc)
from water_source
group by type_of_water_source
order by sum(number_of_people_served) desc

select source_id, type_of_water_source, SUM(number_of_people_served), rank() over (PARTITION BY SUM(number_of_people_served))
from water_source
group by type_of_water_source, source_id
order by sum(number_of_people_served)

select 
source_id,
type_of_water_source,
number_of_people_served,
RANK () over (partition by type_of_water_source order by number_of_people_served desc) as priority_rank
from water_source
where not
type_of_water_source = 'tap_in_home'
group by
source_id, type_of_water_source

select DATEDIFF(max(time_of_record), MIN(time_of_record))
FROM visits

SELECT AVG(nullIF(time_in_queue, 0))
FROM visits

SELECT 
    HOUR(time_of_record), AVG(time_in_queue)
FROM
    visits
GROUP BY HOUR(time_of_record)
order by HOUR(time_of_record)

select time_format(time(time_of_record), '%H:00'), avg(time_in_queue)
from visits
group by time_format(time(time_of_record), '%H:00')
order by time_format(time(time_of_record), '%H:00')

SELECT 
    TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
    ROUND(AVG(CASE
                WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
                ELSE NULL
            END),
            0) AS Sunday
            

SELECT 
    TIME_FORMAT(TIME(time_of_record), '%H:00') as hour_of_day,
    round(avg(CASE
        WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
        ELSE NULL
    END), 0) AS Sunday,
    round(avg(case when dayname(time_of_record) = 'Monday' then time_in_queue else null
    end), 0) as Monday,
    round(avg(case when dayname(time_of_record) = 'Tuesday' then time_in_queue else null
    end), 0) as Tuesday,
    round(avg(case when dayname(time_of_record) = 'Wednesday' then time_in_queue else null
    end), 0) as Wednesday,
    round(avg(case when dayname(time_of_record) = 'Thursday' then time_in_queue else null
    end), 0) as Thursday,
    round(avg(case when dayname(time_of_record) = 'Friday' then time_in_queue else null
    end), 0) as Friday,
    round(avg(case when dayname(time_of_record) = 'Saturday' then time_in_queue else null
    end), 0) as Saturday
    from visits
    where not time_in_queue = 0
    group by hour_of_day
    order by hour_of_day
