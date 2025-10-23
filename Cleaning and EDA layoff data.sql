-- execute once 
-- create database layoffs
-- use layoffs;

-- Creating a temporary table for data processing so that it does not affect raw data
select * from layoffs;

create table layoff_staging
like layoffs; 

insert into layoff_staging
select * from layoffs;

-- Removing Duplicates
-- using partition by to find duplicates

with duplicate_cte as (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
as row_num
from layoff_staging
)
select * from duplicate_cte
where row_num > 1;

-- staging two does not contain any duplicate
CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoff_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
as row_num
from layoff_staging;

select * from layoff_staging2
where row_num > 1; 

delete from layoff_staging2
where row_num > 1;

-- Standardizing Data 

-- Trimming the whitespace from company  column
update layoff_staging2 
set company = trim(company);

-- industry and filling the blank values if possible
select distinct industry 
from
layoff_staging2; -- Crypto currency is written two times in different ways  crypto, crypto currency and CryptoCurrency are all same

-- fixing it 

select * from layoff_staging2
where industry like 'Crypto%';  -- making every alias as crypto as crypto occurs more frequently

update layoff_staging2
set industry = 'Crypto'
where industry = 'Crypto Currency' 
or
industry = 'CryptoCurrency';


select * from layoff_staging2  -- airbnb carvana juul have blank values, bally`s interactive has a null
where industry =''				-- airbnb --> travel industry
or industry is null;

-- using self join to determine flaws and update it  

select t1.company,t1.industry,t2.company,t2.industry from 
layoff_staging2 t1
join layoff_staging2 t2
	on t1.company = t2.company
where t1.industry is null or t1.industry =''
and t2.industry is not null; 

update layoff_staging2
set industry = null -- setting every blank value to null to make updating easy
where industry = '';

update layoff_staging2 t1 
join layoff_staging2 t2
	on t1.company = t2.company
set t1.industry =  t2.industry
where t1.industry is null
and t2.industry is not null;


-- location
select distinct location from layoff_staging2;


-- country

-- there are two united states and united states.
select distinct country,trim(trailing '.' from country )from layoff_staging2;

-- fixing it 
-- now there will be a single United States
update layoff_staging2 
set country = 'United States'
where country like 'United%';

-- updating the date column to datetime format which by default set to text 

update layoff_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y'); -- changed the date format to the one sql follows 

-- modifying the data type to date
alter table layoff_staging2
modify `date` date;

desc layoff_staging2;  -- to verify  

select * from layoff_staging2
where `date` is null;-- one date is null

-- toatl laid offf
select * from layoff_staging2;

-- the companies which have total laid off and percentage laid off as null are not relevant to us as they didnt lay off anybody

select * from layoff_staging2
where total_laid_off is null
and percentage_laid_off is  null;

delete from 
layoff_staging2
where total_laid_off is null
and percentage_laid_off is  null;

alter table layoff_staging2
drop column row_num;

select * from 
layoff_staging2;


-- this is the final table ready for EDA


-- --> EDA on the above data set layoff_staging2

select max(total_laid_off),max(percentage_laid_off)
from layoff_staging2;

-- top 10 companies that had the most lay offs in
select company,sum(total_laid_off) 
from layoff_staging2
group by company
order by 2 desc
limit 10;

-- which industry had the most layoffs from the top 10

select industry,sum(total_laid_off)
from layoff_staging2
group by industry
order by 2 desc
limit 10;

-- which country has the most layoffs

select country,sum(total_laid_off)
from layoff_staging2
group by country
order by 2 desc;

-- which year had the most lay offs

select year(`date`),sum(total_laid_off)
from layoff_staging2
group by year(`date`)
order by 1 desc;












 
 
 
 
 
 
 
 
 
 