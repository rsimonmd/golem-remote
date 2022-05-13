#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  data <- reactiveValues(
    con = con
  )


  observe({

    data$go <- input$go

  }) |> bindEvent(input$go)

  tbl_reactive <-
    reactive({

      con <- data$con

      con_spec <- pool::poolCheckout(con)

      mytbl_random <-
        dplyr::tbl(con_spec, "testtbl") |>
        dplyr::filter(var2 == "a") |>
        dplyr::slice_sample(n = 100)

      df <- dbplyr::sql_render(
        mytbl_random
      )

      check <-
        DBI::dbExistsTable(
          con,
          "smoltbl"
        )

      if(check){
        DBI::dbRemoveTable(
          con,
          name = "smoltbl"
        )
        dropped <- TRUE
      }else{
        dropped <- TRUE
      }

      if((check & dropped) | !check){
        DBI::dbExecute(
          con,
          statement = glue::glue("CREATE TABLE smoltbl AS {df}")
        )
      }else{warning("pas cool")}

      res <-
        mytbl_random |>
        dplyr::collect()

      pool::poolReturn(con_spec)

      return(res)

    })|> bindEvent(data$go)


  output$test <-
    shiny::renderPrint({

      c(
        data$go,
        tbl_reactive()
      )

    })

  session$onSessionEnded(function(){

    cat("finito session\n")

  })

  onStop(function(){

    stopApp()

    cat("finito server\n")

  })


}
