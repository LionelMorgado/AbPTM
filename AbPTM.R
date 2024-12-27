################################################################################
#	
#	AbPTM.R
#	App to predict residues prone to post-translational modifications in antibody
#   protein sequences.
#
#	Created: Lionel Morgado [2024-12-21]
#
################################################################################

#-------------------------------------------------------------------------------
# SOFTWARE DEPENDENCIES
#-------------------------------------------------------------------------------
#  The code was developed using R version 4.4.2.
#  Additional software dependencies are indicated below.
#
#  R libraries:
#  - shiny 1.5.0
#  - shinydashboard 0.7.1
#  - shinycssloaders 1.0.0
#  - shinyjs 2.0.0
#  - ggplot2 3.3.3
#  - shinyWidgets 0.5.6
#  - waiter 0.2.0
#  - shinyBS 0.61.1
#  - plotly 4.9.3
#  - DT 0.17
#  - seqinr 4.2-5
#  - dqshiny 0.0.5
#
#  Third-party software:
#  - ANARCI(https://github.com/oxpig/ANARCI)  
#  - SCALOP(https://github.com/oxpig/SCALOP)
#
#  ANARCI and SCALOP must be installed in the SOFTWARE folder of the app.
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# HOW TO RUN
#-------------------------------------------------------------------------------
# The app can be executed locally from within R by running the following commands:
# setwd("PATH_TO_AbPTM/")#..must be defined as the app root folder..
# library(shiny)
# runApp("AbPTM.R")


#-------------------------------------------------------------------------------
# INIT PARAMS
#-------------------------------------------------------------------------------
# Load libraries
library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(ggplot2)
library(shinyWidgets)
library(waiter)#..loading screens for Shiny..
library(shinyBS)#..add additional functionality and interactivity..
library(plotly)#..interactive plots..
library(DT)#..data tables..
library(seqinr)# Biological Sequences Retrieval and Analysis
library(dqshiny)#..create acordions..

# Load additional source code
source("./CODE/AbPTM_aux.R")
source("./CODE/AbPTM_help.R")
source("./CODE/AbPTM_themes.R")
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# UI
#-------------------------------------------------------------------------------
# The user interface is composed by 3 main sections:
# 1) Top banner with app title and small antibody logo;
# 2) Main panel in the left side, which allows to upload an input file, a run 
#    button and multiple menus;
# 3) A set of tabs in the right side, that will present the output results for
#    individual antibodies, a table resuming all motifs detected which can be 
#    downloaded, and a help section describing the main app features.
#-------------------------------------------------------------------------------

ui = fluidPage(
  title = "AbPTM",
  # Top banner
  shiny::tags$head(
    shiny::tags$style(
      shiny::HTML(custom_header_css
      )
    ),
    shiny::tags$ul(class="abptm_header",
                   shiny::tags$li(class="abptm_header_title", "AbPTM | A tool to predict residues prone to post-translational modifications in antibody protein sequences"),
				   shiny::tags$li(class="abptm_header_logo"),
				   shiny::tags$img(style="float: right; padding: 11px 0 11px 0px;", src="AbPTM_logo.png", height=50)
    )
  ),
  shiny::tags$script(type="text/javascript", src="jquery.slimscroll.min.js"),
  shiny::tags$style(HTML(custom_css)),
  waiter::use_waiter(),
  shinyjs::useShinyjs(),
  shiny::tags$script(js),

  # Main panel
  shiny::fluidRow(
    class="main_panel",
    shiny::sidebarPanel(
      
      #..sequence input section..
      width=3,
      h2("Input proteins"),
      shinyBS::popify(shiny::icon("question", class="hover_info"), 
                      title = "FASTA file", 
                      content = "FASTA format is a text-based format. A sequence in FASTA format begins with a single-line description, followed by lines of sequence data. Here, peptide sequences must be represented by amino acids, and must include the heavy chain followed by the light chain.", 
                      placement = "right auto",
                      trigger = "click",
                      options = list(container = "body")),
      fileInput("in_fasta", "Choose FASTA File", accept = c("text/fasta/fa", "text",".fasta")
      ),
      actionButton("run_button_fasta", label="Run !"),
      HTML("<br/><br/><br/>"),
      tags$strong(h3("Motifs in search")),
	  selectizeInput("aspdea", "Asparagine deamidation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("aspdeg", "Aspartate degradation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("aspiso", "Aspartate isomerization", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("cys", "Cysteine (non-conserved)", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("gludea", "Glutamine deamidation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("lysgly", "Lysine glycation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("metoxy", "Methionine oxidation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("ngly", "N-glycosilation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("pro", "Proline isomerization", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("pyrfor", "Pyroglutamate formation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("man", "Tryptophan mannosylation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  selectizeInput("tryoxy", "Tryptophan oxidation", choices=NULL, selected = NULL, multiple = TRUE, options = NULL),
	  HTML("<br/>"),
      tags$strong(h3("Numbering scheme")),
      selectInput("numbering_scheme", NULL, choices=c("Chothia"="chothia", "IMGT"="imgt"), selected="imgt"),
	  HTML("<br/>"),
      tags$strong(h3("Germline species")),
      selectInput("germ_species", NULL, choices=c("All"="all", "Alpaca"="alpaca", "Cow"="cow", "Human"="human", "Mouse"="mouse", "Pig"="pig", "Rabbit"="rabbit", "Rat"="rat", "Rhesus"="rhesus"), selected="human"),
	  HTML("<br/><br/><br/><br/><br/><br/><br/>"),
    ),
    
	# Set of output and help tabs
    shiny::mainPanel(
      tabsetPanel(type = "tabs",
        tabPanel("Individual Antibodies",
                 style='padding-top: 20px;padding-bottom: 10px; width="100%";',
                 fluidRow(
                   style='padding: 20px;',
                   tags$div(id='placeholder')
                 ),
        ),
        tabPanel("Global Table",
                 uiOutput("download_file"),
                 style='padding-top: 20px;padding-bottom: 10px; width="100%";',
                 fluidRow(
                   dataTableOutput("table_res"),
                   style='padding: 20px; font-size:"80%";'
                 ),
        ),
        tabPanel("Help",
                 style='padding: 20px;',
				 HTML(about_help),
                 HTML("<br><br>"),
                 HTML(motifs_help),
                 HTML("<br><br>"),
                 HTML(anarci_help),
                 HTML("<br><br>"),
                 HTML(colorschemes_help),
                 HTML(colorschemes_clustal_help),
                 HTML(colorschemes_zappo_help),
                 HTML(colorschemes_taylor_help),
                 HTML(colorschemes_hydrophobicity_help),
                 HTML(colorschemes_helix_help),
                 HTML(colorschemes_strand_help),
                 HTML(colorschemes_turn_help),
                 HTML(colorschemes_buried_help),
        )
      )
    )
  )
)


#-------------------------------------------------------------------------------
# SERVER
#-------------------------------------------------------------------------------
server = function(input, output, session) {
  
  #### Render Initial UI ####
  # Selectizers
  shiny::updateSelectizeInput(session, "aspdea", choices = c("NG", "NN", "NS", "NT", "NH"), server = TRUE)
  shiny::updateSelectizeInput(session, "aspdeg", choices = c("DP"), server = TRUE)
  shiny::updateSelectizeInput(session, "aspiso", choices = c("DD", "DG", "DH", "DS", "DT"), server = TRUE)
  shiny::updateSelectizeInput(session, "cys", choices = c("C"), server = TRUE)
  shiny::updateSelectizeInput(session, "gludea", choices = c("QG"), server = TRUE)
  shiny::updateSelectizeInput(session, "lysgly", choices = c("K", "KE", "KD", "EK", "DK"), server = TRUE)
  shiny::updateSelectizeInput(session, "man", choices = c("WxxW"), server = TRUE)
  shiny::updateSelectizeInput(session, "metoxy", choices = c("M"), server = TRUE)
  shiny::updateSelectizeInput(session, "ngly", choices = c("Nx[S/T] (x not P)"), server = TRUE)
  shiny::updateSelectizeInput(session, "pro", choices = c("P"), server = TRUE)
  shiny::updateSelectizeInput(session, "pyrfor", choices = c("Q"), server = TRUE)
  shiny::updateSelectizeInput(session, "tryoxy", choices = c("W"), server = TRUE)

  
  #..define number of current outputs (used to redefine output layout)..
  counter = reactiveValues(value=0)
  
  
  ### Run job ###
  #..execution of algorithms as run button is pressed..
  observeEvent(input$run_button_fasta, {
    in_fasta = input$in_fasta
    if (is.null(in_fasta))
      return(NULL)
    
    #..reset plot area..
    if(counter$value>0){
      c_tot = counter$value
      for(i in 1:c_tot){
        removeUI(
          selector = paste0("#ui_seq_res", i)
        )
        counter$value = counter$value-1
      }
    }
    
    #..show processing screen..
    waiter::waiter_show(
      html = tagList(
        spin_2(), 
        shiny::tags$h4("Processing")
      ),
      color = "#4682b4"
    )
    

    #..load data..
print("Loading input data")
    c_fasta = in_fasta$datapath#..input file..
    fastavar = read.fasta(c_fasta, as.string=TRUE, set.attributes=FALSE, forceDNAtolower=FALSE)
    ab_names = attr(fastavar, "name")
    ab_seqs = fastavar
    
    #..get ab Fv and numbering alignment [ANARCI]..
print("Running ANARCI")
    numbering_scheme = input$numbering_scheme
    if(input$germ_species=="all"){
      germ_species = ""
    }else{
      germ_species = paste(" --use_species ", input$germ_species, sep="")
    }
    anarci_res = get_anarci(c_fasta, ab_names, ab_seqs, numbering_scheme, germ_species)
#print(anarci_res)
    
    #..get CDR regions:H1, H2, L1, L2 and L3 [SCALOP]..
print("Running SCALOP")
    c_names = as.character(anarci_res[,1])
    c_seqs = gsub("-","", as.character(anarci_res[,8]))
    scalop_res = get_scalop(c_names, c_seqs, numbering_scheme)
#print(scalop_res)
    
    #..join ANARCI and SCALOP results..
    all_cdr = get_cdrs(anarci_res, scalop_res)
    

    # Detect motifs
    #..get motifs selected by the user and transform them into regular expressions..
    all_motifs = NULL	
	if("NG"%in%input$aspdea){all_motifs = c(all_motifs, "NG")}
    if("NN"%in%input$aspdea){all_motifs = c(all_motifs, "NN")}
    if("NS"%in%input$aspdea){all_motifs = c(all_motifs, "NS")}
    if("NT"%in%input$aspdea){all_motifs = c(all_motifs, "NT")}
    if("NH"%in%input$aspdea){all_motifs = c(all_motifs, "NH")}
    if("DP"%in%input$aspdeg){all_motifs = c(all_motifs, "DP")}
	if("DD"%in%input$aspiso){all_motifs = c(all_motifs, "DD")}
    if("DG"%in%input$aspiso){all_motifs = c(all_motifs, "DG")}
    if("DH"%in%input$aspiso){all_motifs = c(all_motifs, "DH")}
    if("DS"%in%input$aspiso){all_motifs = c(all_motifs, "DS")}
	if("DT"%in%input$aspiso){all_motifs = c(all_motifs, "DT")}
    if("C"%in%input$cys){all_motifs = c(all_motifs, "C")}
    if("QG"%in%input$gludea){all_motifs = c(all_motifs, "QG")}
    if("K"%in%input$lysgly){all_motifs = c(all_motifs, "K")}
    if("KE"%in%input$lysgly){all_motifs = c(all_motifs, "KE")}
	if("KD"%in%input$lysgly){all_motifs = c(all_motifs, "KD")}
    if("EK"%in%input$lysgly){all_motifs = c(all_motifs, "EK")}
	if("DK"%in%input$lysgly){all_motifs = c(all_motifs, "DK")}
	if("EK"%in%input$lysgly){all_motifs = c(all_motifs, "EK")}
	if("M"%in%input$metoxy){all_motifs = c(all_motifs, "M")}
	if("WxxW"%in%input$man){all_motifs = c(all_motifs, "W..W")}
    if("Nx[S/T] (x not P)"%in%input$ng_gly){all_motifs = c(all_motifs, "N[^P](S|T)")}
    if("P"%in%input$pro){all_motifs = c(all_motifs, "P")}
    if("Q"%in%input$pyrfor){all_motifs = c(all_motifs, "Q")}
    if("W"%in%input$tryoxy){all_motifs = c(all_motifs, "W")}
#print(paste("Motif search: ", all_motifs, sep=" "))
    
	#..detect motifs..
	motif_res = get_predictions_seq(c_fasta, all_motifs)
#print(motif_res)

	# Prepare output
    #..render download button..
    output$download_file = renderUI({
      req(out_pred)#..only visible after running..
      downloadButton("downloadData01", label="Download")
    })
    
    
print("Prepare output")    
    #..prepare output..
    cdr_tags = colnames(all_cdr)
    tot_cdr = length(cdr_tags)
    out_pred = array(0, dim=c(0, 11))
    tot_res = length(ab_seqs)
    for(i in 1:tot_res){
      
      # Join data
      i2 = (i*2-1)
      c_id = anarci_res[i2,1]
      c_anarci_res = anarci_res[i2:(i2+1),]
      seq_flag = motif_res[,1]==c_id
      c_motif_res = motif_res[seq_flag,]
      c_cdr = all_cdr[i,]
      c_seq = anarci_res[i2,9]
      

      # Create table for download
      tot_motifs = nrow(c_motif_res)
      c_motif_pos = as.numeric(c_motif_res[,2])
      #..FV info..
      c_fv_sta = as.numeric(c_anarci_res[,6]) 
      c_fv_sto = as.numeric(c_anarci_res[,7])
      in_HC = (c_motif_pos>c_fv_sta[1]) & (c_motif_pos<=(c_fv_sto[1]+1))# NOTE: anarci coordinates start at 0
      in_LC = (c_motif_pos>c_fv_sta[2]) & (c_motif_pos<=(c_fv_sto[2]+1))
      in_FV = rep("-", tot_motifs)
      in_FV[in_HC] = c_anarci_res[1,3]
      in_FV[in_LC] = c_anarci_res[2,3]
      in_FV2 = rep("-", tot_motifs)
      in_FV2[in_HC] = c_anarci_res[1,8]
      in_FV2[in_LC] = c_anarci_res[2,8]
      
      #..CDR info..
      c_cdr_pos = NULL
      init = 0
      for(i2 in 1:tot_cdr){
        c_sta = regexpr(c_cdr[i2], c_seq)
        c_sta = c_sta[c_sta>init]
        c_sta = c_sta[1]-1
        c_sto = c_sta+nchar(c_cdr[i2])
        c_cdr_pos = c(c_cdr_pos, c(c_sta, c_sto))
        
        init = c_sta
      }
      
	  #..create a flag indicating if a motif falls inside specific sequence structures..
      in_H1 = (c_motif_pos>=c_cdr_pos[1]) & (c_motif_pos<=c_cdr_pos[2])
      in_H2 = (c_motif_pos>=c_cdr_pos[3]) & (c_motif_pos<=c_cdr_pos[4])
      in_H3 = (c_motif_pos>=c_cdr_pos[5]) & (c_motif_pos<=c_cdr_pos[6])
      in_L1 = (c_motif_pos>=c_cdr_pos[7]) & (c_motif_pos<=c_cdr_pos[8])
      in_L2 = (c_motif_pos>=c_cdr_pos[9]) & (c_motif_pos<=c_cdr_pos[10])
      in_L3 = (c_motif_pos>=c_cdr_pos[11]) & (c_motif_pos<=c_cdr_pos[12])
      in_CDR = array("-", dim=c(tot_motifs,6))#cbind(in_H1, in_H2, in_H3, in_L1, in_L2, in_L3)
      in_CDR[in_H1, 1] = c_cdr[1]
      in_CDR[in_H2, 2] = c_cdr[2]
      in_CDR[in_H3, 3] = c_cdr[3]
      in_CDR[in_L1, 4] = c_cdr[4]
      in_CDR[in_L2, 5] = c_cdr[5]
      in_CDR[in_L3, 6] = c_cdr[6]
      
      
      #..join results..
      c_out_pred = cbind(c_motif_res, in_FV, in_FV2,in_CDR)
      out_pred = rbind(out_pred, c_out_pred)
      
      
      # Create results interface in "Individual Antibodies" tab
	  #..update layout with one section per sequence..
      counter$value = counter$value + 1
      insertUI(
        selector = "#placeholder",
        ui = isolate(selectorUI(i))
      )
      
	  #..create one plot per sequence with multiple result tracks..
      callModule(selectorServer, i, c_id, c_seq)
      callModule(selectorServer2, i, c_anarci_res)
      callModule(selectorServer3, i, c_seq, c_anarci_res, c_cdr_pos, c_motif_res)
    }
	#..add column name to the results matrix..
    colnames(out_pred) = c("ID", "Position", "Motif", "InIgDomain", "Numbering", "InCDRH1", "InCDRH2", "InCDRH3", "InCDRL1", "InCDRL2", "InCDRL3")
    
    
    #..create download file..
    output$downloadData01 = downloadHandler(
      filename = function(){paste("AbPTM_Results-", Sys.Date(), "_", format(Sys.time(), "%Hh%Mm"), ".tsv", sep="")},
      content = function(file){
        write.table(out_pred, file, col.names=TRUE, row.names=FALSE, quote=FALSE, sep="\t")
      }
    )
    
    
    # Render table in "Global Results" tab
    output$table_res = renderDataTable({
      req(out_pred)
      
      c_table = data.frame(ID=as.character(out_pred[,1]), Position=as.numeric(out_pred[,2]), Motif=as.character(out_pred[,3]), InIgDomain=as.character(out_pred[,4]), 
                           InCDRH1=as.character(out_pred[,6]), InCDRH2=as.character(out_pred[,7]), InCDRH3=as.character(out_pred[,8]), 
                           InCDRL1=as.character(out_pred[,9]), InCDRL2=as.character(out_pred[,10]), InCDRL3=as.character(out_pred[,11]))
      return(c_table)
    })

        
    # Hide the processing screen
    waiter_hide()
print("Finished!")
  })
  
  
  ### Render "Help" tab ###
  output$colorscales_help = renderText({ colorscales_help })
  output$anarci_help = renderText({ anarci_help })
  
}


#-------------------------------------------------------------------------------
# Run App
#-------------------------------------------------------------------------------
shinyApp(ui, server)
