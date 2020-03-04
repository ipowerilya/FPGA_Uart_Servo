module TOP(
    	Clk                     ,
    	Rst_n                   ,   
   	Rx                      ,    
    	Tx                      ,
	//RxData,
Key	,
SW,
GPIO_1, Clk2
	);

/////////////////////////////////////////////////////////////////////////////////////////
input           Clk             ; // Clock
input           Clk2;
input           Rst_n           ; // Reset
input           Rx              ; // RS232 RX line.
output          Tx              ; // RS232 TX line.
wire [7:0]    RxData          ; // Received data
input [1:0]	Key;
input [3:0] SW;
inout [19:0] GPIO_1;
/////////////////////////////////////////////////////////////////////////////////////////
wire [7:0]    	TxData     	; // Data to transmit.
wire          	RxDone          ; // Reception completed. Data is valid.
wire          	TxDone          ; // Trnasmission completed. Data sent.
wire            tick		; // Baud rate clock
wire          	TxEn            ;
wire 		RxEn		;
wire [3:0]      NBits    	;
wire [15:0]    	BaudRate        ; //328; 162 etc... (Read comment in baud rate generator file)
wire [7:0]  Angle;
//wire [7:0]  Angle1;
//wire [7:0]  Angle2;
//wire [7:0]  Angle3;
//wire [7:0]  Angle4;
//wire [7:0]  Angle5;
//wire [7:0]  Angle6;
//wire [7:0]  Angle7;
//wire [7:0]  Angle8;
//wire [7:0]  Angle9;
//wire [7:0]  Angle10;
//wire [7:0]  Angle11;
//wire [7:0]  Angle12;
//wire [7:0]  Angle13;
//wire [7:0]  Angle14;

assign GPIO_1[0] = Pwm_0;
assign GPIO_1[1] = Pwm_0;
assign GPIO_1[2] = Pwm_0;
assign GPIO_1[3] = Pwm_0;
assign GPIO_1[4] = Pwm_0;
//assign GPIO_1[5] = Pwm_5;
//assign GPIO_1[6] = Pwm_6;
//assign GPIO_1[7] = Pwm_7;
//assign GPIO_1[8] = Pwm_8;
//assign GPIO_1[9] = Pwm_9;
//assign GPIO_1[10] = Pwm_10;
//assign GPIO_1[11] = Pwm_11;
//assign GPIO_1[12] = Pwm_12;
//assign GPIO_1[13] = Pwm_13;
//assign GPIO_1[14] = Pwm_14;
//assign GPIO_1[14] = Pwm_15;
/////////////////////////////////////////////////////////////////////////////////////////
assign 		RxEn = 1'b1	;
assign 		TxEn = 1'b1	;
assign 		BaudRate = 16'd325; 	//baud rate set to 9600 for the HC-06 bluetooth module. Why 325? (Read comment in baud rate generator file)
assign 		NBits = 4'b1000	;	//We send/receive 8 bits
/////////////////////////////////////////////////////////////////////////////////////////
assign Serv1 =4'b1111;
//assign Serv2 =4'b0001;
//assign Serv3 =4'b0010;
//assign Serv4 =4'b0011;
//assign Serv5 =4'b0100;
//assign Serv6 =4'b0101;
//assign Serv7 =4'b0110;
//assign Serv8 =4'b0111;
//assign Serv9 =4'b1000;
//assign Serv10 =4'b1001;
//assign Serv11 =4'b1010;
//assign Serv12 =4'b1011;
//assign Serv13 =4'b1100;
//assign Serv14 =4'b1101;
//assign Serv15 =4'b1110;
//Make connections between Rx module and TOP inputs and outputs and the other modules
UART_rs232_rx I_RS232RX(
    	.Clk(Clk)             	,
   	.Rst_n(Rst_n)         	,
    	.RxEn(RxEn)           	,
    	.RxData(RxData)       	,
    	.RxDone(RxDone)       	,
    	.Rx(Rx)               	,
    	.Tick(tick)           	,
    	.NBits(NBits)
    );

//Make connections between Tx module and TOP inputs and outputs and the other modules
UART_rs232_tx I_RS232TX(
   	.Clk(Clk)            	,
    	.Rst_n(Rst_n)         	,
    	.TxEn(TxEn)           	,
    	.TxData(TxData)      	,
   	.TxDone(TxDone)      	,
   	.Tx(Tx)               	,
   	.Tick(tick)           	,
   	.NBits(NBits)
    );

//Make connections between tick generator module and TOP inputs and outputs and the other modules
UART_BaudRate_generator I_BAUDGEN(
    	.Clk(Clk)               ,
    	.Rst_n(Rst_n)           ,
    	.Tick(tick)             ,
    	.BaudRate(BaudRate)
    );
UI h0(

  .Clk  ( Clk2 ),
  .Rst_n( Rst_n ),
  .iKey  ( SW[1:0]),
  .iSW   ( SW[3:2]),
  .oAngle( Angle   ),
  .number( Serv1),
  .numbData(Serv1)
//.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
);
//UI h1(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle1   ),
//  .number( Serv2),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h2(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle2   ),
//  .number( Serv3),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h3(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle3   ),
//  .number( Serv4),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h4(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle4   ),
//  .number( Serv5),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h5(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle5   ),
//  .number( Serv6),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h6(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle6   ),
//  .number( Serv7),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h7(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle7   ),
//  .number( Serv8),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h8(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle8   ),
//  .number( Serv9),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h9(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle9   ),
//  .number( Serv10),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h10(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle10   ),
//  .number( Serv11),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h11(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle11   ),
//  .number( Serv12),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h12(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle12   ),
//  .number( Serv13),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h13(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle13   ),
//  .number( Serv14),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
//UI h14(
//
//  .Clk  ( Clk2 ),
//  .Rst_n( Rst_n ),
//  .iKey  ( RxData[0]),
//  .iSW   ( RxData[3:1]),
//  .oAngle( Angle14   ),
//  .number( Serv15),
//  .numbData(RxData[7:4])
////.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
//);
`define DUR_CLOCK_NUM ( 50000000/50)            // clock count in 20 ms
`define DEGREE_MAX    ( `DUR_CLOCK_NUM*25/200) // 2.5 ms 125000
`define DEGREE_MIN    ( `DUR_CLOCK_NUM*5/200)  // 0.5 ms 25000
wire [31:0] PwmAngle;
assign  PwmAngle = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle)+`DEGREE_MIN;
//assign  PwmAngle1 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle1)+`DEGREE_MIN;
//assign  PwmAngle2 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle2)+`DEGREE_MIN;
//assign  PwmAngle3 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle3)+`DEGREE_MIN;
//assign  PwmAngle4 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle4)+`DEGREE_MIN;
//assign  PwmAngle5 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle5)+`DEGREE_MIN;
//assign  PwmAngle6 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle6)+`DEGREE_MIN;
//assign  PwmAngle7 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle7)+`DEGREE_MIN;
//assign  PwmAngle8 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle8)+`DEGREE_MIN;
//assign  PwmAngle9 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle9)+`DEGREE_MIN;
//assign  PwmAngle10 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle10)+`DEGREE_MIN;
//assign  PwmAngle11 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle11)+`DEGREE_MIN;
//assign  PwmAngle12 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle12)+`DEGREE_MIN;
//assign  PwmAngle13 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle13)+`DEGREE_MIN;
//assign  PwmAngle14 = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle14)+`DEGREE_MIN;
PWM_Geneator p0(
	.Clk      ( Clk2),
	.Rst_n  ( Rst_n      ),
	//
	.high_dur ( PwmAngle       ),
	.total_dur( `DUR_CLOCK_NUM ),
	//
	.PWM      ( Pwm_0 )
);
//PWM_Geneator p1(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle1       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_1 )
//);
//PWM_Geneator p2(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle2       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_2 )
//);
//PWM_Geneator p3(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle3       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_3 )
//);
//PWM_Geneator p4(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle4       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_4 )
//);
//PWM_Geneator p5(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle5       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_5 )
//);
//PWM_Geneator p6(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle6       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_6 )
//);
//PWM_Geneator p7(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle7       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_7 )
//);
//PWM_Geneator p8(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle8       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_8 )
//);
//PWM_Geneator p9(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle9       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_9 )
//);
//PWM_Geneator p10(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle10       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_10 )
//);
//PWM_Geneator p11(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle11       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_11 )
//);
//PWM_Geneator p12(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle12       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_12 )
//);
//PWM_Geneator p13(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle13       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_13 )
//);
//PWM_Geneator p14(
//	.Clk      ( Clk2),
//	.Rst_n  ( Rst_n      ),
//	//
//	.high_dur ( PwmAngle14       ),
//	.total_dur( `DUR_CLOCK_NUM ),
//	//
//	.PWM      ( Pwm_14 )
//);



endmodule
