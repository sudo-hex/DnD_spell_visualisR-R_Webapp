########################################
# DnD Spellbook                        #
# by Q.Jacquemin, A.Lanvin & R.Davies  #
# server.R file                        #
########################################

library(shiny)
library(tidyverse)
library(leaflet.extras)
library(rvest)
library(DT)

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
  
  ### TREE SERVER ###
  # tree class selector
  output$SelectClass<- renderUI({
    selectInput("selectedClass","Select a class:", classes)
  })

  spellTree <- reactive(spells_tidy %>% 
                            filter(classe1==input$selectedClass|classe2==input$selectedClass|classe3==input$selectedClass|classe3==input$selectedClass|
                                     classe4==input$selectedClass|classe5==input$selectedClass|classe6==input$selectedClass|classe7==input$selectedClass)
                )
  # collapsible tree
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


 ### COMPARATOR SERVER ###
  #FIRST SELECT
 # comp1 class selector
 output$SelectClass1 <- renderUI({
   selectInput("selectedClass1","Select a first class:", classes)
 })
 levels1 <- reactive(spells_tidy %>% 
                      filter(classe1==input$selectedClass1|classe2==input$selectedClass1|classe3==input$selectedClass1|classe3==input$selectedClass1|
                               classe4==input$selectedClass1|classe5==input$selectedClass1|classe6==input$selectedClass1|classe7==input$selectedClass1) %>% 
                      distinct(Level) %>% 
                      arrange(Level)
 )
 output$SelectLevel1 <- renderUI({
   selectInput("selectedLevel1","Select a first Level:", levels1())
 })
 spells1 <- reactive(spells_tidy %>% 
                      filter(classe1==input$selectedClass1|classe2==input$selectedClass1|classe3==input$selectedClass1|classe3==input$selectedClass1|
                               classe4==input$selectedClass1|classe5==input$selectedClass1|classe6==input$selectedClass1|classe7==input$selectedClass1) %>%
                      filter(Level==input$selectedLevel1) %>% 
                      distinct(name) %>% 
                      arrange(name)
 )
 # comp1 spell selector
 output$SelectSpell1 <- renderUI({
   selectInput("selectedSpell1","Select a first Spell:", spells1())
 })
 #output of 1st selection
 output$selection1 <- renderTable({
                  spell_select <- spells_tidy %>% 
                    filter(classe1==input$selectedClass1|classe2==input$selectedClass1|classe3==input$selectedClass1|classe3==input$selectedClass1|
                                   classe4==input$selectedClass1|classe5==input$selectedClass1|classe6==input$selectedClass1|classe7==input$selectedClass1) %>%
                    filter(Level==input$selectedLevel1 & name==input$selectedSpell1)
                  t(spell_select)
 }, rownames = T, colnames = F, striped = T, na= 'No information')
 
  #SECOND SELECT
 # comp2 class selector
 output$SelectClass2 <- renderUI({
   selectInput("selectedClass2","Select a second class:", classes)
 })
 levels2 <- reactive(spells_tidy %>% 
                      filter(classe1==input$selectedClass2|classe2==input$selectedClass2|classe3==input$selectedClass2|classe3==input$selectedClass2|
                               classe4==input$selectedClass2|classe5==input$selectedClass2|classe6==input$selectedClass2|classe7==input$selectedClass2) %>% 
                      distinct(Level) %>% 
                      arrange(Level)
 )
 output$SelectLevel2 <- renderUI({
   selectInput("selectedLevel2","Select a second Level:", levels2())
 })
 spells2 <- reactive(spells_tidy %>% 
                      filter(classe1==input$selectedClass2|classe2==input$selectedClass2|classe3==input$selectedClass2|classe3==input$selectedClass2|
                               classe4==input$selectedClass2|classe5==input$selectedClass2|classe6==input$selectedClass2|classe7==input$selectedClass2) %>%
                      filter(Level==input$selectedLevel2) %>% 
                      distinct(name) %>% 
                      arrange(name)
 )
 # comp1 spell selector
 output$SelectSpell2 <- renderUI({
   selectInput("selectedSpell2","Select a second Spell:", spells2())
 })
 #output of 1st selection
 output$selection2 <- renderTable({
   spell_select <- spells_tidy %>% 
     filter(classe1==input$selectedClass2|classe2==input$selectedClass2|classe3==input$selectedClass2|classe3==input$selectedClass2|
              classe4==input$selectedClass2|classe5==input$selectedClass2|classe6==input$selectedClass2|classe7==input$selectedClass2) %>%
     filter(Level==input$selectedLevel2 & name==input$selectedSpell2)
   t(spell_select)
 }, rownames = T, colnames = F, striped = T, na= 'No information')
 
 
 
 ###EXTRACTOR SERVER###
 # DT table
 output$spellsDataTable <- DT::renderDataTable(
   spells_tidy,
   extensions=c("Buttons","FixedHeader"),
   filter = "top",
   rownames = F,
   options = list(
     pageLength = 25,
     lengthMenu = c(5,10,15,20,25,50,100),
     autoWidth = T,
     scrollx = F,
     dom ='Blrtip',
     buttons = list(list(extend = 'csv', exportOptions = list(columns = ':visible')),
                    list(extend = 'excel', exportOptions = list(columns = ':visible')),
                    list(extend = 'pdf', exportOptions = list(columns = ':visible')),
                    list(extend = 'colvis', text = "Select columns")
     ),
     fixedHeader = T
   )
   
 )

})