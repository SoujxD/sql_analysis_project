select 
    skills,
    round(avg(salary_year_avg),0) as avg_salary
from job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
where 
    job_title_short = 'Data Analyst' and
    salary_year_avg is not null and 
    job_work_from_home = 'true'
group by 
    skills
order by 
    avg_salary
limit 25

--Here’s a concise summary of the trends:
/*
High-Paying Skills for Data Analysts:

Programming Languages: Julia ($71k), Erlang ($72.5k), and Ruby ($61.7k) command high salaries due to their specialized use.

Data Visualization Tools: Matplotlib ($76.3k), Seaborn ($77.5k), and Plotly ($78.7k) are highly valued, reflecting the importance of visual data representation.

Collaboration Tools: SharePoint ($81.6k), Smartsheet ($63k), and Spreadsheet ($81.8k) indicate the high demand for data management skills.

Frameworks and Libraries: Spring ($82k) and Express ($80k) show that backend development expertise is well-compensated.
In essence, specialized technical skills, particularly in programming and data visualization, lead to higher salaries in data analytics.
*/





