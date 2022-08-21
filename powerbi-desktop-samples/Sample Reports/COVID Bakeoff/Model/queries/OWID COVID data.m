let
    Source = Csv.Document(Web.Contents("https://covid.ourworldindata.org/data/owid-covid-data.csv"),[Delimiter=",", Columns=59, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"iso_code", type text}, {"continent", type text}, {"location", type text}, {"date", type date}, {"total_cases", Int64.Type}, {"new_cases", Int64.Type}, {"new_cases_smoothed", type number}, {"total_deaths", Int64.Type}, {"new_deaths", Int64.Type}, {"new_deaths_smoothed", type number}, {"total_cases_per_million", type number}, {"new_cases_per_million", type number}, {"new_cases_smoothed_per_million", type number}, {"total_deaths_per_million", type number}, {"new_deaths_per_million", type number}, {"new_deaths_smoothed_per_million", type number}, {"reproduction_rate", type number}, {"icu_patients", type number}, {"icu_patients_per_million", type number}, {"hosp_patients", type number}, {"hosp_patients_per_million", type number}, {"weekly_icu_admissions", type number}, {"weekly_icu_admissions_per_million", type number}, {"weekly_hosp_admissions", type number}, {"weekly_hosp_admissions_per_million", type number}, {"new_tests", type number}, {"total_tests", type number}, {"total_tests_per_thousand", type number}, {"new_tests_per_thousand", type number}, {"new_tests_smoothed", type number}, {"new_tests_smoothed_per_thousand", type number}, {"positive_rate", type number}, {"tests_per_case", type number}, {"tests_units", type text}, {"total_vaccinations", type number}, {"people_vaccinated", type number}, {"people_fully_vaccinated", type number}, {"new_vaccinations", type number}, {"new_vaccinations_smoothed", type number}, {"total_vaccinations_per_hundred", type number}, {"people_vaccinated_per_hundred", type number}, {"people_fully_vaccinated_per_hundred", type number}, {"new_vaccinations_smoothed_per_million", type number}, {"stringency_index", type number}, {"population", Int64.Type}, {"population_density", type number}, {"median_age", type number}, {"aged_65_older", type number}, {"aged_70_older", type number}, {"gdp_per_capita", type number}, {"extreme_poverty", type number}, {"cardiovasc_death_rate", type number}, {"diabetes_prevalence", type number}, {"female_smokers", type number}, {"male_smokers", type number}, {"handwashing_facilities", type number}, {"hospital_beds_per_thousand", type number}, {"life_expectancy", type number}, {"human_development_index", type number}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{
        {"total_cases", "Total cases"},
        {"new_cases", "New cases"}, {"new_cases_smoothed", "New cases smoothed"}, {"total_deaths", "Total deaths"}, {"new_deaths", "New deaths"}, {"new_deaths_smoothed", "New deaths smoothed"}, {"total_cases_per_million", "Total cases per million"}, {"new_cases_per_million", "New cases per million"}, {"new_cases_smoothed_per_million", "New cases smoothed per million"}, {"total_deaths_per_million", "Total deaths per million"}, {"new_deaths_per_million", "New deaths per million"}, {"new_deaths_smoothed_per_million", "New deaths smoothed per million"}, {"reproduction_rate", "Reproduction rate"}, {"icu_patients", "ICU patients"}, {"icu_patients_per_million", "ICU patients per million"}, {"hosp_patients", "Hospital patients"}, {"hosp_patients_per_million", "Hospital patients per million"}, {"weekly_icu_admissions", "Weekly ICU admissions"}, {"weekly_icu_admissions_per_million", "Weekly ICU admissisions per million"}, {"weekly_hosp_admissions_per_million", "Weekly hospital admissions per million"},{"total_tests_per_thousand", "Total tests per thousand"}, {"new_tests_per_thousand", "New tests per thousands"}, {"total_vaccinations_per_hundred", "Total vaccinations per hundred"}, {"people_vaccinated_per_hundred", "People vaccinated per hundred"}, {"people_fully_vaccinated_per_hundred", "People fully vaccinated per hundred"}, {"new_vaccinations_smoothed_per_million", "New vaccinations smoothed per million"}, {"population", "Population"}, {"population_density", "Population density"}, {"median_age", "Median age"}, {"aged_65_older", "Aged 65 and older"}, {"aged_70_older", "Aged 70 and old"}, {"gdp_per_capita", "GDP per capita"}, {"extreme_poverty", "Extreme poverty"}, {"cardiovasc_death_rate", "Cardiovascular death rate"}, {"diabetes_prevalence", "Diabetes prevalence"}, {"female_smokers", "Female smoking rate"}, {"male_smokers", "Male smoking rate"}, {"handwashing_facilities", "Handwashing facilities availalbe"}, {"hospital_beds_per_thousand", "Hospital beds per thousand"}, {"life_expectancy", "Life expectancy"}

    })
in
    #"Renamed Columns"