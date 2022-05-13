#' unad UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_unad_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      actionButton(
        inputId =  ns("go"),
        label = "Go"
      ),
      verbatimTextOutput(
        outputId = ns("test")
      )
    )
  )
}

#' unad Server Functions
#'
#' @noRd
mod_unad_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    data <- reactiveValues(
      con = con
    )


    observe({

      data$go <- input$go

    }) |> bindEvent(input$go)


    output$test <-
      shiny::renderPrint({

        data$go

      })



  })
}

## To be copied in the UI
# mod_unad_ui("unad_1")

## To be copied in the server
# mod_unad_server("unad_1")
