## -----------------------------------------------------------------------------
##
##' [PROJ: ipeRds]
##' [FILE: Create hex icon]
##' [INIT: March 25th 2024]
##' [AUTH: Matt Capaldi] @ttalVlatt
##
## -----------------------------------------------------------------------------

library(hexSticker)
library(fontawesome)
library(magick)

cap <- image_read_svg(fa("graduation-cap",
                         fill = "white",
                         ))
data <- image_read_svg(fa("database",
                          fill = "white"))
cap_data <- c(cap, data)
cap_data <- image_append(image_scale(cap_data, "100"), stack = TRUE)

subplot <- ggplot() +
  geom_hexagon(fill = "#FA4616", color ="white") +
  geom_subview()
  geom_pkgname("ipeRds") +
  geom_url("capaldi.info")

# h/t https://www.youtube.com/watch?v=O34vzdHOaEk
sticker(subplot = cap_data,
        package = "ipeRds",
        s_width = 0.85,
        s_height = 0.85,
        s_x = 1,
        s_y = 0.8,
        p_size = 26,
        h_fill = "#FA4616",
        h_color = "black",
        url = "capaldi.info/ipeRds",
        u_size = 6,
        u_color = "white",
        spotlight = TRUE,
        l_x = 1,
        l_y = 0.8) |>
  print()

## -----------------------------------------------------------------------------
##' *END SCRIPT*
## -----------------------------------------------------------------------------
