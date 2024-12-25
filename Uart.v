`timescale 1ns / 1ps

module uart(
  input clk,
  input rst,
  input [3:0] sw, // Switches for data input
  input send_button, 
  output reg [3:0]led,
  output tx // UART transmit
);

  // UART parameters (adjust baud rate if needed)
  parameter BAUD_RATE = 9600;
  parameter CLOCK_FREQ = 100_000_000; // Nexys 4 DDR clock frequency
  parameter BAUD_GEN = CLOCK_FREQ / BAUD_RATE;

  // State machine for sending data
  reg [2:0] state;
  parameter IDLE = 3'b000,
            START_BIT = 3'b001,
            DATA_BITS = 3'b010,
            STOP_BIT = 3'b011,
            DONE = 3'b100;

  // Data to be sent
  reg [7:0] data_out;
  reg [3:0] bit_count;

  // UART transmit signal
  reg tx_out;
  
  // Baud rate generator
  reg [15:0] baud_counter;

  always @(posedge clk) begin
    if (rst) begin
      state <= IDLE;
      data_out <= 8'b0;
      bit_count <= 4'b0;
      tx_out <= 1'b1; // Start with tx high (idle)
      baud_counter <= 0;
      led <= 4'b0000; 

    end else begin
      case (state)
        IDLE: begin
          if (send_button) begin // Send button pressed
            data_out <= {4'b0, sw}; // Pack switch data into 8 bits (lower 4 bits)
            state <= START_BIT;
            baud_counter <= 0; 
              led <= sw;
          end
        end
        START_BIT: begin
          if (baud_counter == BAUD_GEN - 1) begin
            tx_out <= 0; // Start bit
            state <= DATA_BITS;
            bit_count <= 0;
            baud_counter <= 0;
          end else begin
            baud_counter <= baud_counter + 1;
          end
        end
        DATA_BITS: begin
          if (baud_counter == BAUD_GEN - 1) begin
            tx_out <= data_out[bit_count]; // Send data bits one by one
            bit_count <= bit_count + 1;
            if (bit_count == 8) begin  // All data bits sent
              state <= STOP_BIT;
            end
             baud_counter <= 0;
          end else begin
            baud_counter <= baud_counter + 1;
          end
        end
        STOP_BIT: begin
          if (baud_counter == BAUD_GEN - 1) begin
            tx_out <= 1'b1; // Stop bit
            state <= DONE; // Transmission complete
            baud_counter <= 0;
          end else begin
             baud_counter <= baud_counter + 1;
          end
        end
        DONE: begin
          state <= IDLE;  // Go back to idle and wait for the next button press
        end
      endcase
    end
  end
  
  assign tx = tx_out; 

endmodule