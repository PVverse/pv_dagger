
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PVdagger

<!-- badges: start -->
<!-- badges: end -->

The goal of PVdagger is to support the visualization and sharing of
causal assumptions in pharmacovigilance, using Directed Acyclic Graphs.

## Installation

You can install the development version of PVdagger from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("PVverse/pv_dagger")
```

## Example

This is how to draw the causal inquiry, together with the two possible
scenarios.

``` r
library(PVdagger)
#> Loading required package: DiagrammeR
create_dag("D","E", scenario ="inquiry")
create_dag("D", "E", scenario = "causal")
create_dag("D", "E", scenario = "non-causal")
```

This is how to draw confounders and colliders

``` r
create_dag("D", "E", label_inquiry = "", scenario = "non-causal",
           confounder_path = list(nodes = c("C"), signs = c("",""),
                                  label=""))
create_dag("D", "E", label_inquiry = "", scenario = "non-causal",
           collider_path = list(nodes = c("F"), signs = c("",""),
                                label=""))
```

This is how to add measurements and draw ascertainment bias

``` r
create_dag("D", "E", scenario = "inquiry", add_measurements = TRUE,
           label_inquiry ="")
create_dag("D", "E", scenario = "non-causal", add_measurements = TRUE,
           ascertainment_drug = "",
           label_inquiry ="")
create_dag("D", "E", scenario = "non-causal", add_measurements = TRUE,
           ascertainment_event = "",
           label_inquiry ="")
```

This is how to add reporting

``` r
create_dag("D", "E", scenario = "inquiry", add_measurements = TRUE, add_reporting = TRUE,
           label_inquiry ="")
```

This is how to add reporting biases

``` r
create_dag("D", "E", scenario = "non-causal",notoriety_bias = "Notoriety", add_measurements = TRUE,
           label_inquiry ="Causal Inquiry",drug_competition_bias = "D2",
           event_competition_bias="E2",
           background_dilution =  list(drug="D3",event="E3"))
```
