`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.12.2018 11:19:26
// Design Name: 
// Module Name: sv_trigger_gen
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
// 
//////////////////////////////////////////////////////////////////////////////////


module sv_trigger_gen(

  input  logic i_clk,              //system clock
  input  logic i_aresetn,          //system reset 
  
  input  logic ext_input,          //for external trigger
  input  logic encoder_step_input, //encoder trigger

  input  logic en_enc_input,       //if '1' use encoder_step_input, if '0' use ext_input

  output logic o_trigger           //output signal for trigger

);

//DESCRIPTION
//Use this module to generate trigger signal for python1300_ip_core.
//You could choose if trigger is external or an output of quad decoder module. 
//Notice that we don't have any debouncing circuits here, only sync(two regs in a row for external trigger)

logic       mux_trigger_signal;
logic [0:1] ext_trigger_sync;

//SYNC
always_ff @ ( posedge i_clk, negedge i_aresetn ) begin

    if ( ~i_aresetn ) begin  
        ext_trigger_sync <= 2'b00;
    end else begin
        ext_trigger_sync <= {ext_input, ext_trigger_sync[0]};
    end
end

//MUX
assign mux_trigger_signal = en_enc_input ? encoder_step_input : ext_trigger_sync[1];


//OUTPUT reg
always_ff @ ( posedge i_clk, negedge i_aresetn ) begin

    if ( ~i_aresetn ) begin  
        o_trigger <= 1'b0;
    end else begin
        o_trigger <= mux_trigger_signal;
    end
end

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
endmodule
