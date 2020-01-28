module UI(  Clk,Rst_n,iKey,iSW,
				 oAngle, number, numbData		
			  );

input 		 	  Clk;
input 		 	  Rst_n;
input       iKey;
input      [3:0] iSW;
input 	  [2:0] number;
input      [2:0] numbData;
output reg [7:0] oAngle;


`define AdjAngle 1
`define MAX_Angle 180
`define MIN_Angle 0
reg [21:0] count;
reg click1;
reg click2;



always@(posedge Clk or negedge Rst_n)
begin
  if(!Rst_n)
	begin
    oAngle <= 8'd60;
    count <= 0;
	end
  else
	begin
    
	 
	 
		if(click1 == 1'b1 )
			begin
			$display("%b", click1);
			$display("%b", click2);
			     if(count[21] & (oAngle != `MAX_Angle))
					begin
				    count <= 0;
					 oAngle <= oAngle + `AdjAngle;
					end
				  else
				 
				    count <= count + iSW;
					
					
			end
			else if(click1 == 1'b0)
			begin
			$display("%b", click1);
			$display("%b", click2);
			     if(count[21] & (oAngle != `MIN_Angle))
				  begin
				    count <= 0;
					 oAngle <= oAngle - `AdjAngle;
				  end
				  else
				  
				    count <= count + iSW;
			   
				end
		
	 
	end
	end
 
 always@(posedge iKey)
 begin
 if(number==numbData)
  click1 = click1 + 1'b1;
  end
   

endmodule 