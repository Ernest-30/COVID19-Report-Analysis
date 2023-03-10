USE Covid19Report

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--GLOBAL SUMMARY
SELECT SUM(new_cases) AS Total_Cases,SUM (CAST (new_deaths AS INT)) AS Total_Deaths,
		SUM ( DISTINCT population) AS Total_Population, SUM(CAST(new_cases AS INT))/SUM ( DISTINCT population)*100 AS Infection_Percentage,
		 SUM (CAST(new_deaths AS INT)) /SUM(new_cases)*100 AS Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Death rate by Date by Continent

SELECT Date, Continent,SUM (CAST(new_deaths AS INT)) AS Total_Deaths
FROM CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY  continent,date
ORDER BY 1 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Infection rate by Date by Continent

SELECT date, continent, SUM(new_cases) AS Total_Cases
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date, continent, total_cases
ORDER BY 1

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Infection by Continent

SELECT Date, Continent, SUM (new_cases) AS Infection_Count, SUM(CAST(new_cases AS INT))/SUM ( DISTINCT population)*100 AS Infection_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent, Date
ORDER BY Infection_Count DESC

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Infection by country

SELECT Date,location, SUM (new_cases) AS Infection_Count, SUM(CAST(new_cases AS INT))/SUM ( DISTINCT population)*100 AS Infection_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, date
ORDER BY Infection_Count DESC

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Death by Country

SELECT Date, location, SUM (CAST (new_deaths AS INT)) AS Death_Count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, Date
ORDER BY Death_Count DESC

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Death by Continent 

SELECT Date,location AS Continent,SUM (CAST (new_deaths AS INT)) AS Death_Count
FROM CovidDeaths
WHERE continent IS NULL AND location NOT IN ('world', 'High income','Upper middle income','Lower middle income','European Union','International','International','Low Income')
GROUP BY location, Date
ORDER BY Death_Count DESC


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Vaccination Percentage

SELECT D.continent, D.location,(CONVERT (INT,V.new_vaccinations)) AS Vaccinations , 
	MAX (CONVERT(INT, V.new_vaccinations))/ D.population *100 AS VaccinationPercentage
		
FROM CovidDeaths D
JOIN CovidVaccinations V
ON D.date = V.date  
AND D.location = V.location
WHERE D.continent IS NOT NULL
GROUP BY D.continent, population, D.location, V.new_vaccinations
ORDER BY 3 DESC



