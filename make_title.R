library(magick)

image_blank(1000, 200, color="white") %>% 
  image_annotate("Of GIFs,", size = 80, font = "Roboto Condensed", 
                 location = "+30+0") %>% 
  image_annotate("memes", size=80, font="Roboto Condensed", 
                 weight = 700, color="darkred", location = "+290+0") %>% 
  image_annotate("and {magick}", size=80, font = "Roboto Condensed",
                 location="+540+0") %>% 
  image_annotate("Using R for insight and entertainment", size = 64,
                 location="+30+100", font = "Roboto Condensed", weight=200) %>% 
  image_shadow(bg="transparent", operator = "over") %>% 
  image_write("img/magick_title.png")

