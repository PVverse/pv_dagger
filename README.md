
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

    #> Loading required package: DiagrammeR

<div class="grViz html-widget html-fill-item" id="htmlwidget-30bfc6d575267fa6d815" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-30bfc6d575267fa6d815">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"Causal Inquiry\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"?\", color = lightgrey]\n                }\n    { rank = same; D  }\n    { rank = same; E  }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
<div class="grViz html-widget html-fill-item" id="htmlwidget-87364bd0de06411b7633" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-87364bd0de06411b7633">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"Causal Inquiry\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"\", color = black]\n                }\n    { rank = same; D  }\n    { rank = same; E  }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
<div class="grViz html-widget html-fill-item" id="htmlwidget-8161e3282ec856734771" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-8161e3282ec856734771">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"Causal Inquiry\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"\", color = invis]\n                }\n    { rank = same; D  }\n    { rank = same; E  }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

This is how to draw confounders and colliders

``` r
create_dag("D", "E", label_inquiry = "", scenario = "non-causal",
           confounder_path = list(nodes = c("C"), signs = c("",""),
                                  label=""))
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-8d7506935f40ce4a75d0" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-8d7506935f40ce4a75d0">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"\", color = invis]\n                }\n      subgraph cluster_0 {\n      style=bold;\n      color=lightgrey;\n      label = \"\";\n      C [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]}\n    C -> D [label = \"\", color = black]\n    C -> E [label = \"\", color = black]\n    { rank = same; C }\n    { rank = same; D  }\n    { rank = same; E  }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

``` r
create_dag("D", "E", label_inquiry = "", scenario = "non-causal",
           collider_path = list(nodes = c("F"), signs = c("",""),
                                label=""))
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-43290c87ccfd25505360" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-43290c87ccfd25505360">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"\", color = invis]\n                }\n      subgraph cluster_1 {\n          style=bold;\n          color=lightgrey;\n          label= \"\";\n      F [shape = square, style = filled, fillcolor = white, penwidth=3,color=brown]}\n    D -> \"F\" [label = \"\", color = black]\n    E -> \"F\" [label = \"\", color = black]\n    { rank = same; D  }\n    { rank = same; E  }\n    { rank = same; F }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

This is how to add measurements and draw ascertainment bias

``` r
create_dag("D", "E", scenario = "inquiry", add_measurements = TRUE,
           label_inquiry ="")
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-f32177bba2578361570e" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-f32177bba2578361570e">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"?\", color = lightgrey]\n      \"D*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      D -> \"D*\" [label = \"+\", color = black]\n      \"E*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      E -> \"E*\" [label = \"+\", color = black]\n                }\n    { rank = same; D  }\n    { rank = same; E  }\n    { rank = same; \"D*\"; \"E*\" }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

``` r
create_dag("D", "E", scenario = "non-causal", add_measurements = TRUE,
           ascertainment_drug = "",
           label_inquiry ="")
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-11521270ba93ad3f07e0" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-11521270ba93ad3f07e0">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"\", color = invis]\n      \"D*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      D -> \"D*\" [label = \"+\", color = black]\n      \"E*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      E -> \"E*\" [label = \"+\", color = black]\n      ascertainment [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n              D -> ascertainment [label = \"\", color = black]\n              ascertainment -> \"E*\" [label = \"\", color = black]\n                }\n    { rank = same; D  }\n    { rank = same; E  }\n    { rank = same; \"D*\"; \"E*\" }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

``` r
create_dag("D", "E", scenario = "non-causal", add_measurements = TRUE,
           ascertainment_event = "",
           label_inquiry ="")
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-c81f3c7607672881e8e2" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-c81f3c7607672881e8e2">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"\", color = invis]\n      \"D*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      D -> \"D*\" [label = \"+\", color = black]\n      \"E*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      E -> \"E*\" [label = \"+\", color = black]\n      ascertainment [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n              E -> ascertainment [label = \"\", color = black]\n                    ascertainment -> \"D*\" [label = \"\", color = black]\n                }\n    { rank = same; D  }\n    { rank = same; E  }\n    { rank = same; \"D*\"; \"E*\" }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

This is how to add reporting

``` r
create_dag("D", "E", scenario = "inquiry", add_measurements = TRUE, add_reporting = TRUE,
           label_inquiry ="")
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-fcb16efebb4f7eef1d19" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-fcb16efebb4f7eef1d19">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      \n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"?\", color = lightgrey]\n      \"D*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      D -> \"D*\" [label = \"+\", color = black]\n      \"E*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      E -> \"E*\" [label = \"+\", color = black]\n                }\n    Rd [label = \"Rd\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    Re [label = \"Re\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    \"E*\" -> Re [label = \"+\", color = black, style = dashed]\n    \"D*\" -> Rd [label = \"+\", color = black, style = dashed]\n\n    { rank = same; D  }\n    { rank = same; E  }\n    { rank = same; \"D*\"; \"E*\" }}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>

This is how to add reporting biases

``` r
create_dag("D", "E", scenario = "non-causal",notoriety_bias = "Notoriety", add_measurements = TRUE,
           label_inquiry ="Causal Inquiry",drug_competition_bias = "D2",
           event_competition_bias="E2",
           background_dilution =  list(drug="D3",event="E3"))
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-fb9331db86d3ec7a771b" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-fb9331db86d3ec7a771b">{"x":{"diagram":"strict digraph DAG {\n\n      graph [layout = dot, rankdir = LR]\n\n      newrank=true\n\n      Rd Notoriety Re\n      subgraph cluster_8 {\n      style=bold;\n      color=lemonchiffon1;\n      label= \"Causal Inquiry\";\n    # Nodes\n    D [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    E [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n\n    # Edge between exposure and outcome\n    D -> E [label = \"\", color = invis]\n      \"D*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      D -> \"D*\" [label = \"+\", color = black]\n      \"E*\" [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n      E -> \"E*\" [label = \"+\", color = black]\n                }\n      subgraph cluster_4 {\n      style=bold;\n      color=lightgrey;\n      label= \"Drug Competition Bias\";\n    Drug2 [label = \"D2\", shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    \"Drug2*\" [label = \"D2*\", shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n    Rd [label = \"Rd\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    Drug2 -> \"Drug2*\" [label = \"+\", color = blue, style = dashed]\n    \"Drug2*\" -> Rd [label = \"+\", color = blue, style = dashed]}\n    Re [label = \"Re\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    \"E*\" -> Re [label = \"+\", color = black, style = dashed]\n    \"D*\" -> Rd [label = \"+\", color = blue, style = dashed]\n    Drug2 -> E [label = \"+\", color = blue, style = dashed]\n\n      subgraph cluster_3 {\n          style=bold;\n          color=lightgrey;\n    Notoriety [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=pink]\n    }\n    \"D*\" -> Notoriety [label = \"+\", color = crimson, constraint=false, style = dashed,dir = back]\n    \"E*\" -> Notoriety [label = \"+\", color = crimson, constraint=false, style = dashed,dir = back]\n    Rd [label = \"Rd\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    Re [label = \"Re\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    Notoriety -> Rd [label = \"+\", color = crimson, constraint=false, style = dashed]\n    Notoriety -> Re [label = \"+\", color = crimson, constraint=false, style = dashed]\n    \"E*\" -> Re [label = \"+\", color = black, style = dashed]\n    \"D*\" -> Rd [label = \"+\", color = black, style = dashed]\n    \n      subgraph cluster_5 {\n      style=bold;\n      color=lightgrey;\n      label= \"Event Competition Bias\";\n    Event2 [label = \"E2\", shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    \"Event2*\" [label = \"E2*\", shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n    Re [label = \"Re\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    Event2 -> \"Event2*\" [label = \"+\", color = blue, style = dashed]\n    \"Event2*\" -> Re [label = \"+\", color = blue, style = dashed]}\n    Rd [label = \"Re\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    \"D*\" -> Rd [label = \"+\", color = black, style = dashed]\n    D -> Event2 [label = \"+\", color = blue, style = dashed]\n    \"E*\" -> Re [label = \"+\", color = blue, style = dashed]\n      subgraph cluster_6 {\n      style=bold;\n      color=lightgrey;\n      label= \"Background Dilution\";\n    Drug3 [label = \"D3\", shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    Event3 [label = \"E3\", shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]\n    \"Drug3*\" [label = \"D3*\", shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n    \"Event3*\" [label = \"E3*\", shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]\n    Rd [label = \"Rd\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    Re [label = \"Re\", shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]\n    Drug3 -> Event3 [label = \"+\", color = crimson, style = dashed]\n    Drug3 -> \"Drug3*\" [color = crimson, style = dashed]\n    Event3 -> \"Event3*\" [color = crimson, style = dashed]\n    \"Drug3*\" -> Rd [label = \"+\", color = crimson, style = dashed]\n    \"Event3*\" -> Re [label = \"+\", color = crimson, style = dashed]}\n    \"D*\" -> Rd [label = \"+\", color = crimson, style = dashed]\n    \"E*\" -> Re [label = \"+\", color = crimson, style = dashed]\n\n    { rank = same; D ; Drug2; Drug3 }\n    { rank = same; E ; Event2; Event3 }\n    { rank = same; \"D*\"; \"E*\"; \"Drug2*\" ; \"Drug3*\"; \"Event3*\" ; \"Event2*\"  }\n            { rank = same; Rd ; Notoriety ; Re}}","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
