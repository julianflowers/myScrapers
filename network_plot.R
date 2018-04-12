# create network plot of documents from readtext or tidytext

get_network_plot <- function(ds, title = "Network plot of documents", subtitle = ""){
  
  g <- ds %>%
  graph_from_data_frame()


ggraph(g, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n, edge_colour = n)) +
  geom_node_point(color = "goldenrod") +
  geom_node_text(aes(label = name), size = rel(2.5), alpha = 0.4, colour = "blue", vjust = 1, hjust = 1)+
  theme_void() +
  theme(legend.position = "bottom") +
  labs(title = title, 
       subtitle = subtitle)

}
