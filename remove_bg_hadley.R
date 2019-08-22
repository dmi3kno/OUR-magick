library(magick)

hadley <-  image_read("https://assets.propublica.org/images/blog/_threeTwo400w/20190610-wickham-inline.jpg") %>% 
  image_convert("png")

hadley_mask <-  
  hadley %>% image_fill("red", fuzz=12) %>% 
    image_fill("red", fuzz = 10, point = "+380+200") %>% 
    image_transparent("red") %>% 
    image_channel("Opacity") %>% 
    image_morphology("Open", "Disk:3", 4) %>% 
    image_morphology("Erode", "Disk:1.5")

image_composite(hadley, hadley_mask, operator = "CopyOpacity")

