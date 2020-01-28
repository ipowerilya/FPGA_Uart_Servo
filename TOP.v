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
inout [3:0] GPIO_1;
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
wire        Pwm_0;
wire        number1;

assign GPIO_1[0] = Pwm_0;
assign GPIO_1[2] = Pwm_0;
assign GPIO_1[3] = Pwm_0;
/////////////////////////////////////////////////////////////////////////////////////////
assign 		RxEn = 1'b1	;
assign 		TxEn = 1'b1	;
assign 		BaudRate = 16'd325; 	//baud rate set to 9600 for the HC-06 bluetooth module. Why 325? (Read comment in baud rate generator file)
assign 		NBits = 4'b1000	;	//We send/receive 8 bits
/////////////////////////////////////////////////////////////////////////////////////////
assign nubmer1=3'b000;
assign nubmer2=3'b001;
assign nubmer3 =3'b011;
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
  .iKey  ( RxData[0]),
  .iSW   ( RxData[4:1]),
  .oAngle( Angle   ),
  .number( nubmer1),
  .numbData(RxData[7:5])
//.iKey  ( RxData[0]), .iSW   ( RxData[4:1])
);
`define DUR_CLOCK_NUM ( 50000000/50)            // clock count in 20 ms
`define DEGREE_MAX    ( `DUR_CLOCK_NUM*25/200) // 2.5 ms 125000
`define DEGREE_MIN    ( `DUR_CLOCK_NUM*5/200)  // 0.5 ms 25000
wire [31:0] PwmAngle;
assign  PwmAngle = (((`DEGREE_MAX - `DEGREE_MIN)/180)*Angle)+`DEGREE_MIN;
PWM_Geneator p0(
	.Clk      ( Clk2),
	.Rst_n  ( Rst_n      ),
	//
	.high_dur ( PwmAngle       ),
	.total_dur( `DUR_CLOCK_NUM ),
	//
	.PWM      ( Pwm_0 )
);


endmodule
