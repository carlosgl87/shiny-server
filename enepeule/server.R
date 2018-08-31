function(session, input, output){
  
  # Codigo de vendedor en el URL 
  re <- reactive({
    query <- parseQueryString(session$clientData$url_search)
    userID = query$userID
    req(userID %in% lista_vendedores) 
    cuotas_prueba <- data_cuotas %>% filter(CO_VEND == userID & GRUPO_CUOTA == "SOL_TOTAL")
    return(cuotas_prueba)
    })
  
  output$plot <- renderggiraph({
    
    cuotas_prueba2 <- re()
    
    aux1 <- cuotas_prueba2$AVANCE_FINAL
    aux2 <- cuotas_prueba2$CANTIDAD - cuotas_prueba2$AVANCE_FINAL

    donut_data <- data.frame(type = c("BFALTANTE", "PAVANCE"), value = c(aux2, aux1)) %>%
      mutate(percentage = value / sum(value),
             hover_text = paste0(type, ": ", value)) %>%
      mutate(percentage_label = paste0(round(100 * percentage, 1), "%"))

    donut_plot <- ggplot(donut_data, aes(y = value, fill = type)) +
      geom_bar_interactive(
        aes(x = 1, tooltip = hover_text),
        width = 0.25, stat = "identity", show.legend = FALSE
      ) +
      annotate(
        geom = "text", x = 0, y = 0, size = 20,
        label = donut_data[["percentage_label"]][donut_data[["type"]] == "PAVANCE"],
        color = "lightslategrey", family = "Roboto", fontface = 2
      ) +
      scale_fill_manual(values = c(BFALTANTE = "darkgray", PAVANCE = "palegreen4")) +
      coord_polar(theta = "y") +
      theme_void()

    tooltip_css <- "background-color:gray;color:white;padding:10px;border-radius:10px 20px 10px 20px;"

    ggiraph(ggobj = donut_plot, tooltip_opacity = 0.8, selection_type = 'none')
    
  })
}