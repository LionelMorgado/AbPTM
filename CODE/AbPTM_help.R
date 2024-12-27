about_help = '
<h3>About</h3><br>
AbPTM is a web-based app developed in R/Shiny designed to detect residues prone to post-translational modifications in antibody protein sequences.<br><br>
The tool allows to create a comprehensive profile for each input sequence, which includes:
<li>Numbering and antigen receptor classification via ANARCI (https://github.com/oxpig/ANARCI)</li>
<li>Canonical loop structure annotation (including the detection of the heavy chain, light chain and CDRs) via SCALOP (https://github.com/oxpig/SCALOP)</li>
<li>Detection of PTM prone residues via an embedded motif search</li>
<li>Indication of residue physicochemical properties using multiple popular schemes.</li>
<br>
Results can be downloaded in tsv format for further analysis or archiving purposes.
'

motifs_help = '
<h3>Motifs in search</h3><br>
Short description of the main motifs available in the tool:<br><br>
<style>
.help table,
.help th,
.help td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
}
</style>
<div align="center"><p>&nbsp;</p>
  <table class="table shiny-table table- spacing-s" style="width:800px">
  <thead>
    <tr>
      <th>Liability</th>
      <th>Region</th>
      <th>Motif</th>
	  <th>References</th>
    </tr>
  </thead>
    <tr>
      <td>Asparagine deamidation</td>
      <td>V and CDR regions</td>
      <td>N[G/H/N/S/T]</td>
	  <td>Sydow et al., 2014; Lu et al., 2018</td>
    </tr>
    <tr>
      <td>Aspartate degradation</td>
      <td>V region</td>
      <td>DP</td>
	  <td>Stackhouse et al., 2011</td>
    </tr>
    <tr>
      <td>Aspartate isomerization</td>
      <td>CDR regions</td>
      <td>D[D/G/S/T]</td>
	  <td>Radkiewicz et al., 2001; Sydow et al., 2014</td>
    </tr>
    <tr>
      <td>Cysteine (non-conserved)</td>
      <td>Overal protein</td>
      <td>C</td>
	  <td>Brych et al., 2010</td>
    </tr>
    <tr>
      <td>Glutamine deamidation</td>
      <td>V and CDR regions</td>
      <td>QG</td>
	  <td>Robinson et al., 2004; Liu et al., 2008</td>
    </tr>
    <tr>
      <td>Lysine glycation</td>
      <td>CDR regions</td>
      <td>K, K[E/D], [E/D]K</td>
	  <td>Zhang et al., 2008; Jacobitz et al., 2020</td>
    </tr>
	<tr>
      <td>Methionine oxidation</td>
      <td>Overal protein</td>
      <td>M</td>
	  <td>Chumsae et al., 2007; Ji et al., 2009</td>
    </tr>
    <tr>
      <td>N-linked glycosylation</td>
      <td>V region</td>
      <td>Nx[S/T], x not P</td>
	  <td>Gavel et al., 1990</td>
    </tr>
    <tr>
      <td>Proline isomerization</td>
      <td>V region</td>
      <td>P</td>
	  <td>Reimer et al., 1998</td>
    </tr>
    <tr>
      <td>Pyroglutamate formation</td>
      <td>Q at start of FR1</td>
      <td>Q</td>
	  <td>Chelius et al., 2006</td>
    </tr>
	<tr>
      <td>Tryptophan mannosylation</td>
      <td>V region</td>
      <td>WxxW</td>
	  <td>Fumanek et al., 2000</td>
    </tr>
	<tr>
      <td>Tryptophan oxidation</td>
      <td>CDR regions</td>
      <td>W</td>
	  <td>Ji et al., 2009</td>
    </tr>
  </table>
</div>
'

anarci_help = '
<h3>Numbering scheme</h3><br>
Antibody numbering schemes have been developed for accurate identification and subsequent comparison of variable regions of different antibodies.<br>
Currently implemented schemes:<br>
<ul>
   <li>Chothia (IGs only): is defined for heavy and light chain antibody chains only. Numbering in the two chain types are not
	  equivalent. Insertions occur at specific positions and can occur in both the framework and the CDRs.</li>
   <li>IMGT: has 128 possible positions for *all* antigen receptor types. These are supposed to be structurally equivalent.
          In theory these are supposed to account for all possible positions. However, insertions are possible especially
          at CDR3. Insertions at CDR3 are placed symmetrically about imgt
          positions 111 and 112. e.g. 111-ABCD DCBA-112.</li>
</ul>
<h3>Germline species</h3><br>
Specific species used in the germline assignment.<br>
Currently recognisable species (chains):
<ul>
   <li>Human (heavy, kappa, lambda, alpha, beta)</li>
   <li>Mouse (heavy, kappa, lambda, alpha, beta)</li>
   <li>Rat (heavy, kappa, lambda)</li>
   <li>Rabbit (heavy, kappa, lambda)</li>
   <li>Rhesus Monkey (heavy, kappa)</li>
   <li>Pig (heavy, kappa, lambda)</li>
</ul>
Other species may still be numbered correctly and the chain type recognised but the species be incorrect. e.g. llama VHH.
'

colorscales_help = '
<h3>Color schemes</h3><br>
<a href="http://www.jalview.org/help/html/colourSchemes/" target="_blank">Color schemes</a><br>
<a href="http://www.jalview.org/help/html/colourSchemes/clustal.html" target="_blank">Clustal</a><br>
<a href="http://www.jalview.org/help/html/colourSchemes/hydrophobic.html" target="_blank">Hydrophobicity</a><br>
<a href="http://www.jalview.org/help/html/colourSchemes/helix.html" target="_blank">Helix</a><br>
<a href="http://www.jalview.org/help/html/colourSchemes/strand.html" target="_blank">Strand</a><br>
<a href="http://www.jalview.org/help/html/colourSchemes/turn.html" target="_blank">Turn</a><br>
<a href="http://www.jalview.org/help/html/colourSchemes/buried.html" target="_blank">Buried</a><br>
'

colorschemes_help = '
<h3>Colour schemes</h3><br>
Colour schemes are used to shade amino acids by physico-chemical property to reveal patterns of variation.<br>
The built-in colour schemes based on amino acid symbols are summarised in the table below:
<div align="center"><p>&nbsp;</p>
<p>
<strong>Protein Colour Schemes</strong>
</p>
<table border="1" class="help">
<tr>
<td nowrap></td>
<td>A</td>
<td>R</td>
<td>N</td>
<td>D</td>
<td>C</td>
<td>Q</td>
<td>E</td>
<td>G</td>
<td>H</td>
<td>I</td>
<td>L</td>
<td>K</td>
<td>M</td>
<td>F</td>
<td>P</td>
<td>S</td>
<td>T</td>
<td>W</td>
<td>Y</td>
<td>V</td>
<td>B</td>
<td>X</td>
<td>Z</td>
</tr>
<tr>
<td height="24">Clustal</td>
<td bgcolor="#80a0f0"></td>
<td bgcolor="#f01505"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#c048c0"></td>
<td bgcolor="#f08080"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#c048c0"></td>
<td bgcolor="#f09048"></td>
<td bgcolor="#15a4a4"></td>
<td bgcolor="#80a0f0"></td>
<td bgcolor="#80a0f0"></td>
<td bgcolor="#f01505"></td>
<td bgcolor="#80a0f0"></td>
<td bgcolor="#80a0f0"></td>
<td bgcolor="#ffff00"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#80a0f0"></td>
<td bgcolor="#15a4a4"></td>
<td bgcolor="#80a0f0"></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td height="24">Zappo</td>
<td bgcolor="#ffafaf"></td>
<td bgcolor="#6464ff"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#ff0000"></td>
<td bgcolor="#ffff00"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#ff0000"></td>
<td bgcolor="#ff00ff"></td>
<td bgcolor="#6464ff"></td>
<td bgcolor="#ffafaf"></td>
<td bgcolor="#ffafaf"></td>
<td bgcolor="#6464ff"></td>
<td bgcolor="#ffafaf"></td>
<td bgcolor="#ffc800"></td>
<td bgcolor="#ff00ff"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#ffc800"></td>
<td bgcolor="#ffc800"></td>
<td bgcolor="#ffafaf"></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td>Taylor</td>
<td bgcolor="#ccff00"></td>
<td bgcolor="#0000ff"></td>
<td bgcolor="#cc00ff"></td>
<td bgcolor="#ff0000"></td>
<td bgcolor="#ffff00"></td>
<td bgcolor="#ff00cc"></td>
<td bgcolor="#ff0066"></td>
<td bgcolor="#ff9900"></td>
<td bgcolor="#0066ff"></td>
<td bgcolor="#66ff00"></td>
<td bgcolor="#33ff00"></td>
<td bgcolor="#6600ff"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#00ff66"></td>
<td bgcolor="#ffcc00"></td>
<td bgcolor="#ff3300"></td>
<td bgcolor="#ff6600"></td>
<td bgcolor="#00ccff"></td>
<td bgcolor="#00ffcc"></td>
<td bgcolor="#99ff00"></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td>Hydrophobicity</td>
<td bgcolor="#ad0052"></td>
<td bgcolor="#0000ff"></td>
<td bgcolor="#0c00f3"></td>
<td bgcolor="#0c00f3"></td>
<td bgcolor="#c2003d"></td>
<td bgcolor="#0c00f3"></td>
<td bgcolor="#0c00f3"></td>
<td bgcolor="#6a0095"></td>
<td bgcolor="#1500ea"></td>
<td bgcolor="#ff0000"></td>
<td bgcolor="#ea0015"></td>
<td bgcolor="#0000ff"></td>
<td bgcolor="#b0004f"></td>
<td bgcolor="#cb0034"></td>
<td bgcolor="#4600b9"></td>
<td bgcolor="#5e00a1"></td>
<td bgcolor="#61009e"></td>
<td bgcolor="#5b00a4"></td>
<td bgcolor="#4f00b0"></td>
<td bgcolor="#f60009"></td>
<td bgcolor="#0c00f3"></td>
<td bgcolor="#680097"></td>
<td bgcolor="#0c00f3"></td>
</tr>
<tr>
<td>Helix Propensity</td>
<td bgcolor="#e718e7"></td>
<td bgcolor="#6f906f"></td>
<td bgcolor="#1be41b"></td>
<td bgcolor="#778877"></td>
<td bgcolor="#23dc23"></td>
<td bgcolor="#926d92"></td>
<td bgcolor="#ff00ff"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#758a75"></td>
<td bgcolor="#8a758a"></td>
<td bgcolor="#ae51ae"></td>
<td bgcolor="#a05fa0"></td>
<td bgcolor="#ef10ef"></td>
<td bgcolor="#986798"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#36c936"></td>
<td bgcolor="#47b847"></td>
<td bgcolor="#8a758a"></td>
<td bgcolor="#21de21"></td>
<td bgcolor="#857a85"></td>
<td bgcolor="#49b649"></td>
<td bgcolor="#758a75"></td>
<td bgcolor="#c936c9"></td>
</tr>
<tr>
<td nowrap>Strand Propensity</td>
<td bgcolor="#5858a7"></td>
<td bgcolor="#6b6b94"></td>
<td bgcolor="#64649b"></td>
<td bgcolor="#2121de"></td>
<td bgcolor="#9d9d62"></td>
<td bgcolor="#8c8c73"></td>
<td bgcolor="#0000ff"></td>
<td bgcolor="#4949b6"></td>
<td bgcolor="#60609f"></td>
<td bgcolor="#ecec13"></td>
<td bgcolor="#b2b24d"></td>
<td bgcolor="#4747b8"></td>
<td bgcolor="#82827d"></td>
<td bgcolor="#c2c23d"></td>
<td bgcolor="#2323dc"></td>
<td bgcolor="#4949b6"></td>
<td bgcolor="#9d9d62"></td>
<td bgcolor="#c0c03f"></td>
<td bgcolor="#d3d32c"></td>
<td bgcolor="#ffff00"></td>
<td bgcolor="#4343bc"></td>
<td bgcolor="#797986"></td>
<td bgcolor="#4747b8"></td>
</tr>
<tr>
<td>Turn Propensity</td>
<td bgcolor="#2cd3d3"></td>
<td bgcolor="#708f8f"></td>
<td bgcolor="#ff0000"></td>
<td bgcolor="#e81717"></td>
<td bgcolor="#a85757"></td>
<td bgcolor="#3fc0c0"></td>
<td bgcolor="#778888"></td>
<td bgcolor="#ff0000"></td>
<td bgcolor="#708f8f"></td>
<td bgcolor="#00ffff"></td>
<td bgcolor="#1ce3e3"></td>
<td bgcolor="#7e8181"></td>
<td bgcolor="#1ee1e1"></td>
<td bgcolor="#1ee1e1"></td>
<td bgcolor="#f60909"></td>
<td bgcolor="#e11e1e"></td>
<td bgcolor="#738c8c"></td>
<td bgcolor="#738c8c"></td>
<td bgcolor="#9d6262"></td>
<td bgcolor="#07f8f8"></td>
<td bgcolor="#f30c0c"></td>
<td bgcolor="#7c8383"></td>
<td bgcolor="#5ba4a4"></td>
</tr>
<tr>
<td>Buried Index</td>
<td bgcolor="#00a35c"></td>
<td bgcolor="#00fc03"></td>
<td bgcolor="#00eb14"></td>
<td bgcolor="#00eb14"></td>
<td bgcolor="#0000ff"></td>
<td bgcolor="#00f10e"></td>
<td bgcolor="#00f10e"></td>
<td bgcolor="#009d62"></td>
<td bgcolor="#00d52a"></td>
<td bgcolor="#0054ab"></td>
<td bgcolor="#007b84"></td>
<td bgcolor="#00ff00"></td>
<td bgcolor="#009768"></td>
<td bgcolor="#008778"></td>
<td bgcolor="#00e01f"></td>
<td bgcolor="#00d52a"></td>
<td bgcolor="#00db24"></td>
<td bgcolor="#00a857"></td>
<td bgcolor="#00e619"></td>
<td bgcolor="#005fa0"></td>
<td bgcolor="#00eb14"></td>
<td bgcolor="#00b649"></td>
<td bgcolor="#00f10e"></td>
</tr>
</table>
</td>
</tr>
</table>
<p>&nbsp;</p>
<p>
</div>
'
colorschemes_clustal_help = '
<h4>Clustal</h4>
<p>This is an emulation of the default colour scheme used for
  alignments in Clustal X, a graphical interface for the ClustalW
  multiple sequence alignment program. Each residue
  is assigned a colour if some minimum criteria specific for the residue type is met.</p>
<p>The table below gives these criteria as clauses: {&gt;X%,xx,y},
  where X is the threshold percentage presence for any of the xx (or y) residue types.
  <br>For example, K or R is coloured red if the column includes more than 60% K or R (combined), or more than 80% of either K or R or Q (individually).</p>
<div align="center">
  <p>&nbsp;</p>
  <table border="1" class="help">
    <tr>
      <th>Category</th>
      <th>Colour</th>
      <th>Residue at position</th>
      <th>{ Threshold, Residue group }</th>
    </tr>
    <tr>
      <td rowspan="2">Hydrophobic</td>
      <td rowspan="2" bgcolor="#80a0f0">BLUE</td>
      <td>A,I,L,M,F,W,V</td>
      <td>{&gt;60%, WLVIMAFCHP}</td>
    </tr>
    <tr>
      <td>C</td>
      <td>{&gt;60%, WLVIMAFCHP}</td>
    </tr>
    <tr>
      <td>Positive charge</td>
      <td bgcolor="#f01505">RED</td>
      <td>K,R</td>
      <td>{&gt;60%,KR},{&gt;80%, K,R,Q}</td>
    </tr>
    <tr>
      <td rowspan="2">Negative charge</td>
      <td rowspan="2" bgcolor="#c048c0">MAGENTA</td>
      <td>E</td>
      <td>{&gt;60%,KR},{&gt;50%,QE},{&gt;85%,E,Q,D}</td>
    </tr>
    <tr>
      <td>D</td>
      <td>{&gt;60%,KR}, {&gt;85%, K,R,Q}, {&gt;50%,ED}</td>
    </tr>
    <tr>
      <td rowspan="3">Polar</td>
      <td rowspan="3" bgcolor="#15c015">GREEN</td>
      <td>N</td>
      <td>{&gt;50%, N}, {&gt;85%, N,Y}</td>
    </tr>
    <tr>
      <td>Q</td>
      <td>{&gt;60%,KR},{&gt;50%,QE},{&gt;85%,Q,E,K,R}</td>
    </tr>
    <tr>
      <td>S,T</td>
      <td>{&gt;60%, WLVIMAFCHP}, {&gt;50%, TS}, {&gt;85%,S,T}</td>
    </tr>
    <tr>
      <td>Cysteines</td>
      <td bgcolor="#f08080">PINK</td>
      <td>C</td>
      <td>{>85%, C}</td>
    </tr>
    <tr>
      <td>Glycines</td>
      <td bgcolor="#f09048">ORANGE</td>
      <td>G</td>
      <td>{&gt;0%, G}</td>
    </tr>
    <tr>
      <td>Prolines</td>
      <td bgcolor="#c0c000">YELLOW</td>
      <td>P</td>
      <td>{&gt;0%, P}</td>
    </tr>
    <tr>
      <td>Aromatic</td>
      <td bgcolor="#15a4a4">CYAN</td>
      <td>H,Y</td>
      <td>{&gt;60%, WLVIMAFCHP}, {&gt;85%,
        W,Y,A,C,P,Q,F,H,I,L,M,V}</td>
    </tr>
    <tr>
      <td>Unconserved</td>
      <td>WHITE</td>
      <td>any / gap</td>
      <td>If none of the above criteria are met</td>
    </tr>
  </table>
</div>
'

colorschemes_zappo_help = '
<h4>Zappo</h4>
The residues are coloured according to their physicochemical properties. The physicochemical groupings are Aliphatic/hydrophobic, Aromatic, Positive,
Negative, Hydrophillic, conformationally special, and Cyst(e)ine.
<p>&nbsp;</p>
<div align="center">
    <table width="400" border="1" class="help">
      <tr>
        <td>Aliphatic/hydrophobic</td>
        <td bgcolor="#ffafaf">ILVAM</td>
      </tr>
      <tr>
        <td>Aromatic</td>
        <td bgcolor="#ffc800">FWY</td>
      </tr>
      <tr>
        <td>Positive</td>
        <td bgcolor="#6464ff">KRH</td>
      </tr>
      <tr>
        <td>Negative</td>
        <td bgcolor="#ff0000">DE</td>
      </tr>
      <tr>
        <td>Hydrophilic</td>
        <td bgcolor="#00ff00">STNQ</td>
      </tr>
      <tr>
        <td>Conformationally special</td>
        <td bgcolor="#ff00ff">PG</td>
      </tr>
      <tr>
        <td>Cysteine</td>
        <td bgcolor="#ffff00">C</td>
      </tr>
    </table>
  </div>
'

colorschemes_taylor_help = '
<h4>Taylor</h4>
This colour scheme was devised by Willie Taylor. A description can be found in Protein Engineering, Vol 10 , 743-746 (1997).
<p>&nbsp;</p>
<div align="center">
  <table width="400" border="1" class="help">
    <tr>
      <td bgcolor="#ccff00">A</td>
      <td bgcolor="#99ff00">V</td>
      <td bgcolor="#66ff00">I</td>
      <td bgcolor="#33ff00">L</td>
    </tr>
    <tr>
      <td bgcolor="#00ff00">M</td>
      <td bgcolor="#00ff66">F</td>
      <td bgcolor="#00ffcc">Y</td>
      <td bgcolor="#00ccff">W</td>
    </tr>
    <tr>
      <td bgcolor="#0066ff">H</td>
      <td bgcolor="#0000ff">R</td>
      <td bgcolor="#6600ff">K</td>
      <td bgcolor="#cc00ff">N</td>
    </tr>
    <tr>
      <td bgcolor="#ff00cc">Q</td>
      <td bgcolor="#ff0066">E</td>
      <td bgcolor="#ff0000">D</td>
      <td bgcolor="#ff3300">S</td>
    </tr>
    <tr>
      <td bgcolor="#ff6600">T</td>
      <td bgcolor="#ff9900">G</td>
      <td bgcolor="#ffcc00">P</td>
      <td bgcolor="#ffff00">C</td>
    </tr>
  </table>
</div>
'
colorschemes_hydrophobicity_help = '
<h4>Hydrophobicity</h4>
<p>According to the hydrophobicity table of Kyte, J., and
    Doolittle, R.F., J. Mol. Biol. 1157, 105-132, 1982. The most
    hydrophobic residues according to this table are coloured red and
    the most hydrophilic ones are coloured blue.</p>
<p>&nbsp;</p>
  <div align="center">
    <table width="400" border="1" class="help">
      <tr>
        <td bgcolor="#ff0000">I</td>
        <td bgcolor="#f60009">V</td>
        <td bgcolor="#ea0015">L</td>
        <td bgcolor="#cb0034">F</td>
        <td bgcolor="#c2003d">C</td>
      </tr>
      <tr>
        <td bgcolor="#b0004f">M</td>
        <td bgcolor="#ad0052">A</td>
        <td bgcolor="#6a0095">G</td>
        <td bgcolor="#680097">X</td>
        <td bgcolor="#61009e">T</td>
      </tr>
      <tr>
        <td bgcolor="#5e00a1">S</td>
        <td bgcolor="#5b00a4">W</td>
        <td bgcolor="#4f00b0">Y</td>
        <td bgcolor="#4600b9">P</td>
        <td bgcolor="#1500ea">H</td>
      </tr>
      <tr>
        <td bgcolor="#0c00f3">E</td>
        <td bgcolor="#0c00f3">Z</td>
        <td bgcolor="#0c00f3">Q</td>
        <td bgcolor="#0c00f3">D</td>
        <td bgcolor="#0c00f3">B</td>
      </tr>
      <tr>
        </td>
        <td bgcolor="#0c00f3">N</td>
        <td bgcolor="#0000ff">K</td>
        <td bgcolor="#0000ff">R</td>
      </tr>
    </table>
  </div>
'
colorschemes_helix_help = '
<h4>Helix propensity</h4>
The residues are coloured according to their Chou-Fasman helix propensity. The highest propensity is magenta, the lowest is green.
<p>&nbsp;</p>
<div align="center">
  <table width="400" border="1" class="help">
    <tr>
      <td bgcolor="#ff00ff">E</td>
      <td bgcolor="#ef10ef">M</td>
      <td bgcolor="#e718e7">A</td>
      <td bgcolor="#c936c9">Z</td>
      <td bgcolor="#ae51ae">L</td>
    </tr>
    <tr>
      <td bgcolor="#a05fa0">K</td>
      <td bgcolor="#986798">F</td>
      <td bgcolor="#926d92">Q</td>
      <td bgcolor="#8a758a">I</td>
      <td bgcolor="#8a758a">W</td>
    </tr>
    <tr>
      <td bgcolor="#857a85">V</td>
      <td bgcolor="#778877">D</td>
      <td bgcolor="#758a75">X</td>
      <td bgcolor="#758a75">H</td>
      <td bgcolor="#6f906f">R</td>
    </tr>
    <tr>
      <td bgcolor="#49b649">B</td>
      <td bgcolor="#47b847">T</td>
      <td bgcolor="#36c936">S</td>
      <td bgcolor="#23dc23">C</td>
      <td bgcolor="#21de21">Y</td>
    </tr>
    <tr>
      </td>
      <td bgcolor="#1be41b">N</td>
      <td bgcolor="#00ff00">G</td>
      <td bgcolor="#00ff00">P</td>
    </tr>
  </table>
</div>
'
colorschemes_strand_help = '
<h4>Strand propensity</h4>
The residues are coloured according to their Chou-Fasman Strand propensity. The highest propensity is Yellow, the lowest is blue.
<p>&nbsp;</p>
<div align="center">
<table width="400" border="1" class="help">
  <tr>
    <td bgcolor="#ffff00">V</td>
    <td bgcolor="#ecec13">I</td>
    <td bgcolor="#d3d32c">Y</td>
    <td bgcolor="#c2c23d">F</td>
    <td bgcolor="#c0c03f">W</td>
  </tr>
  <tr>
    <td bgcolor="#b2b24d">L</td>
    <td bgcolor="#9d9d62">T</td>
    <td bgcolor="#9d9d62">C</td>
    <td bgcolor="#8c8c73">Q</td>
    <td bgcolor="#82827d">M</td>
  </tr>
  <tr>
    <td bgcolor="#797986">X</td>
    <td bgcolor="#6b6b94">R</td>
    <td bgcolor="#64649b">N</td>
    <td bgcolor="#60609f">H</td>
    <td bgcolor="#5858a7">A</td>
  </tr>
  <tr>
    <td bgcolor="#4949b6">S</td>
    <td bgcolor="#4949b6">G</td>
    <td bgcolor="#4747b8">Z</td>
    <td bgcolor="#4747b8">K</td>
    <td bgcolor="#4343bc">B</td>
  </tr>
  <tr>
    </td>
    <td bgcolor="#2323dc">P</td>
    <td bgcolor="#2121de">D</td>
    <td bgcolor="#0000ff">E</td>
  </tr>
</table>
</div>
'
colorschemes_turn_help = '
<h4>Turn propensity</h4>
The residues are coloured according to their Chou-Fasman turn propensity. The highest propensity is red, the lowest is cyan.
<p>&nbsp;</p>
<div align="center">
<table width="400" border="1" class="help">
  <tr>
    <td bgcolor="#ff0000">N</td>
    <td bgcolor="#ff0000">G</td>
    <td bgcolor="#f60909">P</td>
    <td bgcolor="#f30c0c">B</td>
    <td bgcolor="#e81717">D</td>
  </tr>
  <tr>
    <td bgcolor="#e11e1e">S</td>
    <td bgcolor="#a85757">C</td>
    <td bgcolor="#9d6262">Y</td>
    <td bgcolor="#7e8181">K</td>
    <td bgcolor="#7c8383">X</td>
  </tr>
  <tr>
    <td bgcolor="#778888">Q</td>
    <td bgcolor="#738c8c">W</td>
    <td bgcolor="#738c8c">T</td>
    <td bgcolor="#708f8f">R</td>
    <td bgcolor="#708f8f">H</td>
  </tr>
  <tr>
    <td bgcolor="#5ba4a4">Z</td>
    <td bgcolor="#3fc0c0">E</td>
    <td bgcolor="#2cd3d3">A</td>
    <td bgcolor="#1ee1e1">F</td>
    <td bgcolor="#1ee1e1">M</td>
  </tr>
  <tr>
    </td>
    <td bgcolor="#1ce3e3">L</td>
    <td bgcolor="#07f8f8">V</td>
    <td bgcolor="#00ffff">I</td>
  </tr>
</table>
</div>
'
colorschemes_buried_help = '
<h4>Buried index</h4>
The residues are coloured according to their Chou-Fasman burial propensity. The highest propensity is blue, the lowest is green.
<p>&nbsp;</p>
<div align="center">
  <table width="400" border="1" class="help">
    <tr>
      <td bgcolor="#0000ff">C</td>
      <td bgcolor="#0054ab">I</td>
      <td bgcolor="#005fa0">V</td>
      <td bgcolor="#007b84">L</td>
      <td bgcolor="#008778">F</td>
    </tr>
    <tr>
      <td bgcolor="#009768">M</td>
      <td bgcolor="#009d62">G</td>
      <td bgcolor="#00a35c">A</td>
      <td bgcolor="#00a857">W</td>
      <td bgcolor="#00b649">X</td>
    </tr>
    <tr>
      <td bgcolor="#00d52a">S</td>
      <td bgcolor="#00d52a">H</td>
      <td bgcolor="#00db24">T</td>
      <td bgcolor="#00e01f">P</td>
      <td bgcolor="#00e619">Y</td>
    </tr>
    <tr>
      <td bgcolor="#00eb14">N</td>
      <td bgcolor="#00eb14">B</td>
      <td bgcolor="#00eb14">D</td>
      <td bgcolor="#00f10e">Q</td>
      <td bgcolor="#00f10e">Z</td>
    </tr>
    <tr>
      </td>
      <td bgcolor="#00f10e">E</td>
      <td bgcolor="#00fc03">R</td>
      <td bgcolor="#00ff00">K</td>
    </tr>
  </table>
</div>
'
  