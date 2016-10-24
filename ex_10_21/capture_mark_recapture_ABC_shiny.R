library(shiny)


shinyApp(
  ui = fluidPage(
    titlePanel("Capture-Mark-Recapture"),
    sidebarPanel(
      numericInput("n_sims","Number of simulations to run:", value=10000, min=1000, max=1e6),
      hr(),
      h4("Data:"),
      sliderInput("n_marked","Number of marked fish:", value=5, min=1, max=20),
      sliderInput("n_recaptured","Number of recaptured fish:", value=10, min=1, max=20),
      sliderInput("n_recap_marked","Number of recaptured marked fish:", value=3, min=1, max=10),
      hr(),
      h4("Prior:"),
      selectInput("prior", "Prior for population total:", c("Uniform"="unif", "Poisson"="pois")),
      hr(),
      h4("Hyper parameters:"),
      conditionalPanel(
        condition = "input.prior == 'unif'",
        sliderInput("unif_range", "Total prior - range:", value=c(10,100), min=10, max=100)
      ),
      conditionalPanel(
        condition = "input.prior == 'pois'",
        sliderInput("pois_lambda", HTML("Total prior - &lambda;:"), value=35, min=10, max=100)
      )
    ),
    mainPanel(
      h4("Results:"),
      plotOutput("posterior_plot"),
      br(),
      textOutput("messages")
    )
  ),
  server = function(input, output, session) 
  {
    observe({
      updateSliderInput(session, inputId = "n_recap_marked", max = input$n_marked)
    })
    
    
    prior_samps = reactive(
    {
      if (input$prior == "unif")
      {
        unif_min = input$unif_range[1]
        unif_max = input$unif_range[2]
        
        return(sample(unif_min:unif_max, input$n_sims, replace = TRUE))
      }
      else if (input$prior == "pois")
      {
        return( rpois(input$n_sims, input$pois_lambda) )
      }
      else
      {
        stop()
      }
    })
    
    # Generate simulated data
    sim_data = reactive(
    {
      gen_model = function(n_total)
      {
        marked = rep(1, input$n_marked)
        unmarked = rep(0, n_total-input$n_marked)
        
        pop = c(marked, unmarked)
        
        sum(sample(pop, input$n_recaptured, replace=FALSE))
      }  
      
      sim_data = sapply(prior_samps(), gen_model)
    })
      
    ?updateSelectInput
    post_draws = reactive(
    {
      prior_samps()[ sim_data() == input$n_recap_marked ]
    })
    
    output$posterior_plot = renderPlot(
    {
      plot(density(post_draws()))
    
      n = 10:100
      if (input$prior == "unif") {
        lines(n, rep(1/length(n),length(n)), col='red')
      } else if (input$prior == "pois") {
        lines(n, dpois(n,lambda = input$pois_lambda),col='red')
      }    
    })
  },
  options = list(width = 1000)
)
