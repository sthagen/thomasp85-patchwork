# vdiffr ignores failures when
#   - VDIFFR_RUN_TESTS is "false" (on Travis CI with older versions and dev version of R)
#   - CI is not set (on CRAN)

expect_doppelganger <- vdiffr::expect_doppelganger

# Predefined plots

library(ggplot2)
ggplot2::set_theme(ggplot2::theme_test() + ggplot2::theme(panel.grid = ggplot2::element_blank()))

p1 <- ggplot2::ggplot(mtcars) +
  ggplot2::geom_point(ggplot2::aes(mpg, disp)) +
  ggplot2::ggtitle('Plot 1')

p2 <- ggplot2::ggplot(mtcars) +
  ggplot2::geom_boxplot(ggplot2::aes(gear, disp, group = gear)) +
  ggplot2::ggtitle('Plot 2')

p3 <- ggplot2::ggplot(mtcars) +
  ggplot2::geom_point(ggplot2::aes(hp, wt, colour = mpg)) +
  ggplot2::ggtitle('Plot 3')

p4 <- ggplot2::ggplot(mtcars) +
  ggplot2::geom_bar(ggplot2::aes(gear)) +
  ggplot2::facet_wrap(~cyl) +
  ggplot2::ggtitle('Plot 4')
