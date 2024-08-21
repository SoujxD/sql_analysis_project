with skills_demand as (
select 
    skills_dim.skills,
    skills_dim.skill_id,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
    job_title_short = 'Data Analyst' and 
    job_work_from_home = 'true' and
    salary_year_avg is not null
GROUP BY
    skills_dim.skill_id

), average_salary as(
select 
    skills_job_dim.skill_id,
    round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
    job_title_short = 'Data Analyst' and
    salary_year_avg is not null and 
    job_work_from_home = 'true'
group by 
    skills_job_dim.skill_id

)
select skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
where demand_count > 10
order by 
    avg_salary desc,
    demand_count desc
    
limit 25

/*
Here’s a brief analysis of the top-paying skills:

Top-Paying and In-Demand Skills:
Highest Salaries:
Go ($115,320) and Confluence ($114,210) top the list, but their demand is relatively low (27 and 11, respectively).
Hadoop ($113,193) and Snowflake ($112,948) also offer high salaries with moderate demand (22 and 37).
High Demand but Moderate Salaries:
Python ($101,397) and Tableau ($99,288) are in high demand (236 and 230) but offer lower average salaries compared to more niche skills.
R ($100,499) also shows strong demand (148) with a similar salary range.
Cloud and Data Management Tools:
Azure ($111,225), AWS ($108,317), and BigQuery ($109,654) are highly sought-after cloud skills with strong salaries and moderate demand.
SQL Server ($97,786) is in moderate demand (35) but offers a slightly lower salary.
Data Visualization and BI Tools:
Looker ($103,795), Qlik ($99,631), and Tableau ($99,288) show that data visualization skills are in demand, though salaries are slightly lower compared to cloud and big data skills.
Programming Languages:
Java ($106,906) and C++ ($98,958) remain solid choices with decent salaries and steady demand.
Overall Trend:
Specialized and cloud-related skills like Go, Hadoop, and Snowflake command the highest salaries.
Commonly used languages and tools, like Python, R, and Tableau, have the highest demand but slightly lower salaries, reflecting their widespread use.

*/




