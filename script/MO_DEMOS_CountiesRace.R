# Create MO_DEMOS_CountiesRace

## Introduction
## This script creates the shapefile MO_DEMOS_JeffCityRegion

## Dependencies
library(dplyr)
library(ggplot2)
library(here)
library(sf)
library(tidycensus)
library(tigris)

## Create combined census tract object
### download all Missouri tracts
moCounties <- counties("MO", cb = TRUE)

### convert to sf object
moCounties <- st_as_sf(moCounties)

### download census tract data
countyDemos <- get_acs(geography = "county",  state = "MO", output = "wide", table = "B02001")

### combine spatial and geometric data
moDemos <- left_join(moCounties, countyDemos, by = "GEOID")

### write shapefile
st_write(moDemos, here("Shapefile", "MO_DEMOS_CountiesRace.shp"), delete_dsn = TRUE)
