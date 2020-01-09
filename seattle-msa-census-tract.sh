#!/bin/bash

##Queries the US Census's 5-year American Community survey API for info.  Replace query array with desired variables, and add the appropriate q_human translations at the bottom.  You will need to apply for a (free) US Census API key and replace the key below with yours  List of census tracts -https://www.ffiec.gov/census/

#usage: ./acs1-immigrant.sh

#backup old files
mkdir -p archive
files="seattle-immigrant-pop-tract.txt"
for f in $files
do
mv $f archive/$f
done

while read line;
do

query=( "B01001_001E" "B05002_013E" "B05002_014E" ) #total pop, foreign-born pop, naturalized citizens pop
#query=( "B01002_001E" ) #single query commented out for testing purposes

for q in  "${query[@]}" #loop over query array
do

#set dataset & year range
dataset="acs5"
for y in {2010..2017} #loop over year range
do

#url="https://api.census.gov/data/2016/acs/acs5?get=NAME,B01001_001E&for=congressional%20district:03&in=state:26"
url="https://api.census.gov/data/$y/acs/$dataset?get=NAME,$q&for=tract:$line&key=INSERTYOURKEYHERE" #insert the query and congressional district strings into the API call
#url="https://api.census.gov/data/$year/acs/$dataset?get=NAME,$q$i"
page=$(curl -sL "$url" ) #curl the census API

data=$(echo $page | grep -ioP "(?s)(?<=[a-z]\"\,\")\d.*?(?=\"\,\"\d\d\"\,\"\d\d)") #extract just the query result from json package (after the state name, before the state FIPS and district FIPS)

######BEGIN HUMAN-READABLE LABEL SECTION - copy this pattern for whatever variables and locations that apply to your project#####
#translate states and districts into English
tract_num=$(echo $line | grep -ioP "^\d\d\d\d\d\d(?=\&in\=state)") #pull tract number

if [[ "$line" =~ 033$ ]];
then
  county_name="King"
fi
if [[ "$line" =~ 061$ ]];
then
  county_name="Snohomish"
fi
if [[ "$line" =~ 053$ ]];
then
  county_name="Pierce"
fi

#translate UC Census variables into English
if [ "$q" == "B01001_001E" ]
then
  q_human="total_pop"
fi
if [ "$q" == "B05002_013E" ]
then
  q_human="foreign_born_pop"
fi
if [ "$q" == "B05002_014E" ]
then
  q_human="naturalized_citizen_pop"
fi
######END LABEL SECTION#####

echo "$county_name | $tract_num | $data | $q_human | $dataset | $y" #output to sdout
echo "$county_name|$tract_num|$data|$q_human|$dataset|$y" >> seattle-immigrant-pop-tract.txt #output to pipe-separated text file.

done
done
done<tracts.txt
