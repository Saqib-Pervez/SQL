-- Data Analysis for Covid Deaths from Covid-19 from Jan 2020 - Apr 2023 of Canada
 
 
/* 1. Covid-19 Worldwide
   */
   
   
Select   Sum(new_cases) as total_cases, Sum(new_deaths) as total_deaths, Sum(new_deaths)/Sum(new_cases)*100 as death_percentage
From covid_deaths
Order by 1, 2



/* 2. Looking into Total Deaths country wise 
	Showing max death count
   */


Select location, Max(total_deaths) as total_death_count
From covid_deaths
Where continent is not null
Group by location
Order by total_death_count desc 


-- 3. Looking into Covid Deaths data from Canada

Select * 
From covid_deaths
Where location = 'Canada'


/* 4. Looking Avg deaths 
      */
      
Select Avg(total_deaths) as avg_deaths, date
From covid_deaths
Where location = 'Canada'
Group By total_deaths, date


/* 5. Looking at Tota Deaths vs Total cases
      Showing likelihood of getting died if caught by Covid
      */

Select location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as death_percentage
From covid_deaths
Where location = 'Canada'


/* 6. Looking at Total Cases Vs Population
 	  Showing percentage of population got covid on a given day
      */

Select location, date, total_cases, population, (total_cases/population)*100 as population_percentage
From covid_deaths
Where location = 'Canada'


/* 7. Looking New Death count in Canada
      Showing Total Death count
      */

Select date, new_deaths, total_deaths
From covid_deaths
Where location = 'Canada'
Group by total_deaths, new_cases, date, new_deaths, location
order by total_deaths desc

/* 8. Looking into ICU Patients vs New Deaths 
	  Chances of death if admitted in ICU
      */

Select date, icu_patients, new_deaths, (new_deaths/icu_patients)*100 as '%deaths_icu'
From covid_deaths
Where location = 'Canada'
Group by icu_patients, new_deaths, date
Order by icu_patients desc

/* 9. Looking into Hospitalized Patients vs New Deaths
	  Chances of death if hospitalized
      */
Select hosp_patients, date, new_deaths, (new_deaths/hosp_patients)*100 as '%deaths_hosp'
From covid_deaths
Where location = 'Canada'
Group by hosp_patients, date, new_deaths
Order by hosp_patients desc


/* 10.  Joining Tables covid_deaths and covid_vacs
   */
Select * 
From covid_deaths as deaths
Join covid_vacs as vacs
On deaths.location = vacs.location
and deaths.date = vacs.date


/* 11. Looking at Total Population vs Vaccinations Worldwide
   Showing percentage of population vaccinated
   */
   
   
Select deaths.continent, deaths.location, deaths.date, deaths.population, vacs.new_vaccinations, 
Sum(new_vaccinations) Over(Partition by deaths.location Order by deaths.location, deaths.date) as people_vaccinated
From covid_deaths as deaths
Join covid_vacs as vacs
On deaths.location = vacs.location
and deaths.date = vacs.date
Where deaths.continent is not null
Order by 2,3


/* 12. Looking at Total Population vs Vaccinations in Canada
   Showing percentage of population vaccinated using CTE
   */
   
With PopvsVacs (location, date, population, new_vaccinations, people_vaccianted)
as
(
Select deaths.location, deaths.date, deaths.population, vacs.new_vaccinations, 
Sum(new_vaccinations) Over(Partition by deaths.location Order by deaths.location, deaths.date) as people_vaccinated
From covid_deaths as deaths
Join covid_vacs as vacs
	On deaths.location = vacs.location
	and deaths.date = vacs.date
Where deaths.location = 'Canada'
)
Select *, (people_vaccianted/population)*100 as 'percenatage_vaccinations'
From PopvsVacs
