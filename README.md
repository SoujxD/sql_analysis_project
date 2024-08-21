# Introduction  
📊Dive into the data job market! focusing on data analyst roles, this project explores💰 top-paying jobs, 🔥in-demand skills, and 📉where high demand meets high salary in data analytics.


🔍SQL queries? check them out here: [proejct_sql_folder](/projectsql).
# Background   
In the rapidly evolving field of data analysis, understanding the landscape of high-paying opportunities and the skills that drive success is crucial for career advancement. This project delves into various aspects of the data analyst profession to provide a comprehensive overview for aspiring professionals.

I have learned this course from [**Luke Barousse youtube channel**](https://www.youtube.com/watch?v=7mz73uXD9DA&t=7805s) 


### The key questions addressed in this project include:

1. What are the top paying data analyst jobs?
2. What skills are required for those top paying jobs?
3. What skills are most in-demand for data analyst jobs?
4. Which skills are associated with high salaries?
5. What are the most optimal skills to learn?  

By exploring these questions, the project aims to offer valuable insights into the current job market, helping data analysts align their skill development with career goals and industry demands.


# Tools I used     
Tools I Used:

To effectively analyze data and manage the project, I utilized the following tools:

- **SQL**: Employed for querying and managing relational databases, facilitating complex data retrieval and manipulation tasks.  
- **PostgreSQL**: Used as the database management system for storing, organizing, and querying data, leveraging its advanced features for robust data handling.
- **Visual Studio Code (VSCode)**: Utilized as the primary code editor for writing and editing scripts, enhancing productivity with its versatile features and extensions.
- **Git**: Applied for version control to track changes, collaborate with others, and manage the project's source code history.
- **GitHub**: Leveraged for hosting the project's repository, enabling collaboration, and sharing code and documentation with stakeholders.
These tools were integral to the project’s execution, ensuring efficient data management, code development, and version control.


# The analysis    
Each query aimed at investigating specific aspects of data analyst job market. here's how I approached each question :

## 1. What are the top paying data analyst jobs?

Here’s a summary of the table and a bar graph visualization for the average annual salaries of data analyst positions from different companies.

Summary:
The table lists data analyst job postings from various companies, including their average annual salaries. Here are the details:

Below is the code for it:
```sql
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
```

- **Mantys**: $650,000
- **Meta**: $336,500
- **AT&T**: $255,829.50
- **Pinterest Job Advertisements**: $232,423
- **Uclahealthcareers**: $217,000
- **SmartAsset**: $205,000 (first listing), $186,000 (second listing)
- **Inclusively**: $189,309
- **Motional**: $189,000
- **Get It Recruit** - Information Technology: $184,000

Company                           | Average Annual Salary
----------------------------------|---------------------
Mantys                            | $650,000
Meta                              | $336,500
AT&T                              | $255,829.50
Pinterest Job Advertisements      | $232,423
Uclahealthcareers                  | $217,000
SmartAsset (First Listing)         | $205,000
SmartAsset (Second Listing)        | $186,000
Inclusively                        | $189,309
Motional                           | $189,000
Get It Recruit - Information Tech  | $184,000

## 2. What skills are required for those top paying jobs?

Here's a summary of the question answered:

Below is the code:
```sql
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
```

Company Names and Average Annual Salaries for the Data Analyst positions:

- **AT&T**: $255,829.50
- **Pinterest Job Advertisements**: $232,423.00
- **Uclahealthcareers**: $217,000.00
- **SmartAsset**: $205,000.00 (for most entries) and $186,000.00 (for some entries)
- **Inclusively**: $189,309.00
- **Motional**: $189,000.00
- **Get It Recruit**- Information Technology: $184,000.00
### Count of Job Listings for each company:

- **AT&T**: 12
- **Pinterest Job Advertisements**: 5
- **Uclahealthcareers**: 5
- **SmartAsset**: 10 (5 at $205,000.00 and 5 at $186,000.00)
- **Inclusively**: 10
- **Motional**: 9
- **Get It Recruit-Information Technology**: 3

Company Name                         | Average Salary
-------------------------------------|----------------
AT&T                                | 255,829.50
Pinterest Job Advertisements         | 232,423.00
Uclahealthcareers                     | 217,000.00
SmartAsset                           | 205,000.00
Inclusively                          | 189,309.00
Motional                             | 189,000.00
Get It Recruit - Information Technology | 184,000.00

## 3. What skills are most in-demand for data analyst jobs?
Below is the code:
```sql
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
```
Here's a summary of the skills and their demand counts:

- **SQL**: 7,291
- **Excel**: 4,611
- **Python**: 4,330
- **Tableau**: 3,745
- **Power BI**: 2,609


And here’s a table format:

Skill     | Demand Count
----------|---------------
SQL       | 7,291
Excel     | 4,611
Python    | 4,330
Tableau   | 3,745
Power BI  | 2,609

## 4. Which skills are associated with high salaries?
The data provides information on the average salaries associated with various technical skills. The salaries range from $42,500 to $82,576, with different tools and programming languages reflected in these figures.

Below is the code:
```sql
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
```

### Summary:
- **Lowest Salary**: Wire ($42,500)
- **Highest Salary**: Word ($82,576)
### Notable Points:
- Skills like Ruby on Rails, CSS, and Ruby have moderate average salaries, ranging between $51,059 and $61,780.
- Higher average salaries are seen in specialized skills such as Julia, Erlang, and various data visualization tools like ggplot2 and matplotlib.
- Collaboration and communication tools like Zoom, Webex, and SharePoint also command competitive average salaries.

Skill                               | Average Salary
------------------------------------|-----------------
Wire                                | 42,500.00
Ruby on Rails                       | 51,059.00
CSS                                 | 52,500.00
Ruby                                | 61,780.00
Visual Basic                        | 62,500.00
Smartsheet                          | 63,000.00
MongoDB                             | 66,020.00
Sass                                | 67,500.00
Colocation                          | 67,500.00

## 5. Which skills are associated with high salaries?

Below is the code:
```sql
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
```
### Summary
This data provides insights into the demand and average salaries for various technical skills. The skill "Go" has the highest average salary, followed closely by "Confluence" and "Hadoop." Skills like "Python" and "Tableau" show a high demand but with slightly lower average salaries compared to the top skills. The data reflects a broad spectrum of skills with varying demand and salary levels, indicating market preferences for certain technologies.

### Key Points
- Go commands the highest average salary at $115,320.
- Confluence and Hadoop also offer high average salaries above $113,000.
- Python and Tableau are among the most in-demand skills but have average salaries around $100,000.
- Skills such as AWS, Java, and SQL Server show a balance of demand and competitive salaries.

### Table of Skills, Demand, and Average Salary

Skill                               | Demand Count | Average Salary
------------------------------------|--------------|-----------------
Go                                  | 27           | $115,320
Confluence                          | 11           | $114,210
Hadoop                              | 22           | $113,193
Snowflake                           | 37           | $112,948
Azure                               | 34           | $111,225
BigQuery                            | 13           | $109,654
AWS                                 | 32           | $108,317
Java                                | 17           | $106,906
SSIS                                | 12           | $106,683
Jira                                | 20           | $104,918


# What I learned     

During my recent projects and studies, I've gained a deeper understanding and proficiency in several key areas of database management and SQL querying. Here’s a summary of what I’ve learned:

- **Advanced SQL Query Writing**: I developed skills in writing complex SQL queries, including the use of subqueries, common table expressions (CTEs), window functions, and advanced joins. This has allowed me to handle intricate data retrieval scenarios and perform more sophisticated data analysis.

- **Data Aggregation**: I learned how to effectively aggregate data using SQL functions such as GROUP BY, HAVING, and aggregate functions like SUM, AVG, COUNT, and MAX/MIN. This has enhanced my ability to summarize large datasets and extract meaningful insights from them.

- **PostgreSQL**: I gained hands-on experience with PostgreSQL, one of the most powerful and flexible relational database systems. I learned about its unique features, such as JSON support, powerful indexing options, and advanced data types. This knowledge has improved my ability to manage and optimize databases in a PostgreSQL environment.

These skills have significantly improved my ability to work with complex data structures, perform advanced data analysis, and manage relational databases efficiently.


# Conclusions

### Insights
Through my recent projects and studies, I’ve gained valuable insights into the intricacies of advanced SQL querying, data aggregation, and the capabilities of PostgreSQL. The ability to craft complex queries has empowered me to extract deeper insights from data, while mastering data aggregation techniques has enhanced my proficiency in summarizing and analyzing large datasets. My experience with PostgreSQL has provided me with a robust understanding of how to leverage this powerful database system to optimize data management and performance.

### Closing Thoughts
These experiences have not only expanded my technical skill set but also deepened my appreciation for the power of data in driving informed decisions. As I continue to build on these foundations, I am eager to apply this knowledge to future projects, contributing to data-driven solutions that can make a meaningful impact. I look forward to the challenges ahead and the opportunity to further refine and expand my expertise.