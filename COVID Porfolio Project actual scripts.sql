SELECT * FROM 
PortfolioProject1..CovidDeaths
order by 3,4

--SELECT * FROM 
--PortfolioProject1..CovidVaccinations
--order by 3,4
SELECT Location, date, total_cases, new_cases, total_deaths, population 
from PortfolioProject1..CovidDeaths
order by 1,2

----------looking at Total Cases vs Total Deaths


	SELECT Location, date, total_cases, total_deaths,(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
	from PortfolioProject1..CovidDeaths
	order by 1,2


	SELECT Location, date, total_cases, total_deaths,(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
	from PortfolioProject1..CovidDeaths
	where location like '%india%'
	order by 1,2

	-----Likelihood of dying if u contract covid in your country -----
	-----looking at total Cases Vs Population
	------shows what percentage of population got covid
	SELECT Location, date, total_cases,population, (CONVERT(float, total_cases ) / NULLIF(CONVERT(float, population), 0))*100 as DeathPercentage
	from PortfolioProject1..CovidDeaths
	where location like '%states%'
	order by 1,2

	SELECT Location, date, total_cases,population, (CONVERT(float, total_cases ) / NULLIF(CONVERT(float, population), 0))*100 as DeathPercentage
	from PortfolioProject1..CovidDeaths
	order by 1,2


	----Looking at countries with highest infection rate Comapred to population
	SELECT Location, max( total_cases)  as HighestInfectionCount, population, MAx((CONVERT(float, total_cases ) / NULLIF(CONVERT(float, population), 0)))*100 as PercentPopulationInfected
	from PortfolioProject1..CovidDeaths
	group by Location, Population
	order by PercentPopulationInfected desc


	-----Showing Countries with Highest Death Count per Population
	SELECT Location,MAX(cast( total_deaths as int)) as TotalDeathCount
	from PortfolioProject1..CovidDeaths
	---where location like '%states%'
	GROUP BY Location
	order by TotalDeathCount desc

	SELECT Location, MAX(cast( total_deaths as int)) as TotalDeathCount FROM 
PortfolioProject1..CovidDeaths
where continent is not null
group by Location
order by TotalDeathCount desc




-----Let's break things down by continent


SELECT continent, MAX(cast( total_deaths as int)) as TotalDeathCount FROM 
PortfolioProject1..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc



SELECT location, MAX(cast( total_deaths as int)) as TotalDeathCount FROM 
PortfolioProject1..CovidDeaths
where continent is  null
group by location
order by TotalDeathCount desc




-----


SELECT * FROM 
PortfolioProject1..CovidDeaths
where continent is not null
order by 3,4


----SHOWING THE CONTINENT WITH THE HIGHEST DEATH RATE
 SELECT continent , max(cast(total_deaths as int)) as HighDeathRate
 from PortfolioProject1..CovidDeaths
 where continent is not null
 group  by continent 
 order by HighDeathRate desc

 
 ------GLOBAL NUMBERS----

 Select   date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
 from PortfolioProject1..CovidDeaths
 ----where location like '%india%'
 where continent is not null
 group by date
 order by 1,2 





 Select   date, SUM(new_cases)---, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
 from PortfolioProject1..CovidDeaths
 ----where location like '%india%'
 where continent is not null
 group by date
 order by 1,2 

  Select   date, SUM(new_cases), SUM(new_deaths)---, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
 from PortfolioProject1..CovidDeaths
 ----where location like '%india%'
 where continent is not null
 group by date
 order by 1,2 


  Select   date, SUM(new_cases), SUM(cast(new_deaths as int))---, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
 from PortfolioProject1..CovidDeaths
 ----where location like '%india%'
 where continent is not null
 group by date
 order by 1,2 
 
 ----(CONVERT (float, SUM(New_deaths)/ NULLIF(CONVERT (float,SUM(New_cases)),0))*100 
   Select   date, SUM(cast(new_cases as int)), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int ))/SUM(cast(new_cases as int))* 100 as DeathPercentage
 from PortfolioProject1..CovidDeaths
 ----where location like '%india%'
 where continent is not null
 group by date
 order by 1,2
 
 Select   date, SUM(cast(new_cases as int)) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, (CONVERT (float, SUM(New_deaths))/ NULLIF(CONVERT (float,SUM(New_cases)),0))*100 as DeathPercentage
 from PortfolioProject1..CovidDeaths
 ----where location like '%india%'
 where continent is not null
 group by date
 order by 1,2

  Select  SUM(cast(new_cases as int)) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, (CONVERT (float, SUM(New_deaths))/ NULLIF(CONVERT (float,SUM(New_cases)),0))*100 as DeathPercentage
 from PortfolioProject1..CovidDeaths
 ----where location like '%india%'
 where continent is not null
 ---group by date
 order by 1,2


SELECT * FROM PortfolioProject1..CovidVaccinations

---Looking at Total Population Vs Vaccinations

SELECT * 
FROM PortfolioProject1..CovidDeaths dea
JOIN PortfolioProject1..CovidVaccinations vac
ON dea.location = vac.location 
and dea.date = vac.date


SELECT dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
FROM PortfolioProject1..CovidDeaths dea
JOIN PortfolioProject1..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3


SELECT dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(CAST( vac.new_vaccinations AS bigint )) OVER (Partition by dea.location)
FROM PortfolioProject1..CovidDeaths dea
JOIN PortfolioProject1..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

SELECT dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(CAST( vac.new_vaccinations AS bigint )) OVER (Partition by dea.location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM PortfolioProject1..CovidDeaths dea
JOIN PortfolioProject1..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

-----USE CTE-----------
with PopvsVac (Continent, loaction, Date ,population, new_vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(CAST( vac.new_vaccinations AS bigint )) OVER (Partition by dea.location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM PortfolioProject1..CovidDeaths dea
JOIN PortfolioProject1..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
---order by 2,3
)

SELECT* ,(RollingPeopleVaccinated/population)* 100 FROM PopvsVac

-----TEMP TABLE----------
DROP TABLE if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(CAST( vac.new_vaccinations AS bigint )) OVER (Partition by dea.location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM PortfolioProject1..CovidDeaths dea
JOIN PortfolioProject1..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
---order by 2,3

SELECT * , (RollingPeopleVaccinated/Population)* 100
from #PercentPopulationVaccinated

----CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION

CREATE  VIEW PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(CAST( vac.new_vaccinations AS bigint )) OVER (Partition by dea.location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM PortfolioProject1..CovidDeaths dea
JOIN PortfolioProject1..CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
---order by 2,3

SELECT * from PercentPopulationVaccinated
