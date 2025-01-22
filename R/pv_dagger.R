#' Create a Directed Acyclic Graph (DAG)
#'
#' This function creates a DAG using the `DiagrammeR` package. It allows for the inclusion of various biases and paths.
#'
#' @param exposure_name Character. The name of the exposure variable.
#' @param outcome_name Character. The name of the outcome variable.
#' @param label_inquiry Character. The label for the inquiry. Default is "Causal Inquiry".
#' @param confounder_path List. A list containing nodes and signs (and potentially direction) for the confounder path. By deafault it does not show it.
#' @param surrogate_confounder List. A list containing the surrogate confounder and its root. By deafault it does not show it.
#' @param collider_path List. A list containing nodes and signs for the collider path. By deafault it does not show it.
#' @param notoriety_bias Character. The notoriety bias variable. By deafault it does not show it.
#' @param drug_competition_bias Character. The drug competition bias variable. By deafault it does not show it.
#' @param event_competition_bias Character. The event competition bias variable. By deafault it does not show it.
#' @param background_dilution List. A list containing the drug and event for background dilution. By deafault it does not show it.
#' @param add_measurements Logical. Whether to add measurements. Default is FALSE.
#' @param add_reporting Logical. Whether to add reporting Default is FALSE.
#' @param ascertainment_drug Character. Whether to draw an ascertainment bias introduced by the drug. Default is NA.
#' @param ascertainment_event Character. Whether to draw an ascertainment bias introduced by the event. Default is NA.
#' @param additional_rows Character. Parameter to add more lines for customised DAGs.
#' @param rankdir Character. The direction of the graph layout. Default is "LR", or left to right. It can also be set "TB" or top to bottom.
#' @param scenario Character. The causal scenario type. Default is "inquiry", leaving the question mark on the relation between drug and event. It can also be causal and non-causal.
#'
#' @return A DAG created using the `DiagrammeR` package.
#' @import DiagrammeR
#' @export
#'
#' @examples
#' create_dag("Exposure", "Outcome")
create_dag <- function(exposure_name, outcome_name,label_inquiry = "Causal Inquiry",
                       confounder_path = NULL, surrogate_confounder = NULL,
                       collider_path = NULL,
                       notoriety_bias = NULL,
                       drug_competition_bias = NULL, event_competition_bias = NULL,
                       background_dilution = NULL, add_measurements = FALSE,
                       add_reporting = FALSE,
                       ascertainment_drug=NA,ascertainment_event=NA,
                       additional_rows = "",
                       rankdir="LR",
                       scenario="inquiry") {
  dag <- paste0("strict digraph DAG {

      graph [layout = dot, rankdir = ",rankdir,"]

      newrank=true

      ",ifelse(!is.null(notoriety_bias),
               paste0("Rd ",notoriety_bias," Re"),
               ifelse(!is.null(drug_competition_bias)|!is.null(event_competition_bias)|!is.null(background_dilution),
                      paste0("Rd Re"),
                      "")),
               "
      subgraph cluster_8 {
      style=bold;
      color=lemonchiffon1;
      label= '",label_inquiry,"';
    # Nodes
    ",exposure_name," [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]
    ",outcome_name," [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]

    # Edge between exposure and outcome
    ",exposure_name," -> ",outcome_name," [label = ",
               ifelse(scenario=="inquiry","'?'","''"),
               ", color = ",ifelse(scenario=="inquiry","lightgrey",ifelse(scenario=="causal","black","invis")),"]")
  # Add measurements if requested
  if (add_measurements) {
    dag <- paste0(dag, "
      '", exposure_name,"*' [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
      ", exposure_name, " -> '", exposure_name, "*' [label = '+', color = black]
      '", outcome_name,"*' [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
      ", outcome_name, " -> '", outcome_name, "*' [label = '+', color = black]")
    if (!is.na(ascertainment_drug)) {
      dag <- paste0(dag, "
      ascertainment [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
              ", exposure_name, " -> ascertainment [label = '",ascertainment_drug,"', color = ",ifelse(ascertainment_drug=="+","red",
                                                                                                               ifelse(ascertainment_drug=="-","blue","black")),"]",
      "
              ascertainment -> '", outcome_name, "*' [label = '",ascertainment_drug,"', color = ",ifelse(ascertainment_drug=="+","red",
                                                                                                               ifelse(ascertainment_drug=="-","blue","black")),"]")
    }
    if (!is.na(ascertainment_event)) {
      dag <- paste0(dag, "
      ascertainment [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
              ", outcome_name, " -> ascertainment [label = '",ascertainment_event,"', color = ",ifelse(ascertainment_event=="+","red",
                                                                                                                ifelse(ascertainment_event=="-","blue","black")),"]","
                    ascertainment -> '", exposure_name, "*' [label = '",ascertainment_event,"', color = ",ifelse(ascertainment_event=="+","red",
                                                                                                                ifelse(ascertainment_event=="-","blue","black")),"]")
    }
  }
  dag <- paste0(dag, "
                }")
  # Add confounder path if provided
  if (!is.null(confounder_path)) {
    num_minuses <- sum(confounder_path$signs == "-")
    path_color <- ifelse(any(confounder_path$signs==""),"black",ifelse(num_minuses %% 2 == 1, "blue", "crimson"))
    dag <- paste0(
      dag, "
      subgraph cluster_0 {
      style=bold;
      color=lightgrey;
      label = '",confounder_path$label,"';")
    for (i in 1:length(confounder_path$nodes)) {
      dag <- paste0(
        dag, "
      ", confounder_path$nodes[i], " [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]")
      if (i > 1) {
        dag <- paste0(dag,"
        ",  confounder_path$nodes[i-1], " -> ", confounder_path$nodes[i], " [label = '", confounder_path$signs[i], "', color = ", path_color,
                      if(!is.null(confounder_path$direction[i])&& !is.na(confounder_path$direction[i])){if(confounder_path$direction[i]=="back"){", dir = back"}}, "]")
      }
    }

    # Add surrogate variable if provided
    if (!is.null(surrogate_confounder)) {dag <- paste0(dag,"
     ",surrogate_confounder$surrogate, " [shape = ellipse, style = filled, fillcolor = white, penwidth=3, color= peru]
    ", surrogate_confounder$root, " -> ", surrogate_confounder$surrogate, " [label = '+', color = black]")
    }
    if (add_measurements){
      m_nodes <- c(confounder_path$nodes,if (!is.null(surrogate_confounder)) {surrogate_confounder$surrogate})
      string <- ""
      for (n in 1:length(m_nodes)) {
        m_node <- paste0("'",m_nodes[[n]], "*'")
        string <- paste0(string, "
          ", m_node, " [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
          ", m_nodes[[n]], " -> ", m_node, " [label = '+', color = black]")
      }
      dag <- paste0(dag,string)
    }
    dag <- paste0(dag,"}
    ", confounder_path$nodes[1], " -> ",exposure_name," [label = '", confounder_path$signs[1], "', color = ", path_color, "]
    ", confounder_path$nodes[i], " -> ",outcome_name," [label = '", confounder_path$signs[i + 1], "', color = ", path_color, "]"
    )
  }


  # Add collider path if provided
  if (!is.null(collider_path)) {
    num_minuses <- sum(collider_path$signs == "-")
    path_color <- ifelse(any(collider_path$signs==""),"black",ifelse(num_minuses %% 2 == 0, "blue", "crimson"))
    dag <- paste0(dag, "
      subgraph cluster_1 {
          style=bold;
          color=lightgrey;
          label= '",collider_path$label,"';")
    for (i in seq_along(collider_path$nodes)) {
      dag <- paste0(dag,"
      ", collider_path$nodes[i], " [shape = square, style = filled, fillcolor = white, penwidth=3,color=brown]")
      if (i > 1) {
        dag <- paste0(dag, "
        ", collider_path$nodes[i-1], " -> ",collider_path$nodes[i], " [label = '", collider_path$signs[i], "', color = ", path_color, "]")
      }
    }
    if (add_measurements){
      m_nodes <- collider_path$nodes
      string <- ""
      for (n in 1:length(m_nodes)) {
        m_node <- paste0("'",m_nodes[[n]], "*'")
        string <- paste0(string, "
          ", m_node, " [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
          ", m_nodes[[n]], " -> ", m_node, " [label = '+', color = black]")
      }
      dag <- paste0(dag,string)
    }
    # Connect the last collider node to the outcome
    dag <- paste0(dag, "}
    ",exposure_name," -> '", collider_path$nodes[1], "' [label = '", collider_path$signs[i], "', color = ", path_color, "]
    ",outcome_name," -> '", collider_path$nodes[i], "' [label = '", collider_path$signs[i + 1], "', color = ", path_color, "]")
  }

  # Add reporting if true
  if (add_reporting == TRUE) {
    dag <- paste0(dag,"
    Rd [label = 'Rd', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    Re [label = 'Re', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    '",outcome_name,"*' -> Re [label = '+', color = black, style = dashed]
    '",exposure_name,"*' -> Rd [label = '+', color = black, style = dashed]
")
  }



  # Add drug competition bias if provided
  if (!is.null(drug_competition_bias)) {
    dag <- paste0(dag,"
      subgraph cluster_4 {
      style=bold;
      color=lightgrey;
      label= 'Drug Competition Bias';")
    dag <- paste0(dag, "
    Drug2 [label = '", drug_competition_bias, "', shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]
    'Drug2*' [label = '", drug_competition_bias, "*', shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
    Rd [label = 'Rd', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    Drug2 -> 'Drug2*' [label = '+', color = blue, style = dashed]
    'Drug2*' -> Rd [label = '+', color = blue, style = dashed]}
    Re [label = 'Re', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    '",outcome_name,"*' -> Re [label = '+', color = black, style = dashed]
    '",exposure_name,"*' -> Rd [label = '+', color = blue, style = dashed]
    Drug2 -> ",outcome_name," [label = '+', color = blue, style = dashed]
")
  }

  # Add notoriety bias if provided
  if (!is.null(notoriety_bias)) {
    dag <- paste0(dag, "
      subgraph cluster_3 {
          style=bold;
          color=lightgrey;")
    dag <- paste0(dag, "
    ", notoriety_bias," [shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=pink]
    }
    '",exposure_name,"*' -> ", notoriety_bias," [label = '+', color = crimson, constraint=false, style = dashed,dir = back]
    '",outcome_name,"*' -> ", notoriety_bias," [label = '+', color = crimson, constraint=false, style = dashed,dir = back]
    Rd [label = 'Rd', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    Re [label = 'Re', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    ",notoriety_bias," -> Rd [label = '+', color = crimson, constraint=false, style = dashed]
    ",notoriety_bias," -> Re [label = '+', color = crimson, constraint=false, style = dashed]
    '",outcome_name,"*' -> Re [label = '+', color = black, style = dashed]
    '",exposure_name,"*' -> Rd [label = '+', color = black, style = dashed]
    ")
  }

  # Add event competition bias if provided
  if (!is.null(event_competition_bias)) {
    dag <- paste0(dag,"
      subgraph cluster_5 {
      style=bold;
      color=lightgrey;
      label= 'Event Competition Bias';")
    dag <- paste0(dag, "
    Event2 [label = '", event_competition_bias, "', shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]
    'Event2*' [label = '", event_competition_bias, "*', shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
    Re [label = 'Re', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    Event2 -> 'Event2*' [label = '+', color = blue, style = dashed]
    'Event2*' -> Re [label = '+', color = blue, style = dashed]}
    Rd [label = 'Re', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    '",exposure_name,"*' -> Rd [label = '+', color = black, style = dashed]
    ",exposure_name," -> Event2 [label = '+', color = blue, style = dashed]
    '",outcome_name,"*' -> Re [label = '+', color = blue, style = dashed]")
  }

  # Add background dilution if provided
  if (!is.null(background_dilution)) {
    dag <- paste0(dag,"
      subgraph cluster_6 {
      style=bold;
      color=lightgrey;
      label= 'Background Dilution';")
    dag <- paste0(dag, "
    Drug3 [label = '", background_dilution$drug, "', shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]
    Event3 [label = '", background_dilution$event, "', shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=brown]
    'Drug3*' [label = '", background_dilution$drug, "*', shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
    'Event3*' [label = '", background_dilution$event, "*', shape = ellipse, style = filled, fillcolor = white, penwidth=3,color=orange]
    Rd [label = 'Rd', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    Re [label = 'Re', shape = square, style = filled, fillcolor = white, penwidth=3,color=pink]
    Drug3 -> Event3 [label = '+', color = crimson, style = dashed]
    Drug3 -> 'Drug3*' [color = crimson, style = dashed]
    Event3 -> 'Event3*' [color = crimson, style = dashed]
    'Drug3*' -> Rd [label = '+', color = crimson, style = dashed]
    'Event3*' -> Re [label = '+', color = crimson, style = dashed]}
    '",exposure_name,"*' -> Rd [label = '+', color = crimson, style = dashed]
    '",outcome_name,"*' -> Re [label = '+', color = crimson, style = dashed]
")
  }
  dag <- paste0(dag,additional_rows)
  # Define ranks for node positioning
  dag <- paste0(dag,
                if(!is.null(confounder_path)) {paste0("
    { rank = same; ", paste0(c(confounder_path$nodes, if(!is.null(surrogate_confounder)){surrogate_confounder$surrogate}), collapse = "; "), " }")},"
    { rank = same; ",exposure_name," ",if (!is.null(drug_competition_bias)) {"; Drug2"},if (!is.null(background_dilution)) {"; Drug3"}," }
    { rank = same; ",outcome_name," ",if (!is.null(event_competition_bias)) {"; Event2"},if (!is.null(background_dilution)) {"; Event3"}," }",
                if(!is.null(collider_path)) {paste0("
    { rank = same; ", paste0(collider_path$nodes, collapse = "; "), " }")},
                if(add_measurements) {paste0("
    { rank = same; '", exposure_name,"*'; '",outcome_name,"*'",
                                             if (!is.null(drug_competition_bias)) {"; 'Drug2*' "},
                                             if (!is.null(background_dilution)) {"; 'Drug3*'; 'Event3*' "},
                                             if (!is.null(event_competition_bias)) {"; 'Event2*' "},
                                             if (!is.null(collider_path)) {paste0("; ",paste0("'",collider_path$nodes, "*'", collapse = "; "))},
                                             if (!is.null(confounder_path)) {paste0("; ",paste0("'",confounder_path$nodes, "*'", collapse = "; "))},
                                             if (!is.null(surrogate_confounder)) {paste0("; '",surrogate_confounder$surrogate, "*'", collapse = "; ")}," }")},
                ifelse(!is.null(notoriety_bias),
                       paste0("
            { rank = same; Rd ; ",notoriety_bias," ; Re}"),
                       ifelse(!is.null(drug_competition_bias)|!is.null(event_competition_bias)|!is.null(background_dilution),
                              paste0("
                    { rank = same; Rd ; Re}"),
                              ""))
  )
  dag <- paste0(dag,"}")
  grViz(dag)
}
