material_page(
  title = "",
  include_fonts = TRUE, 
  include_nav_bar = FALSE,
  tags$br(),
  material_row(
    material_column(
      width = 12,
      material_card(
        title = "",
        depth = 4,
        ggiraphOutput("plot")
        )
      )
  )
)