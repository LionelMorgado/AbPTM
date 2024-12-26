 
#-------------------------------------------------------------------------------
# Residue colour schemes from JSAV
#-------------------------------------------------------------------------------
     AA_pallete = c('A','R','N','D','C','Q','E','G','H','I','L','K','M','F','P','S','T','W','Y','V','B','X','Z')
clustal_pallete = c('#80a0f0','#f01505','#00ff00','#c048c0','#f08080','#00ff00','#c048c0','#f09048','#15a4a4','#80a0f0','#80a0f0','#f01505','#80a0f0','#80a0f0','#ffff00','#00ff00','#00ff00','#80a0f0','#15a4a4','#80a0f0',rep('white',3))
  zappo_pallete = c('#ffafaf','#6464ff','#00ff00','#ff0000','#ffff00','#00ff00','#ff0000','#ff00ff','#6464ff','#ffafaf','#ffafaf','#6464ff','#ffafaf','#ffc800','#ff00ff','#00ff00','#00ff00','#ffc800','#ffc800','#ffafaf',rep('white',3))
 taylor_pallete = c('#ccff00','#0000ff','#cc00ff','#ff0000','#ffff00','#ff00cc','#ff0066','#ff9900','#0066ff','#66ff00','#33ff00','#6600ff','#00ff00','#00ff66','#ffcc00','#ff3300','#ff6600','#00ccff','#00ffcc','#99ff00',rep('white',3))
  hphob_pallete = c('#ad0052','#0000ff','#0c00f3','#0c00f3','#c2003d','#0c00f3','#0c00f3','#6a0095','#1500ea','#ff0000','#ea0015','#0000ff','#b0004f','#cb0034','#4600b9','#5e00a1','#61009e','#5b00a4','#4f00b0','#f60009','#0c00f3','#680097','#0c00f3')
  helix_pallete = c('#e718e7','#6f906f','#1be41b','#778877','#23dc23','#926d92','#ff00ff','#00ff00','#758a75','#8a758a','#ae51ae','#a05fa0','#ef10ef','#986798','#00ff00','#36c936','#47b847','#8a758a','#21de21','#857a85','#49b649','#758a75','#c936c9')
 strand_pallete = c('#5858a7','#6b6b94','#64649b','#2121de','#9d9d62','#8c8c73','#0000ff','#4949b6','#60609f','#ecec13','#b2b24d','#4747b8','#82827d','#c2c23d','#2323dc','#4949b6','#9d9d62','#c0c03f','#d3d32c','#ffff00','#4343bc','#797986','#4747b8')
   turn_pallete = c('#2cd3d3','#708f8f','#ff0000','#e81717','#a85757','#3fc0c0','#778888','#ff0000','#708f8f','#00ffff','#1ce3e3','#7e8181','#1ee1e1','#1ee1e1','#f60909','#e11e1e','#738c8c','#738c8c','#9d6262','#07f8f8','#f30c0c','#7c8383','#5ba4a4')
 buried_pallete = c('#00a35c','#00fc03','#00eb14','#00eb14','#0000ff','#00f10e','#00f10e','#009d62','#00d52a','#0054ab','#007b84','#00ff00','#009768','#008778','#00e01f','#00d52a','#00db24','#00a857','#00e619','#005fa0','#00eb14','#00b649','#00f10e')
 

#-------------------------------------------------------------------------------
# Get Numbering [ANARCI]
#-------------------------------------------------------------------------------
get_anarci = function(c_fasta, ab_names, ab_seqs, numbering_scheme, germ_species){
  
  #..run anarci..
  c_cmd = paste("cd ./SOFTWARE/ANARCI/bin/ && ./ANARCI -i ", c_fasta, " --scheme ", numbering_scheme, germ_species, sep="")
  c_data = system(c_cmd, intern=TRUE)
  
  # Parse anarci results
  anarci_res = array(0, dim=c(0, 9))
  domain_pos = grep("Domain", c_data)
  anarci_pos = grep("ANARCI", c_data)
  dashdash_pos = grep("//", c_data)
  tot_seqs = length(anarci_pos)
  all_hash_pos = which(substr(c_data,1,1)=="#")
  for(i in 1:tot_seqs){
    #..heavy chain..
    c_sta = anarci_pos[i]+6
    c_sto = domain_pos[i*2]-1
    
    c_id = c_data[anarci_pos[i]-1]
    c_id = gsub("# ", "", c_id)
    c_pos = grep(c_id, ab_names)
    c_ab = ab_seqs[c_pos]
    params = c_data[domain_pos[i*2-1]+3]
    params = unlist(strsplit(params, "\\|"))
    species = params[2]
    chain_type = params[3]
    e_value = params[4]
    score = params[5]
    seqstart_index = as.character(as.numeric(params[6])+1)
    seqend_index = as.character(as.numeric(params[7])+1)
    
    M_len = nchar(c_data[c_sta])#
    c_seq = paste(substr(c_data[c_sta:c_sto], M_len, M_len), collapse="")
    
    c_res = c(c_id, species, chain_type, e_value, score, seqstart_index, seqend_index, c_seq, c_ab)
    anarci_res = rbind(anarci_res, c_res)
    
    #..light chain detected..
    c_sta = domain_pos[i*2]+5
    c_sto = dashdash_pos[i]-1
    
    params = c_data[domain_pos[i*2]+3]
    params = unlist(strsplit(params, "\\|"))
    species = params[2]
    chain_type = params[3]
    e_value = params[4]
    score = params[5]
    seqstart_index = as.character(as.numeric(params[6])+1)
    seqend_index = as.character(as.numeric(params[7])+1)
    
    M_len = nchar(c_data[c_sta])#
    c_seq = paste(substr(c_data[c_sta:c_sto], M_len, M_len), collapse="")
    
    c_res = c(c_id, species, chain_type, e_value, score, seqstart_index, seqend_index, c_seq, c_ab)
    anarci_res = rbind(anarci_res, c_res)
  }
  colnames(anarci_res) = c("Id", "Species", "ChainType", "E-value", "Score", "Start", "End", "Seq", "AbSeq")
  
  return(anarci_res)
}
 
 
#-------------------------------------------------------------------------------
# Get CDR regions:H1, H2, L1, L2 and L3 [SCALOP]
#-------------------------------------------------------------------------------
get_scalop = function(ab_names, ab_seqs, numbering_scheme){
  
  scalop_res = array(0, dim=c(0, 5)) 
  tot_seqs = length(ab_seqs)
  for(s in 1:tot_seqs){
    c_id = ab_names[s]

    c_cmd = paste("cd ./SOFTWARE/SCALOP/bin/ && ./SCALOP -i ", ab_seqs[s], " --scheme ", numbering_scheme, " --definition ", numbering_scheme, sep="")
    c_data = system(c_cmd, intern=TRUE)

    tot_res = length(c_data)
    for(r in 4:tot_res){
      c_res = unlist(strsplit(c_data[r], "\t"))
      scalop_res = rbind(scalop_res, c(c_id, c_res[2:5]))
    }
  }
  colnames(scalop_res) = c("Input", "CDR", "Sequence", "Canonical", "Median")
  
  return(scalop_res)
}

#-------------------------------------------------------------------------------
# Get CDR sequences (Join ANARCI and SCALOP results)
#-------------------------------------------------------------------------------
get_cdrs = function(anarci_res, scalop_res){ 
 tot_ab = nrow(anarci_res)/2
 ids_u = unique(anarci_res[,1])
 all_cdr = array(0, dim=c(0, 6))
 for(s in 1:tot_ab){
   c_id = ids_u[s]
   
   c_res = rep("-", 6)
   
   #..get scalop results..
   c_pos = which(scalop_res[,1]%in%c_id)
   c_scalop = scalop_res[c_pos,]
   c_res[1] = as.character(c_scalop[c_scalop[,2]=="H1", 3])
   c_res[2] = as.character(c_scalop[c_scalop[,2]=="H2", 3])
   c_res[4] = as.character(c_scalop[c_scalop[,2]=="L1", 3])
   c_res[5] = as.character(c_scalop[c_scalop[,2]=="L2", 3])
   c_res[6] = as.character(c_scalop[c_scalop[,2]=="L3", 3])
   
   #..get anarci results..
   c_anarci = anarci_res[anarci_res[,1]%in%c_id,]
   c_anarci = c_anarci[c_anarci[,3]%in%"H", 8]
   c_res[3] = as.character(gsub("-", "", substr(c_anarci, 105, 117)))
   
   #..join cdr results..
   all_cdr = rbind(all_cdr, c_res)
 }
 colnames(all_cdr) = c("H1","H2","H3","L1","L2","L3")

 return(all_cdr)
}
 
 
#-------------------------------------------------------------------------------
# Detect motifs in the protein sequences using regular expressions
#-------------------------------------------------------------------------------
get_predictions_seq = function(c_fasta, all_motifs){
  
  if(length(all_motifs)>0){
	  #..load data..
	  fastavar = read.fasta(c_fasta, as.string=TRUE, set.attributes=FALSE, forceDNAtolower=FALSE)
	  ab_names = attr(fastavar, "name")
	  ab_seqs = fastavar
	  
	  tot_m = length(all_motifs)
	  all_res = array(0, dim=c(0,3))
	  tot_ab = length(ab_names)
	  for (i in 1:tot_ab){
		c_seq = fastavar[[i]] 
		
		for(i2 in 1:tot_m){
		  c_m = paste("(?=(", all_motifs[i2], "))", sep="")
		  c_pos = unlist(gregexpr(c_m, c_seq, perl=T, ignore.case=TRUE))
		  
		  tot_res = sum(c_pos>0)
		  if(tot_res){
			new_res = cbind(rep(ab_names[i], tot_res), c_pos, all_motifs[i2])
			all_res = rbind(all_res, new_res)
		  }
		}
	  }
  }else{#..no motifs selected by the user..
    all_res = array("",dim=c(1,3))
  }
  colnames(all_res) = c("ID", "Position", "Motif")

  return(all_res)
}


#-------------------------------------------------------------------------------
# Additional interface functionalities
#-------------------------------------------------------------------------------

### Acordion ###

selectorUI = function(id){
  ns = NS(id)
  
  tags$div(
    fluidRow(
      uiOutput(ns('new_ui')),
      style='word-wrap: break-word;'
    ),
    fluidRow(
      uiOutput(ns('new_ui2'), align='center', style='padding: 10px;')
    ),
    fluidRow(
      shinycssloaders::withSpinner(plotOutput(ns("new_ui3"), width='24000px', height='200px')),
      style='overflow-x:scroll; padding: 0px;'
    ),
    style='align: center;  padding: 20px;',

    id = paste0('ui_seq_res', id)
  )
}

selectorServer = function(input, output, session, c_id, c_seq){
  ns = session$ns
  output$new_ui = render_dq_box_group({
    dq_accordion(ns("foo"), 
                 titles = c_id,
                 contents = list(c_seq),
                 bg_color = abptm_colors()[4], 
                 options = list(animate=200, collapsible=TRUE,active=FALSE),
                 hover = TRUE,
                 icons =  c(open="angle-down", closed="fa-angle-right")
    )
  })
}

selectorServer2 = function(input, output, session, c_out_pred){
  c_table = c_out_pred[, c(1:4,6:7)]
 
  #..show results in a table..
  output$new_ui2 = renderTable({
    c_table
  })
}

selectorServer3 = function(input, output, session, c_seq, c_anarci_res, c_cdr_pos, c_motif_res){
  c_seq = isolate(c_seq)
  seq_len = nchar(c_seq)
  c_anarci_res = isolate(c_anarci_res)
  c_cdr_pos = isolate(c_cdr_pos)
  c_motif_res = isolate(c_motif_res)
  
  #..create plot..
  output$new_ui3 = renderPlot({
    op = par(mar=rep(0, 4), xpd=NA)
    plot(1,1, type="n", main="", xlab="", ylab="", xlim=c(21, seq_len-23), ylim=c(13,0), axes=FALSE)
    
    ### HC+LC INFO ###
    c_sta = as.numeric(c_anarci_res[1,6])-1
    c_sto = as.numeric(c_anarci_res[1,7])
    rect(c_sta, 0, c_sto, 1, col=abptm_colors()[2], border=NA)#..Heavy chain..
    x_pos = (c_sta+c_sto)/2
    text(x_pos, 0.5, labels="Heavy Chain", col="black")
    
    c_sta = as.numeric(c_anarci_res[2,6])-1
    c_sto = as.numeric(c_anarci_res[2,7])
    rect(c_sta, 0, c_sto, 1, col=abptm_colors()[2],border=NA)#..Light chain..
    x_pos = (c_sta+c_sto)/2
    text(x_pos, 0.5, labels="Light Chain", col="black")
    
    
    ### CDR INFO ###
    all_tags = c("H1","H2","H3","L1","L2","L3")
    init = 0
    for(i2 in 1:6){
      c_sta = c_cdr_pos[i2*2-1]
      c_sto = c_cdr_pos[i2*2]
      rect(c_sta, 1, c_sto, 2, col=abptm_colors()[3], border=NA)#..Heavy chain..
      x_pos = (c_sta+c_sto)/2
      text(x_pos, 1.5, labels=all_tags[i2], col="black")
      
      init = c_sta
    }
    
    
    ### SEQ INFO ###
    PTM_flag = rep(FALSE, seq_len)
    c_pos = as.numeric(c_motif_res[,2])
    PTM_flag[c_pos] = rep(TRUE, length(c_pos))
    c_PTM_cols = abptm_colors()[1:2] 
    for(i2 in 1:seq_len){
      c_aa = substr(c_seq,i2,i2)
      
      #..get residue position in color pallete..
      c_pos = which(AA_pallete%in%c_aa)
      
      #..add aa positions..
      rect(i2-1, 2, i2, 3, col="white")
      text(i2-0.5, 2.5, labels=i2, col="black")
      #..add residue..
      rect(i2-1, 3, i2, 4, col=clustal_pallete[c_pos])
      text(i2-0.5, 3.5, labels=c_aa, col="black")
      rect(i2-1, 4, i2, 5, col=zappo_pallete[c_pos])
      rect(i2-1, 5, i2, 6, col=taylor_pallete[c_pos])
      rect(i2-1, 6, i2, 7, col=hphob_pallete[c_pos])#..hydrophobicity..
      rect(i2-1, 7, i2, 8, col=helix_pallete[c_pos])#..helix..
      rect(i2-1, 8, i2, 9, col=strand_pallete[c_pos])#..strand..
      rect(i2-1, 9, i2, 10, col=turn_pallete[c_pos])#..turn..
      rect(i2-1, 10, i2, 11, col=buried_pallete[c_pos])#..buried..
      
      #..PTM..
      c_col = c_PTM_cols[(PTM_flag[i2]==T)+1]
      rect(i2-1, 12, i2, 13, col=c_col)
    }
    
    
    #..add track side labels..
    text(0, 0.5, labels="HC/LC Domains", col="black", pos=2)
    text(0, 1.5, labels="CDR", col="black", pos=2)
    text(0, 2.5, labels="Position", col="black", pos=2)
    text(0, 3.5, labels="ClustalX", col="black", pos=2)
    text(0, 4.5, labels="Zappo", col="black", pos=2)
    text(0, 5.5, labels="Taylor", col="black", pos=2)
    text(0, 6.5, labels="Hydrophobicity", col="black", pos=2)
    text(0, 7.5, labels="Helix Propensity", col="black", pos=2)
    text(0, 8.5, labels="Strand Propensity", col="black", pos=2)
    text(0, 9.5, labels="Turn Propensity", col="black", pos=2)
    text(0, 10.5, labels="Burried Index", col="black", pos=2)
    text(0, 12.5, labels="PTMs", col="black", pos=2)
    
    par(op)
  })
  
}

