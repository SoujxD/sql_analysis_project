select 
    skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
    job_title_short = 'Data Analyst' and 
    job_work_from_home = 'true'
GROUP BY
    skills
order by 
    demand_count desc
limit 5

/*
Here's a short analysis:

SQL leads with the highest demand (7,291), highlighting its essential role in data management.
Excel (4,611) and Python (4,330) are also in strong demand, reflecting their importance in data analysis and programming.
Tableau (3,745) and Power BI (2,609) are highly sought after for data visualization, indicating the growing emphasis on interpreting and presenting data effectively.
Overall, core data management and analysis skills like SQL and Python are in highest demand, followed by tools for visualization.

*/