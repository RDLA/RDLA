var posx = null;
var posy = null;
$(function(){
   $.getJSON("/player/current_position.json",function(player){
              
               posx =  parseInt(player.posx,10);
              
               posy =  parseInt(player.posy,10);
               init();
               
           });
});
function init()
{
    generate_grid();
    $("#map div").mouseover(function(){
   
   pos = get_div_position(this);
   if(pos)
       show_path_to(pos.x, pos.y);
       
   
    
});

$("#map div").click(function(){
  
   pos = get_div_position(this);
   if(pos)
       go_to(pos.x, pos.y);
       
   
    
});



}

function go_to(x,y)
{
    var end = graph.nodes[x+offsetX][y+offsetY];
    
    var result = astar.search(graph.nodes, start, end);
    if(result.length != 0)
        {
             
           $.ajax({
               url:"/player/update_position.html",
               type: "PUT",
               dataType: "html",
               data: "x="+x+"&y="+y,
               success: function(data) {
                   $("#map").html(data);
                   posx = x;
                   posy = y;
                   init();
               },
               error: function(data) {alert("Erreur"); }
            })
        }
     
}
function get_div_position(div)
{
   pos = $(div).attr("id").substring(3).split("I");
   destinationX = parseInt(pos[0],10);
   destinationY = parseInt(pos[1],10);
   if(!isNaN(destinationX) && !isNaN(destinationY))
       return {"x" : destinationX, "y" : destinationY}
   else
       return false
}
function generate_grid()
{
   
    grid = new Array(Math.sqrt($("#map div").length));
    for(i = 0; i<grid.length ; i++)
        {
            grid[i] = new Array(Math.sqrt($("#map div").length));
        }
    x = 0;
    y = 0;
    
    $("#map div").each(function(){ 
       
        
        if(x == grid.length)
            {
               x=0;
               y++;
            }
            
        if($(this).children().attr("src") != null)
            {
            
            grid[x][y] = 1;
            }
        else
            {
            grid[x][y] = 0;        
            }
           
        
       
        x++;
        });
        graph = new Graph(grid);
        

      
        start = graph.nodes[5][5];
}

function show_path_to(destx,desty)
{

    // Show path to the specified destination using a* algorithm
    $("#map div").css("opacity","1")
    
    
    offsetX =  5 - posx;
    offsetY =  5 - posy;
    
   
    
    var end = graph.nodes[destx+offsetX][desty+offsetY];
    
    var result = astar.search(graph.nodes, start, end);
     
    for(var i = 0; i < result.length ; i++)
    {
         $("#pos"+(result[i].pos.x-offsetX)+"I"+(result[i].pos.y-offsetY)).attr("style","opacity:0.8");
    }        

}
