# Maji-Ndogo-PowerBI

![national report](https://github.com/okonemman/Maji_Ndogo_Water_Project/assets/54300962/8130edb3-7621-4985-91fa-88279b11a5b0)
![Akatsi report](https://github.com/okonemman/Maji_Ndogo_Water_Project/assets/54300962/48c03232-1145-479f-97ed-9d26071ad456)

```sql
SELECT 
    type_of_water_source,
    SUM(number_of_people_served) AS tot_pple_served,
    RANK() over
(order by sum(number_of_people_served)) as rank_by_pop
from water_source
group by type_of_water_source
order by tot_pple_served
```

```sql
SELECT 
    TIME_FORMAT(TIME(time_of_record), '%H:00') as hour_of_day,
    round(avg(CASE
        WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
        ELSE NULL
    END), 0) AS Sunday,
    round(avg(case when dayname(time_of_record) = 'Monday' then time_in_queue else null
    end), 0) as Monday,
    from visits
    where not time_in_queue = 0
    group by hour_of_day
    order by hour_of_day
    ```
```sql
SELECT 
    visits.record_id,
    water_quality.subjective_quality_score as employee_score,
    auditor_report.location_id as audit_location,
    auditor_report.true_water_source_score as auditor_score,
    visits.visit_count
FROM
    auditor_report
join
visits
on
auditor_report.location_id=visits.location_id
join
water_quality
on
visits.record_id=water_quality.record_id
where  auditor_report.true_water_source_score = water_quality.subjective_quality_score
and
visits.visit_count = 1
```
