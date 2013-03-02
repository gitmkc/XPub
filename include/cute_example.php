<?php include_once("../cuteeditor_files/include_CuteEditor.php") ; ?>
<html>	
    <head>
		<title>Cute Example</title>
	</head>
	<body>
		<form name="theForm" action="cute_example.php?postback=true" method="post">
           <?php
            $_SESSION['content']= @$_POST["Editor1"];
            ?>
          <?php
                $editor=new CuteEditor();
                $editor->ID="Editor1";
                $editor->Text=$_SESSION['content'];
                $editor->Draw();
                $editor=null;
            ?>
         
                
          <!--textarea name="textbox1" rows="2" cols="20" id="textbox1" style="font-family:Arial;height:250px;width:730px;">
<?php echo stripslashes(@$_POST["Editor1"]) ;?>
          </textarea-->
		</form>
	</body>
</html>