# Color palette
abptm_colors = function(){
	color_palette = c("#FFFFFF", "#71b2c7", "#a6dbeb", "#CED2EB")

	return(color_palette)
}


# Customized interface styling
custom_css = ".abptm_icon {margin-right: 10px;}
              .well { background-color: white; }
              body { background-color: #f5f5f5; }
              .hover_info { border: 1px black solid; padding: 2px 4px; border-radius: 50%; cursor: pointer; float: right;}
              .control-label { margin-bottom: 4px; }
              .multi-wrapper { margin-top: -20px; }
              .download-row { padding-bottom: 20px;"
			  
			  
js = '
$(document).on("keyup", function(e) {
  if (e.keyCode == 13) {
    if(document.getElementById("gene") == document.activeElement) {
      Shiny.onInputChange("keyPressed", Math.random());
      document.activeElement.blur();
    }
  }
});
'
			  
custom_header_css = "body {margin-top: 60px;}
					.abptm_header {list-style-type: none; margin: 0; padding: 0; overflow: hidden; background-color: #4682b4; font-family: 'Source Sans Pro','Helvetica Neue',Helvetica,Arial,sans-serif;
				   font-weight: 300; font-size: 20px; color: white; list-style: none; overflow: hidden; position: fixed; top: 0; width: 100%; z-index: 999;}
					.abptm_header li { float: left; color: white;}
					.abptm_header_logo {float: right!important; padding: 11px 0 11px 10px}
					.abptm_header_title { padding: 11px 0 11px 10px }
					.bg-aqua { background-color:#4682b4!important; }
					.selectize-input.focus { border-color:#4682b4!important;
											-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px #4682b4;
											box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px #4682b4; }
					.form-control:focus { border-color:#4682b4!important;
											-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px #4682b4;
											box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px #4682b4; }
					.btn-info { background-color: #4682b4; border: 0px solid transparent; padding-top: 15px; padding-bottom: 15px; }
					.btn-info.hover, .btn-info:active, .btn-info:hover { background-color: #00827b; }"

abptm_header_logo = function(output) {
  output$abptm_logo <- shiny::renderImage({

    filename <- normalizePath(file.path(system.file("AbPTM_logo.png")))
    list(src = filename, style = "margin-top:10px; margin-right:10px; height:30px;")

  }, deleteFile = FALSE)
}