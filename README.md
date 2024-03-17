# Maji-Ndogo-Integrated-Project

## Table of Content

- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results/Findings](#results/findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)

### Project Overview

This data analysis project aims to provide insight into the various levels of access of regions to clean, drinkable and affordable water, as part of the United Nations Sustainable Development Goals. We focus particularly on a region called Maji Ndogo as we plan to solve the water crisis it has been facing over the years. By analyzing and transforming various aspects of the different datasets given, we seek to gain a better understanding of the regions, identify trends and relationships between these trends, and provide data-driven solutions that will relieve Maji Ndogo of the problems and their resulting effects that it suffers.

![majindogo](https://github.com/okonemman/Maji_Ndogo_Water_Project/assets/54300962/4098d184-bc85-4e11-a7fa-ee6355816f32)




![majindogo](https://github.com/okonemman/Maji_Ndogo_Water_Project/assets/54300962/6919c25e-53e6-4005-8b7a-7ce59749529d)

### Data Sources

Estimates of the use of water (2000-2020).xlsx  this was used for the excel project 

Md_queue_related_crime.xlsx this was used for the SQL project

Md_water_services_data.xlsx this was also used for the SQL project 

Md_summary.xlsx this was used for the Power BI project.

### Tools

Excel - Data Cleaning and Transformation
MySQL - Data Analysis, exploration and transformation
PowerBI - Data transformation and visualization 

### Data Cleaning/Preparation

Here, I performed the following tasks:

Data Loading and Inspection
Data cleaning and formatting.
Investigating year representation, annual rates of change, and access by area, region, population size and income group.
Handling missing values.
Creation of pivot table to investigate access, and charts to show relationships between variables in the dataset.


### Exploratory Data Analysis

EDA involved exploring the water services data and the queue related crime data to answer questions key questions like:

- what days had the longest queue times?

- what water sources were contaminated based on their quality scores?

- what water sources were the largest serving?

- what days of the week and what time of day had the most visits to the water sources?

- how many mistakes (or perhaps deliberate alterations) were made by employees who had responsibilities in the assessment of the water situation?

- what demographic made the most visits and thus was the most vulnerable to attacks during visits to the water sources?

### Data Analysis

```sql
-- this piece of code extracts the respective water sources and orders them with respect to the total number of people they serve, from lowest to highest.
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
-- this code gives the hours of the day the people visit the water sources and the average amount of time spent on the queues on each day of the week
SELECT 
    TIME_FORMAT(TIME(time_of_record), '%H:00') as hour_of_day,
    round(avg(CASE
        WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
        ELSE NULL
    END), 0) AS Sunday,
    round(avg(case when dayname(time_of_record) = 'Monday' then time_in_queue else null
    end), 0) as Monday,
    from visits
    where time_in_queue <> 0
    group by hour_of_day
    order by hour_of_day
    ```
```sql
-- this code joins the auditor report to the visits table and makes sure the result only shows where visits were made once
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

### Results/Findings

- mornings and evenings have the longest queue times.
- there were cases of impropriety by employees including accepting of cash bribes.
- more women and children were victims of crime during their visits to the water sources than men.

The detailed report can be found in the link below:


https://app.powerbi.com/groups/me/reports/c5cd3a8e-ef7e-4f11-82a2-a84e41797946/ReportSection3bdd831df8f56c9f9778?experience=power-bi

### Recommendations

- taps in households should be fixed so there will be little need for trip to other water sources outside.
- in the places that have more queue times, more water sources should be constructed or already existing water sources nearby should be purified.
- more men should make trips to water sources or accompany women and girls on their trips.


### Limitations

I had to remove all zero values from the dataset used in the Excel project because they would have affected the accuracy of my conclusions from the analysis. 

😄
💻

|Heading 1|Heading 2|
|---------|---------|
|Content|Content2|
|Python|SQL|
