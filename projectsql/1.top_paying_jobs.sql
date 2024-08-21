SELECT
    job_id,
    job_title_short as job_post,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
from job_postings_fact
left join company_dim on job_postings_fact.company_id = company_dim.company_id
where
    job_title_short = 'Data Analyst' and 
    job_location = 'Anywhere' and 
    salary_year_avg is not NULL
order by 
    salary_year_avg desc
limit 10

/*
Here's a summarized analysis of the job data:

Job Role: Data Analyst
Location: Remote/Anywhere
Schedule: Full-time
Salary Range: The average annual salaries range from approximately ₹184,000 to ₹650,000.
Top-Paying Companies:
Mantys: ₹650,000
Meta: ₹336,500
AT&T: ₹255,829.5
Lower-Paying Companies:
Get It Recruit - IT: ₹184,000
SmartAsset: ₹186,000 (lowest listed at ₹205,000 as well)
Posting Dates: Jobs were posted between January and December 2023, with the most recent being in December 2023.
Key Insights: Mantys offers the highest salary, while roles at SmartAsset and Get It Recruit offer some of the lowest in the dataset. All positions are for full-time remote work.

*/