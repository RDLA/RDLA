$(function(){
$("#map div").mouseover(function(){
   pos = $(this).attr("id").substring(3).split("I");
   destinationX = parseInt(pos[0],10);
   destinationY = parseInt(pos[1],10);
   if(!isNaN(destinationX) && !isNaN(destinationY))
       show_path_to(destinationX, destinationY)
       
   
    
});


});

posx = null;
posy = null;

function show_path_to(destx,desty)
{
    // Show path to the specified destination using a* algorithm
    
    $("#map div").each(function(){ $(this).css("opacity","1")});
    
    fillPos(); //Get position of current player
    $("#chat").html(destx+"/"+desty);
    position = "#pos"+destx+"I"+desty;
     
     $(position).css("opacity","0.8");
//    $.getJSON("/player/path_to.json",function(data){
//               /* data structure: { 1:{posx:0,posy:1}, 2:{posx:1,posy:5}} Apply opacity to all position */
//               $.each(data, function(key, val) {
//                   position = "#pos"+val.posx+"I"+val.posy;
//                   $(position).attr("style","opacity:0.5");
//               });
//               
//           });
}
function fillPos()
{
    // Get position of the current player
    if(posx != null && posy != null)
        {
            return true;
        }
    else
        {
           $.getJSON("/player/current_position.json",function(player){
               posx =  parseInt(player.posx);
               posy =  parseInt(player.posy);
           });
        }
            
}