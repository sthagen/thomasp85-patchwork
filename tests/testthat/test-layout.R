test_that("The grid can be controlled", {
  expect_doppelganger('Setting ncol', {
    p1 + p2 + p3 + p4 + plot_layout(ncol = 3)
  })

  expect_doppelganger('Setting nrow', {
    p1 + p2 + p3 + p4 + plot_layout(nrow = 3)
  })

  expect_doppelganger('Setting widths', {
    p1 + p2 + p3 + p4 + plot_layout(widths = c(1, 2))
  })

  expect_doppelganger('Setting heights', {
    p1 + p2 + p3 + p4 + plot_layout(heights = c(1, 2))
  })

  expect_doppelganger('Setting widths as units', {
    p1 + p2 + p3 + p4 + plot_layout(widths = grid::unit(3, "cm"))
  })

  expect_doppelganger('Setting heights as units', {
    p1 + p2 + p3 + p4 + plot_layout(heights = grid::unit(3, "cm"))
  })
})

test_that("Fixed aspect plots behave", {
  p_f <- ggplot(mtcars) +
    geom_point(aes(hp, disp)) +
    coord_fixed() +
    ggtitle('Fixed Aspect')

  expect_doppelganger('FAR optimise space by default 1', {
    p1 + p_f + p3 + p4
  })
  expect_doppelganger('FAR optimise space by default 2', {
    p1 + p_f + p_f + p4
  })
  expect_doppelganger('FAR optimise space by default 3', {
    p_f + p_f + p3 + p4
  })
  expect_doppelganger('FAR space optimisation can be turned off', {
    p1 + p2 + p_f + p4 + plot_layout(widths = 1)
  })
  expect_doppelganger('FAR dimensions can be set with units:...', {
    p1 + p2 + p_f + plot_layout(widths = unit(c(1, 3, -1), c('null', 'cm', 'null')))
  })

  p_l1 <- ggplot(mtcars, aes(cyl, qsec, color=as.factor(vs))) +
    geom_point()
  p_l2 <- p_l1 + labs(color="a very looooooong legend title")
  expect_doppelganger('FAR legend justification', {
    p_l1 + p_l2 + plot_layout(ncol=1) & theme(legend.justification = "left", aspect.ratio=1)
  })
})

test_that("Insets looks as they should", {
  expect_doppelganger('Basic inset works', {
    p1 + inset_element(p2, 0.6, 0.6, 1, 1)
  })
  expect_doppelganger('Other alignments work', {
    p1 + inset_element(p2, 0, 0.6, 0.4, 1, align_to = 'full')
  })
  expect_doppelganger('Patchworks can be inset', {
    p1 + inset_element(p2 / p3, 0, 0.6, 0.4, 1)
  })
  expect_doppelganger('Grobs can be inset', {
    p1 + inset_element(grid::circleGrob(), 0, 0.6, 0.4, 1)
  })
  expect_doppelganger('insets can be changed', {
    p1 + inset_element(p2, 0, 0.6, 0.4, 1) + theme_void()
  })
})

test_that("various flavours of free() works", {
  p5 <- ggplot(mtcars) +
    geom_bar(aes(y = factor(gear), fill = factor(gear))) +
    scale_y_discrete(
      "",
      labels = c("3 gears are often enough",
                 "But, you know, 4 is a nice number",
                 "I would def go with 5 gears in a modern car")
    )

  expect_doppelganger('Free panel works', {
    p1 / free(p5, "panel")
  })
  expect_doppelganger('Free panel works on one side', {
    p1 / free(p5, "panel", "l")
  })
  expect_doppelganger('Free label works', {
    free(p1, "label") / p5
  })
  expect_doppelganger('Free space works', {
    plot_spacer() + free(p5, "space", "l") + p1 + p1
  })
  expect_doppelganger('Free can be nested', {
    p1 / free(p5 / free(p2, "label"), side = "l")
  })
  expect_doppelganger('Free can be stacked and nested', {
    free(free(p1 + p2 + p3 + p4, "label", "l"), "panel", "t") - p4 + p5 + plot_spacer()
  })
})
