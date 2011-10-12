var posx = null;
var posy = null;
$(function(){
    // 
    if(window.location.pathname == '/jeu')
    {
        selectedPlayer = null
        hide_onglets = null
        // Show and hide onglet
        $("#right_side").hide();
        $("#right_side, #onglets, .player").livequery("mouseover",function()
        {
            window.clearTimeout(hide_onglets);
            $("#right_side").show();
        });
        $("#right_side, #onglets, .player").livequery("mouseout",function()
        {
            hide_onglets = window.setTimeout(function(){
                $("#right_side").hide();    
            },3000);
           
        });
        
        $.getJSON("/player/current_position.json",function(player){
              
            posx =  parseInt(player.posx,10);
              
            posy =  parseInt(player.posy,10);
            init();
               
        });
        
        $("#info, .go_profil").livequery("click",function(){
            $.get("player/players/-1", function(data){
                $("#right_side").html(data);
            });
            selectedPlayer = null;
        });
        $("#attack_cac").livequery("click", function(){
            
            if(selectedPlayer != null)
            {
                
                $.get("/player/players/"+selectedPlayer+"/attack_player", 
                { type: "melee" },
                function(data){
                    
                    $("#right_side").html(data);
                    $("#right_side").show();  
                    
                });
            }
            
            
        })
                
        
        $("#update_description").livequery("keyup",function(){
            $.ajax({
                url:"/player/players/update_description",
                type: "PUT",
                dataType: "html",
                data: "description="+$("#update_description").val()               
            });
        });
        
        $(".player").livequery("mouseover", function(){
            
            if($(this).attr("id").substr(0,6) == "player")
            {
                window.clearTimeout(hide_onglets);
                playerId = $(this).attr("id").substring(6);
                selectedPlayer = playerId;
                $.get("player/players/"+playerId, function(data){
                    $("#right_side").html(data);
                });
            }
        })
        $("#map div").livequery("click",function(){
            
            if($(this).attr("id").substr(0,6) == "player")
            {
                playerId = $(this).attr("id").substring(6);
             
                $.get("player/players/"+playerId, function(data){
                    $("#right_side").html(data);
                });
            }
            else
            {
                pos = get_div_position(this);
                if(pos)
                    go_to(pos.x, pos.y);
            }
            
   
       
   
    
        });
    }
});
function init()
{
    generate_grid();
    $("#map div").livequery("mouseover",function(){
   
        pos = get_div_position(this);
        if(pos)
            show_path_to(pos.x, pos.y);
       
   
    
    });





}

function go_to(x,y)
{
    var end = graph.nodes[x+offsetX][y+offsetY];
    
    var result = astar.search(graph.nodes, start, end);
    
    if(result.length != 0)
    {
        path = "";
        for(var i = 0; i < result.length ; i++)
        {
            path += (result[i].x-offsetX)+";"+(result[i].y-offsetY)+"/";
        }
           
        $.ajax({
            url:"/player/update_position.html",
            type: "PUT",
            dataType: "html",
            data: "x="+x+"&y="+y+"&path="+path,
            success: function(data) {
                $("#map").html(data);
                posx = x;
                posy = y;
                init();
            },
            error: function(data) {
                alert("Erreur");
            }
        })
    }
     
}
function get_div_position(div)
{
    pos = $(div).attr("id").substring(3).split("I");
    destinationX = parseInt(pos[0],10);
    destinationY = parseInt(pos[1],10);
    if(!isNaN(destinationX) && !isNaN(destinationY))
        return {
            "x" : destinationX, 
            "y" : destinationY
        }
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
        

    visual_acuity = parseInt($("#visual_acuity").val(),10);
    start = graph.nodes[visual_acuity][visual_acuity];
}

function show_path_to(destx,desty)
{

    // Show path to the specified destination using a* algorithm
    $("#map div").css("opacity","1")
    
    
    offsetX =  visual_acuity - posx;
    offsetY =  visual_acuity - posy;
    
   
    
    var end = graph.nodes[destx+offsetX][desty+offsetY];
    
    var result = astar.search(graph.nodes, start, end);
    
    for(var i = 0; i < result.length ; i++)
    {
        $("#pos"+(result[i].pos.x-offsetX)+"I"+(result[i].pos.y-offsetY)).attr("style","opacity:0.8");
    }        

}
