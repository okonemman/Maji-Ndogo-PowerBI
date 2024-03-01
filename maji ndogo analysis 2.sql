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
where  auditor_report.true_water_source_score != water_quality.subjective_quality_score
and
visits.visit_count = 1


create view Incorrect_records as (
SELECT
auditor_report.location_id AS audit_location_id,
auditor_report.true_water_source_score AS auditor_score,
water_quality.subjective_quality_score AS employee_score,
visits.record_id,
visits.visit_count,
employee.employee_name
FROM
    md_water_services.auditor_report
join
employee

join
visits
on
auditor_report.location_id=visits.location_id
and
visits.assigned_employee_id = employee.assigned_employee_id

join
water_quality
on
visits.record_id=water_quality.record_id

where auditor_report.true_water_source_score != water_quality.subjective_quality_score
and
visits.visit_count = 1 );

with
error_count as ( SELECT
employee_name ,
COUNT(employee_score) AS number_of_mistakes,
count(auditor_score) as auditor_score
FROM
Incorrect_records 
GROUP BY employee_name
order by number_of_mistakes ),

avg_error_count_per_empl as (select round(avg(number_of_mistakes), 0)
from error_count ),

suspect_list as (
select employee_name, number_of_mistakes
from error_count
where number_of_mistakes > (select round(avg(number_of_mistakes), 0)
from error_count))

select incorrect_records.employee_name, auditor_report.location_id, auditor_report.statements
from auditor_report
join incorrect_records
on auditor_report.location_id = incorrect_records.audit_location_id
where incorrect_records.employee_name not in (select employee_name from suspect_list)
and  statements like '%cash%'