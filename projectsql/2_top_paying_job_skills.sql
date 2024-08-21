with top_paying_jobs as (
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
)
select 
    top_paying_jobs.*
    skills
from top_paying_jobs
inner JOIN skills_job_dim on skills_job_dim.job_id = top_paying_jobs.job_id
inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
order by 
    salary_year_avg desc

/*
The data provided consists of multiple entries for "Data Analyst" job postings from various companies. Here's a summarized analysis:

AT&T: Repeated entries for a "Data Analyst" position with an average annual salary of $255,829.5. The job was posted on June 18, 2023.
Pinterest Job Advertisements: Multiple entries for a "Data Analyst" position with an average annual salary of $232,423.0. The job was posted on December 5, 2023.
Uclahealthcareers: Repeated entries for a "Data Analyst" position with an average annual salary of $217,000.0. The job was posted on January 17, 2023.
SmartAsset: Multiple entries for a "Data Analyst" position with an average annual salary of $205,000.0. The job was posted on August 9, 2023.
Inclusively: Repeated entries for a "Data Analyst" position with an average annual salary of $189,309.0. The job was posted on December 7, 2023.
Motional: Several entries for a "Data Analyst" position with an average annual salary of $189,000.0. The job was posted on January 5, 2023.
Key Points:

All job postings are for full-time remote positions ("Anywhere").
There are numerous duplicate entries for each job listing.
Salaries vary from $189,000.0 to $255,829.5 across different companies, with AT&T offering the highest salary.
*/