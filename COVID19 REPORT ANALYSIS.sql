USE Covid19Report

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--GLOBAL SUMMARY

SELECT  Date, MAX (total_cases) AS Total_Cases, MAX (CAST (total_deaths AS INT)) AS Total_Deaths, 
		MAX (CAST (total_deaths AS INT))/ MAX (total_cases)*100 AS Death_Percentage, 
		MAX (ROUND ((total_cases/population)*100,1)) AS Infection_Percentage
FROM CovidDeaths
GROUP BY date
ORDER BY 2 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Death rate by Date

SELECT Date, continent, location, population, total_deaths, ROUND ((total_deaths/total_cases)*100,2) AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Infection rate by Date

SELECT date, continent, location, population, total_cases, ROUND ((total_cases/population)*100,2) AS InfectionPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Infection by Continent

SELECT Date, location, population, MAX (total_cases) AS InfectionCount, MAX (ROUND ((total_cases/population)*100,2)) AS infectionpercentage
FROM CovidDeaths
WHERE continent IS NULL AND location NOT IN ('World', 'high income', 'upper middle income', 'lower middle income', 'European union', 'low income', 'international')
GROUP BY location, population, Date
ORDER BY InfectionCount DESC
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Infection by country

SELECT Date,location, population, MAX (total_cases) AS InfectionCount, MAX (ROUND ((total_cases/population)*100,2)) AS infectionpercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population, date
ORDER BY InfectionCount DESC

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Death per Population by Country

SELECT Date, location, population, MAX (CAST (Total_Deaths AS INT)) AS DeathCount, MAX (ROUND ((total_deaths/population)*100,2)) AS Deathpercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population, Date
ORDER BY DeathCount DESC

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Death per Population by Continent 

SELECT Date, location AS Continent, MAX (CAST (Total_Deaths AS INT)) AS DeathCount, MAX (ROUND ((total_deaths/population)*100,2)) AS Deathpercentage
FROM CovidDeaths
WHERE continent IS NULL AND location NOT IN ('World', 'high income', 'upper middle income', 'lower middle income', 'European union', 'low income', 'international')
GROUP BY location, Date
ORDER BY DeathCount DESC


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Vaccination Percentage

SELECT D.date, D.location, D.population, V.total_vaccinations,
		MAX (CONVERT(INT, V.total_vaccinations))/ (D.population)* 100 AS VaccinationPercentage
		
FROM CovidDeaths D
JOIN CovidVaccinations V
ON D.date = V.date  
AND D.location = V.location
WHERE D.continent IS NOT NULL AND D.location NOT IN ('World', 'high income', 'upper middle income', 'lower middle income', 'European union', 'low income', 'international')
GROUP BY  D.location, D.population, V.total_vaccinations, D.date
ORDER BY 2

