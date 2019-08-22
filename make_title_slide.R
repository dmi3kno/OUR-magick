library(magick)
library(tidyverse)

mpg %>% 
  ggplot()+
  geom_point(aes(x=displ, y=hwy, color=class))+
  labs(title="Cars")

ggsave("img/mpg_plot.png", width = 7, height = 7, dpi=150)

plot_img <- image_read("img/mpg_plot.png")

travolta_ims <- image_read("https://i.imgur.com/e1IneGq.jpg") 

frames <- lapply(travolta_ims, function(frame) {
  image_composite(plot_img, frame, gravity = "SouthWest", offset = "+100+0")
})

Reduce(c, frames) %>% 
  image_animate() %>% 
  image_write_gif("img/animated_plot.gif", delay=0.1, progress=FALSE)


