`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2018 16:36:37
// Design Name: 
// Module Name: tb_sv_trigger_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Branch: master
//////////////////////////////////////////////////////////////////////////////////


module tb_sv_trigger_gen();

//signsals
logic clk;
logic aresetn;

logic ext_trig;
logic enc_trig;

logic en_enc;


sv_trigger_gen JOPA(

  .i_clk              ( clk      ),              
  .i_aresetn          ( aresetn  ),          
  
  .ext_input          ( ext_trig ),          
  .encoder_step_input ( enc_trig ), 

  .en_enc_input       ( en_enc   ),       

  .o_trigger          ( )           

);


//generate clk
always
  begin
    clk = 1; #0.5;
    clk = 0; #0.5;
  end

initial
  begin

    aresetn  = 0; ext_trig = 0;
    enc_trig = 0; en_enc   = 0;
    #10; 
    aresetn = 1; #5;

    ext_trig <= 1; #1;
    ext_trig <= 0; #10;

    en_enc <= 1; #10;
    enc_trig <= 1; #1;
    enc_trig <= 0; #10;
    en_enc <= 0;

  end  
endmodule
