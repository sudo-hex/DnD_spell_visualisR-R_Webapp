########################################
# DnD Spellbook                        #
# by Q.Jacquemin, A.Lanvin & R.Davies  #
# server.R file                        #
########################################

library(shiny)
library(tidyverse)
library(leaflet.extras)
library(rvest)

#####################
# SUPPORT FUNCTIONS #
#####################


######################
# DATA preprocessing #
######################

# tidy & enrich dataframes
load(file="./www/spell_info.rda")
spells_small <- spell_info %>% select(name, description, "Casting Time", Classes, Duration, Level, School)
spells_tidy <- 
  spells_small %>% 
  mutate(Classes = gsub(" ","",Classes)) %>% 
  separate(Classes, 
           into = c("classe1","classe2","classe3","classe4","classe5","classe6","classe7"), sep = ",") %>% 
  mutate(classe1= ifelse(is.na(classe1),"All",classe1)) %>% 
  arrange(Level) %>% 
  mutate(Level = ifelse(Level == 0,"Cantrip", paste0("Spell level : ", Level)))


# support dataframes
classes <- spells_tidy %>% distinct(classe1) %>% arrange(classe1)

################
# SERVER LOGIC #
################

shinyServer(function(input, output) {
  
  # collapsible tree
  output$SelectClass<- renderUI({
    selectInput("selectedClass","Select a class:", classes)
  })

  spellTree <- reactive(spells_tidy %>% 
                            filter(classe1==input$selectedClass|classe2==input$selectedClass|classe3==input$selectedClass|classe3==input$selectedClass|
                                     classe4==input$selectedClass|classe5==input$selectedClass|classe6==input$selectedClass|classe7==input$selectedClass)
                )
  
  output$tree <- renderCollapsibleTree(
    collapsibleTree(
      spellTree(),
      tooltip = T,
      #attribute = "description",
      root = input$selectedClass,
      hierarchy = c("Level", "School","name"),
      fill = "Red",
      zoomable = FALSE
    )
  )

 # DT table
 output$spellsDataTable <- renderDataTable(
   spells_tidy,
   filter = "top",
   
 )


})