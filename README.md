# More than just Amazon - Immigration in Seattle 2010-17

## Project Summary
Over the last decade, Seattle has become one of the fastest growing areas in the country.  EPCW is mapping immigration patterns over this time in the Seattle Metropolitan Statistical Area to help people understand the ways that in-migration has contributed to the growth and richness of the region.

## [Project webpage](https://equitableworld.org/research/immigration-seattle/)

## Key questions
- What would Seattle look like, without any immigration?
- How much does the Puget Sound region’s economic, social, and cultural map depend on arrivals from elsewhere?
- How much would economic output change if, for instance, a wall was constructed to keep out everyone not born in the USA?

## Researchers
@pkwzimm & @rwsharp

## repo contents
This repo contains the  code used to fetch data from the US Census (the [American Community Survey 5-year data](https://www.census.gov/data/developers/data-sets/acs-5year.html), specifically) and the raw data pulled from that source, combined with data from the [Federal Financial Institutions Examination Council](https://www.ffiec.gov/).

### Code files
- seattle-msa-census-tract.sh - pulls tract-level data from the ACS.  Can be modified with whatever variables and geographies you want.  Replace INSERTYOURKEYHERE in the code with an API key (free from the US Census - signup [here](https://api.census.gov/data/key_signup.html))
- tracts.txt - list of tracts used by the script above (in order to modify this, you will need **tract**, **county**, and **state** info for each tract for which you want data)

### raw data files
- seattle-immigrant-pop-tract.txt - text file listing county, tract code, and several population measures for the Seattle Metropolitan Statistical Area: Total population, foreign-born population, and naturalized citizen population.
- seattle-msa-tract-level-economic-data.csv - Combines the above dataset with median household income and ownership stats from the FFIEC.
