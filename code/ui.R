########################################
# DnD Spellbook                        #
# by Q.Jacquemin, A.Lanvin & R.Davies  #
# ui.R file                            #
########################################

library(leaflet)
library(shinydashboard)
library(collapsibleTree)
library(shinycssloaders)
library(DT)
library(tigris)
library(shinyjs)

###########
# LOAD UI #
###########

shinyUI(fluidPage(
  
  # load custom stylesheet
  includeCSS("www/style.css"),
  
  # remove shiny "red" warning messages on GUI
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  # load page layout
  dashboardPage(
    
    skin = "red",
      
    dashboardHeader(title="DnD SpellBook", titleWidth = 300),
    
    dashboardSidebar(width = 300,
      sidebarMenu(
        HTML(paste0(
          "<br>",
          "<a href='https://openclipart.org/download/224584/FightingSkeleton.svg' target='_blank'><img style = 'display: block; margin-left: auto; margin-right: auto;' src='FightingSkeleton.svg' width = '186'></a>",
          "<br>"
        )),
        menuItem("Home", tabName = "home", icon = icon("home")),
        menuItem("Spell Tree", tabName = "tree", icon = icon("tree")),
        menuItem("Spell Comparator", tabName = "comparator", icon = icon("glasses")),
        menuItem("Spell extractor", tabName = "extractor", icon = icon("database")),
        HTML(paste0(
          "<script>",
            "var today = new Date();",
            "var yyyy = today.getFullYear();",
          "</script>",
          "<br/>",
          "<p style = 'text-align: center;'><small>&copy; - <a href='https://dnd.wizards.com/' target='_blank'>https://dnd.wizards.com/</a> - <script>document.write(yyyy);</script></small></p>")
        ))
      ), # end dashboardSidebar
    
    dashboardBody(
      
      tabItems(
        
        tabItem(tabName = "home",
          # home section
          includeMarkdown("www/home.md")
          
        ),
        
        tabItem(tabName = "tree", 
          # collapsible spell tree section
          includeMarkdown("www/tree.md"),
          column(3, uiOutput("SelectClass")), #actionButton('flipButton', "Expand or Collapse Tree")),
          collapsibleTreeOutput('tree', height='1000px') %>% withSpinner(color = "red")
          
                
        ),
        
        tabItem(tabName = "comparator",
          # spell data comparator
          fluidRow(
            column(2, uiOutput("SelectClass1")),
            column(2, uiOutput("SelectLevel1")),
            column(2, uiOutput("SelectSpell1")),
            column(2, uiOutput("SelectClass2")),
            column(2, uiOutput("SelectLevel2")),
            column(2, uiOutput("SelectSpell2")),
          ),
          fluidRow(
            column(6,tableOutput("selection1")),
            column(6,tableOutput("selection2"))
          )
        ),
        
        tabItem(tabName = "extractor",
          # spell data extractor
          DT::dataTableOutput("spellsDataTable") %>% withSpinner(color = "red")
          
        )
        
       
              
      )
    
    ) # end dashboardBody
  
  )# end dashboardPage

))