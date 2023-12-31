
interval_length_n_plot_all_points <- function(data,
                                              data_model,
                                              x_point,
                                              conf_int_model = c("rbc","bc","us"),
                                              bandwidth_model,
                                              kernel = "epanechnikov"
){
  
  data <- coverage_prob_grid[
    c(
      coverage_prob_grid$data_model == data_model &
        coverage_prob_grid$conf_int_model %in% conf_int_model &
        coverage_prob_grid$bandwidth_model %in% bandwidth_model &
        coverage_prob_grid$kernel == kernel
    ),
  ]
  
  data <- data %>% mutate(combined_model = paste0("ci = ",conf_int_model,
                                                  ", ",
                                                  "bw = ",bandwidth_model),
                          interval_length = ifelse(ci_upper>0,ci_upper,0) - ifelse(ci_lower>0,ci_lower,0)
  )
  
  annotations = list( 
    list( 
      x = 0.23,  
      y = 1,  
      text = "<B>x = -2<B>",  
      xref = "paper",  
      yref = "paper",  
      xanchor = "center",  
      yanchor = "bottom",  
      showarrow = FALSE 
    ),  
    list( 
      x = 0.78,  
      y = 1,  
      text = "<B>x =  2<B>",  
      xref = "paper",  
      yref = "paper",  
      xanchor = "center",  
      yanchor = "bottom",  
      showarrow = FALSE 
    ),  
    list( 
      x = 0.23,  
      y = 0.6,  
      text = "<B>x = -1<B>",  
      xref = "paper",  
      yref = "paper",  
      xanchor = "center",  
      yanchor = "bottom",  
      showarrow = FALSE 
    ),
    list( 
      x = 0.78,  
      y = 0.6,  
      text = "<B>x = 1<B>",  
      xref = "paper",  
      yref = "paper",  
      xanchor = "center",  
      yanchor = "bottom",  
      showarrow = FALSE 
    ),
    list( 
      x = 0.23,  
      y = 0.26,  
      text = "<B>x = 0<B>",  
      xref = "paper",  
      yref = "paper",  
      xanchor = "center",  
      yanchor = "bottom",  
      showarrow = FALSE 
    )
  )
  
  #----------------  minus 2
  plot_x_minus_2 <- plot_ly(data[data$x_point == -2,], 
                            x = ~n, 
                            y = ~interval_length, 
                            color = ~combined_model,
                            type = 'scatter', 
                            mode = 'lines',
                            legendgroup = ~combined_model,
                            showlegend = F
  ) %>% layout(xaxis = list(title = list(text = "<B>Sample size<B>",
                                         font = list(size = 10)),
                            tickfont = list(size = 10)
  ),
  yaxis = list(title = list(text = "<B>Interval length<B>",
                            font = list(size = 10)),
               tickfont = list(size = 10)
  )
  )
  
  #----------------  plus 2
  
  plot_x_plus_2 <- plot_ly(data[data$x_point == 2,], 
                           x = ~n, 
                           y = ~interval_length, 
                           color = ~combined_model,
                           type = 'scatter', 
                           mode = 'lines',
                           legendgroup = ~combined_model,
                           showlegend = F
  ) %>% layout(xaxis = list(title = list(text = "<B>Sample size<B>",
                                         font = list(size = 10)),
                            tickfont = list(size = 10)
  ),
  yaxis = list(title = list(text = "<B>Interval length<B>",
                            font = list(size = 10)),
               tickfont = list(size = 10)
  )
  )
  
  #----------------  minus 1
  
  plot_x_minus_1 <- plot_ly(data[data$x_point == -1,], 
                            x = ~n, 
                            y = ~interval_length, 
                            color = ~combined_model,
                            type = 'scatter', 
                            mode = 'lines',
                            legendgroup = ~combined_model,
                            showlegend = F
  ) %>% layout(xaxis = list(title = list(text = "<B>Sample size<B>",
                                         font = list(size = 10)),
                            tickfont = list(size = 10)
  ),
  yaxis = list(title = list(text = "<B>Interval length<B>",
                            font = list(size = 10)),
               tickfont = list(size = 10)
  )
  )
  
  #----------------  plus 1
  
  plot_x_plus_1 <- plot_ly(data[data$x_point == 1,], 
                           x = ~n, 
                           y = ~interval_length, 
                           color = ~combined_model,
                           type = 'scatter', 
                           mode = 'lines',
                           legendgroup = ~combined_model,
                           showlegend = F
  ) %>% layout(xaxis = list(title = list(text = "<B>Sample size<B>",
                                         font = list(size = 10)),
                            tickfont = list(size = 10)
  ),
  yaxis = list(title = list(text = "<B>Interval length<B>",
                            font = list(size = 10)),
               tickfont = list(size = 10)
  )
  )
  
  #----------------  0
  
  plot_x_0 <- plot_ly(data[data$x_point == 0,], 
                      x = ~n, 
                      y = ~interval_length, 
                      color = ~combined_model,
                      type = 'scatter', 
                      mode = 'lines',
                      legendgroup = ~combined_model,
                      showlegend = T
  ) %>% layout(xaxis = list(title = list(text = "<B>Sample size<B>",
                                         font = list(size = 10)),
                            tickfont = list(size = 10)
  ),
  yaxis = list(title = list(text = "<B>Interval length<B>",
                            font = list(size = 10)),
               tickfont = list(size = 10)
  )
  )
  
  #----------------  combine subplots
  
  plot <- subplot(plot_x_minus_2,
                  plot_x_plus_2,
                  plot_x_minus_1,
                  plot_x_plus_1,
                  plot_x_0, 
                  nrows = 3,
                  margin = 0.07,
                  titleX = T,
                  titleY = T
  ) %>% 
    layout(title = paste0("Model ", substring(data_model,2,2)),
           annotations = annotations,
           legend = list(x = 0.5,y = -0.05,
                         orientation = "v"
           )
    )
  
  
  return(plot)
}
