## pdf reader - saves pdf files as a series of images

pdf_reader <- function(pdf){
  require(pdftools)
  require(magick)
  for(page in 1:pdf_info(pdf)$pages){
    pdftools::pdf_render_page(pdf, page = page) %>%
      image_read() %>%
      image_write(paste0("page", page, ".png"))
    
  }
}  