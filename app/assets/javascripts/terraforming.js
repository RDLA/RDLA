$(function(){
   
    if(window.location.pathname == '/admin/terraformings')
    {
        $("#map div").mouseover(function(){
            
            pos = $(this).attr("id").substring(3).split("I");           
            $("#show_pos").html("["+pos[0]+";"+pos[1]+"]");
            
        });
        $("#map div").click(function(){
            
            pos = $(this).attr("id").substring(3).split("I");           
            
            console.log("Ajax request for creating a field at this position");
            
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
    console.log("Ajax request for uploading params and refresh map");
}