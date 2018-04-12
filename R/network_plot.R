## Draws a network plot of documents

create_network_plot <- function(ds, title = "Network plot of documents", subtitle = "", layout = "fr"){
  
  require(tidyverse, quietly = TRUE)
  require(igraph)
  require(ggraph)
  
  g <- ds %>%
  graph_from_data_frame()


ggraph(g, layout = layout) +
  geom_edge_link(aes(edge_alpha = 0.4, edge_colour = "blue")) +
  geom_node_point(color = "goldenrod") +
  geom_node_text(aes(label = name), size = rel(2.5), alpha = 0.4, colour = "blue", vjust = 1, hjust = 1)+
  theme_void() +
  theme(legend.position = "bottom") +
  labs(title = title, 
       subtitle = subtitle)

}
