module UI(  iClk,iRst_n,iKey,iSW,
				 oAngle		
			  );

input 		 	  iClk;
input 		 	  iRst_n;
input      [1:0] iKey;
input      [3:0] iSW;
output reg [7:0] oAngle;


`define AdjAngle 1
`define MAX_Angle 180
`define MIN_Angle 0
reg [21:0] count;
reg click1;
reg click2;



always@(posedge iClk or negedge iRst_n)
begin
  if(!iRst_n)
	begin
    oAngle <= 8'd60;
    count <= 0;
	end
  else
	begin
    
	 
	 
		if(click1 == 1'b1)
			begin
			$display("%b", click1);
			$display("%b", click2);
			     if(count[21] & (oAngle != `MAX_Angle))
					begin
				    count <= 0;
					 oAngle <= oAngle + `AdjAngle;
					end
				  else
				 
				    count <= count + iSW + 1;
					
					
			end
			else if(click2 == 1'b1)
			begin
			$display("%b", click1);
			$display("%b", click2);
			     if(count[21] & (oAngle != `MIN_Angle))
				  begin
				    count <= 0;
					 oAngle <= oAngle - `AdjAngle;
				  end
				  else
				  
				    count <= count + iSW + 1;
			   
				end
		
	 
	end
	end
 
 always@(posedge iKey[0])
 begin
  click1 <= click1 + 1'b1;
  end
   always@(posedge iKey[1])
	begin
	click2 <= click2 + 1'b1;
	end

endmodule 