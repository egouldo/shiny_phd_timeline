#shiny_timeline_app

# Define Timeline
suppressPackageStartupMessages(library(timevis))
suppressPackageStartupMessages(library(dplyr))

timeline_items <- data_frame(
        content = c("PhD start",
                    "Establish Advisory Committee",
                    "Advisory Committee Meeting", 
                    "RIOT (Research Integrity Online Training)",
                    "Prepare Research Proposal",
                    "PhD end"),
        start = c("2017-11-22",
                  "2018-02-22",
                  "2018-02-22",
                  "2018-02-22",
                  "2018-02-22",
                  "2021-11-22"),
        end = c(NA,
                NA,
                "2018-05-22", 
                "2018-05-22",
                "2018-02-22",
                NA),
        group = c(1,2,2,2,2,1)
) %>%
        dplyr::mutate(id = 1:n())

timeline_groups <- data_frame(
        content = c(
                "General",
                "First Committee Meeting"
        )
) %>% dplyr::mutate(id = 1:n())


# SHINY
library(shiny)
library(timevis)

ui <- fluidPage(
        timevisOutput("mytime"),
        actionButton("btn", "Centre Item")
)

server <- function(input, output, session) {
        output$mytime <- renderTimevis(timevis(data = timeline_items, groups = timeline_groups))
        observeEvent(input$btn, {
                addItem("mytime", list(id = "item1", content = "one", start = "2018-01-01"))
                centerItem("mytime", "item1")
        })
}

shinyApp(ui = ui, server = server)
