## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "##",
  message = TRUE,
  warning = FALSE
  )
options(knitr.kable.NA = ".")

## ----eval = FALSE-------------------------------------------------------------
# install.packages("mtrank")

## ----eval = FALSE-------------------------------------------------------------
# remotes::install_github("TEvrenoglou/mtrank")

## -----------------------------------------------------------------------------
library("mtrank")

## -----------------------------------------------------------------------------
data("antidepressants")

## -----------------------------------------------------------------------------
ranks <- tcc(treat = drug_name, event = responders, n = ntotal,
  studlab = studyid, data = antidepressants,
  mcid = 1.25,
  sm = "OR", small.values = "undesirable")

## ----eval = FALSE-------------------------------------------------------------
# ranks$grouped.preferences

## -----------------------------------------------------------------------------
c(ranks$lower.equi, ranks$upper.equi)

## ----eval = FALSE-------------------------------------------------------------
# ranks <- tcc(treat = drug_name, event = responders, n = ntotal,
#   studlab = studyid, data = antidepressants,
#   lower.equi = 0.80, upper.equi = 1.25,
#   sm = "OR", small.values = "undesirable")

## ----eval = FALSE-------------------------------------------------------------
# forest(ranks, treat = "bupropion", xlim = c(-1, 2),
#   label.left = "Favors second treatment",
#   label.right = "Favors first treatment",
#   fill.equi = "lightblue", spacing = 1.5)

## ----echo = FALSE, out.width = "70%"------------------------------------------
forest(ranks, treat = "bupropion", xlim = c(-1, 2),
  label.left = "Favors second treatment",
  label.right = "Favors first treatment",
  fill.equi = "lightblue", spacing = 1.5,
  file = "forest1.pdf")
knitr::include_graphics("forest1.pdf")

## -----------------------------------------------------------------------------
fit <- mtrank(ranks)

## -----------------------------------------------------------------------------
fit

## ----eval = FALSE-------------------------------------------------------------
# forest(fit)

## ----echo = FALSE, out.width = "70%"------------------------------------------
forest(fit, file = "forest2.pdf")
knitr::include_graphics("forest2.pdf")

## ----eval = FALSE-------------------------------------------------------------
# forest(fit, backtransf = TRUE)

## -----------------------------------------------------------------------------
# Get probability that bupropion is better or worse than trazodone
paired_pref(fit, treat1 = "bupropion", treat2 = "trazodone",
  type = c("better", "worse"))

# Get probability that bupropion is tied with trazodone
paired_pref(fit, treat1 = "bupropion", treat2 = "trazodone",
  type = "tie")

# Get all three probabilities
paired_pref(fit, treat1 = "bupropion", treat2 = "trazodone",
  type = "all")

## -----------------------------------------------------------------------------
# Get probability that bupropion is better than other drugs
paired_pref(fit, treat1 = "bupr",
  treat2 = c("fluo", "paro", "sert", "traz", "venl"), type = "better")

