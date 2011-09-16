$(function(){
   
    if(window.location.pathname == '/admin/terraformings')
    {
        $("#map div").mouseover(function(){
            
            pos = $(this).attr("id").substring(3).split("I");           
            $("#show_pos").html("["+pos[0]+";"+pos[1]+"]");
            
        });
         $("#map div").livequery('click',function(){
          
            pos = $(this).attr("id").substring(3).split("I");      
            field = $("#selectedPictureId").val();
            map = $("#map_id").val();
            $(this).css("opacity","0.5");
            console.log("Ajax request for creating a field (#"+field+") at position["+pos[0]+";"+pos[1]+"] on #"+map+"");
            
            $.post('/admin/terraformings',{ posx: pos[0], posy: pos[1], map: map, field:field }, function(data){
                 $("#map").html(data);
                 $(this).css("opacity","1");
                 
            });
            
            
        });
        $("#map div").livequery('mouseover',function(){
            
            pos = $(this).attr("id").substring(3).split("I");           
            $("#show_pos").html("["+pos[0]+";"+pos[1]+"]");
            
        });

        $(".terraforming_option input").click(function(){
            update_params();
        });
        $(".terraforming_option select").change(function(){
            update_params();
        });
        $(".field").click(function(){
            $("#selectedPicture").attr("src",$(this).attr("src"));
            $("#selectedPictureId").val($(this).attr("alt"));
        });
        $("#build_all").click(function(){
           if(confirm("Voulez-vous vraiment colorier toutes les cases visibles?"))
               {
                   
               }
        });
    }
});

function update_params()
{
    map = $("#map_id").val();
    x = $("#posx").val();
    y = $("#posy").val();
    width =$("#width").val();
    height = $("#height").val();
    console.log("Ajax request for uploading params and refresh map| Position["+x+";"+y+"] on #"+map+" with windows("+width+"x"+height+") ");
    $("#majinfo").val("Mise à jour...");
     $.ajax({
               url:"/admin/terraformings/update_position",
               type: "PUT",
               dataType: "html",
               data: "map_id="+map+"&posx="+x+"&posy="+y+"&width="+width+"&height="+height,
               success: function(data) {
                   $("#majinfo").val("Modifier");
                   $("#map").html(data);
                   $("#map").css("width",72*(parseInt(width,10)+1)+"px");
                  
                   $("#map").css("height",72*(parseInt(height,10)+1)+"px");
               },
               error: function(data) {alert("Erreur"); }
            })
}   