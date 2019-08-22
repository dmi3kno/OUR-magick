library(av)
library(magick)
library(ggplot2)

mpg %>% 
  ggplot()+
  geom_point(aes(x=displ, y=hwy, color=class))+
  labs(title="Cars")

ggsave("img/mpg_plot.png", width = 7, height = 7, dpi=150)

plot_img <- image_read("img/mpg_plot.png")

ii_plot <- image_info(plot_img)


mouse_stk <- magick::image_read_video("img/giphy.mp4", 
                         fps=NULL, format = "png")

ii_mouse <- image_info(mouse_stk)

mouse_bgless_lst <- lapply(seq_along(mouse_stk), function(i){
  frame_mask <- 
    mouse_stk[i] %>% 
    image_transparent("black", fuzz = 70) %>% 
    image_channel("Opacity") %>% 
    image_negate() %>% 
    image_morphology("Close", "Disk:1.5",2) %>% 
    image_fill("red") %>% 
    image_transparent("red") %>% 
    image_channel("Opacity")

image_composite(mouse_stk[i], frame_mask, "CopyOpacity") %>% 
  image_resize("75%")
})

geoms <- seq.int(from=ii_plot$width, to=-ii_plot$width*0.25, by=-20) %>% 
  geometry_point(0)
frames <- rep_len(head(seq_along(mouse_bgless_lst),-1), length(geoms))

lapply(seq_along(geoms), function(idx){
  i <- frames[idx]
  image_composite(plot_img, mouse_bgless_lst[[i]], 
                gravity = "southeast", offset = geoms[idx])
}) %>% 
  {Reduce(c,.)} %>% 
  image_animate() %>% 
  image_write_gif("img/mouse_mpg.gif", delay=0.1)
