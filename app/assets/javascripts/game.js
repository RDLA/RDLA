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
    grid = new Array(Math.sqrt($("#map div").length));
    for(i = 0; i<grid.length ; i++)
        {
            grid[i] = new Array(Math.sqrt($("#map div").length));
        }
    x = 0;
    y = 0;
    
    $("#map div").each(function(){ 
        $(this).css("opacity","1")
      
        if(x == grid.length)
            {
               x=0;
               y++;
            }
              
        grid[x][y] = 0;
       
        x++;
        });
    
    fillPos(); //Get position of current player
    $("#chat").html(destx+"/"+desty);
        var graph = new Graph(grid);
    
    var offsetX = Math.min(posx,destx)*-1;
    var offsetY = Math.min(posy,desty)*-1;
    var start = graph.nodes[posx+offsetX][posy+offsetY];
    var end = graph.nodes[destx+offsetX][desty+offsetY];
    var result = astar.search(graph.nodes, start, end);
    for(var i = 0; i < result.length ; i++)
    {
         $("#pos"+(result[i].x-offsetX)+"I"+(posy+result[i].y-offsetY)).attr("style","opacity:0.8");
    }        

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