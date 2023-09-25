`timescale 1ns/10ps

// Test bench module
module tb_lab6;

// Input Array
/////////////////////////////////////////////////////////
//                  Test Bench Signals                 //
/////////////////////////////////////////////////////////
reg clk;
integer i,j,k;

// Matrices
reg signed [7:0] matrixA [63:0];
reg signed [7:0] matrixB [63:0];
reg signed [18:0] matrixC [63:0];

// Comparison Flag
reg comparison;

/////////////////////////////////////////////////////////
//                  I/O Declarations                   //
/////////////////////////////////////////////////////////
// declare variables to hold signals going into submodule
reg start;
reg reset;


// Misc "wires"
wire done, we_c, macc_clear;
wire [10:0] clock_count;
wire signed [18:0] mac_out1, mac_out2, mac_out3, mac_out4, mac_out5, mac_out6, mac_out7, mac_out8, buff_out1, buff_out2, buff_out, mac_out;
wire signed [7:0] out_a1, out_a2, out_b1, out_b2, out_a, out_b, out_a3, out_a4, out_a5, out_a6, out_a7, out_a8;
wire [5:0] idx_c, idx_c1, idx_c2, idx_b1, idx_b2, idx_a1, idx_a2, idx_a, idx_b, idx_a3, idx_a4, idx_a5, idx_a6, idx_a7, idx_a8;

/////////////////////////////////////////////////////////
//              Submodule Instantiation                //
/////////////////////////////////////////////////////////

/*****************************************
|------|    RENAME TO MATCH YOUR MODULE */
//mac1 DUT
//(
//    .clk   (clk),
//    .start (start),
//    .reset (reset),
//    .done       (done),
//    .clock_count (clock_count),
//	 .idx_c (idx_c),
//	 .idx_b (idx_b),
//	 .idx_a (idx_a),
//	 .we_c (we_c),
//	 .macc_clear(macc_clear),
//	 .out_a(out_a),
//	 .out_b(out_b),
//	 .mac_out(mac_out)
//	 
//  );

//mac2 DUT
//(
//    .clk   (clk),
//    .start (start),
//    .reset (reset),
//    .done       (done),
//    .clock_count (clock_count),
//	 .idx_c (idx_c),
//	 .idx_b (idx_b),
//	 .idx_a1 (idx_a1),
//	 .idx_a2 (idx_a2),
//	 .we_c (we_c),
//	 .macc_clear(macc_clear),
//	 .out_a1(out_a1),
//	 .out_a2(out_a2),
//	 .out_b(out_b),
//	 .mac_out1(mac_out1),
//	 .mac_out2(mac_out2),
//	 .buff_out(buff_out)
//  );
  
//mac3 DUT
//(
//    .clk   (clk),
//    .start (start),
//    .reset (reset),
//    .done       (done),
//    .clock_count (clock_count),
//	 .idx_c (idx_c),
//	 .idx_b1 (idx_b1),
//	 .idx_b2 (idx_b2),
//	 .idx_a1 (idx_a1),
//	 .idx_a2 (idx_a2),
//	 .we_c (we_c),
//	 .macc_clear(macc_clear),
//	 .out_a1(out_a1),
//	 .out_a2(out_a2),
//	 .out_b1(out_b1),
//	 .out_b2(out_b2),
//	 .mac_out1(mac_out1),
//	 .mac_out2(mac_out2),
//	 .mac_out3(mac_out3),
//	 .mac_out4(mac_out4),
//	 .buff_out(buff_out)
//  );

mac8 DUT
(
    .clk   (clk),
    .start (start),
    .reset (reset),
    .done       (done),
    .clock_count (clock_count),
	 .idx_a1 (idx_a1),
	 .idx_a2 (idx_a2),
	 .idx_a3 (idx_a3),
	 .idx_a4 (idx_a4),
	 .idx_a5 (idx_a5),
	 .idx_a6 (idx_a6),
	 .idx_a7 (idx_a7),
	 .idx_a8 (idx_a8),
	 .idx_c1 (idx_c1),
	 .idx_c2 (idx_c2),
	 .idx_b (idx_b),
	 .we_c (we_c),
	 .macc_clear(macc_clear),
	 .out_a1(out_a1),
	 .out_a2(out_a2),
	 .out_a3(out_a3),
	 .out_a4(out_a4),
	 .out_a5(out_a5),
	 .out_a6(out_a6),
	 .out_a7(out_a7),
	 .out_a8(out_a8),
	 .out_b(out_b),
	 .mac_out1(mac_out1),
	 .mac_out2(mac_out2),
	 .mac_out3(mac_out3),
	 .mac_out4(mac_out4),
	 .mac_out5(mac_out5),
	 .mac_out6(mac_out6),
	 .mac_out7(mac_out7),
	 .mac_out8(mac_out8),
	 .buff_out1(buff_out1),
	 .buff_out2(buff_out2)
  );

initial begin
  
  //****************************************************
  // CHANGE .TXT FILE NAMES TO MATCH THE ONES USED IN
  // YOUR MEMORY MODULES
  
  // Initialize Matrices
  $readmemb("ram_a_init.txt",matrixA);
  $readmemb("ram_b_init.txt",matrixB);
  
  //***************************************************
  
  /////////////////////////////////////////////////////////
  //                    Perform Test                     //
  /////////////////////////////////////////////////////////
  reset <= 1'b1;
  start <= 1'b0;
  clk <= 1'b0;
  repeat(2) @(posedge clk);
  reset <= 1'b0;
  repeat(2) @(posedge clk);
  start <= 1'b1;
  repeat(1) @(posedge clk);
  start <= 1'b0;
  
  // ------------------------
  // Wait for done or timeout
  fork : wait_or_timeout
  begin
    repeat(1000) @(posedge clk);
    disable wait_or_timeout;
  end
  begin
    @(posedge done);
    disable wait_or_timeout;
  end
  join
  // End Timeout Routing
  //-------------------------
  
  /////////////////////////////////////////////////////////
  //                Verify Computation                   //
  /////////////////////////////////////////////////////////
  
  // Print Input Matrices
  $display("Matrix A");
  for(i=0;i<8;i=i+1) begin
    $display(matrixA[i],matrixA[i+8],matrixA[i+16],matrixA[i+24],matrixA[i+32],matrixA[i+40],matrixA[i+48],matrixA[i+56]);
  end
  
  $display("\n Matrix B");
    for(i=0;i<8;i=i+1) begin
    $display(matrixB[i],matrixB[i+8],matrixB[i+16],matrixB[i+24],matrixB[i+32],matrixB[i+40],matrixB[i+48],matrixB[i+56]);
  end
  
  // Generate Expected Result
  for(i=0;i<8;i=i+1) begin
    for(j=0;j<8;j=j+1) begin
      matrixC[8*i+j] = 0;
      for(k=0;k<8;k=k+1) begin
        matrixC[8*i+j] = matrixC[8*i+j] + matrixA[j+8*k]*matrixB[k+8*i];
      end
    end
  end
  
  // Display Expected Result
  $display("\nExpected Result");
  for(i=0;i<8;i=i+1) begin
    $display(matrixC[i],matrixC[i+8],matrixC[i+16],matrixC[i+24],matrixC[i+32],matrixC[i+40],matrixC[i+48],matrixC[i+56]);
  end
  
  
  // Display Output Matrix
  $display("\nGenerated Result");
  for(i=0;i<8;i=i+1) begin
    $display(DUT.RAMOUTPUT.mem[i],DUT.RAMOUTPUT.mem[i+8],DUT.RAMOUTPUT.mem[i+16],DUT.RAMOUTPUT.mem[i+24],DUT.RAMOUTPUT.mem[i+32],DUT.RAMOUTPUT.mem[i+40],DUT.RAMOUTPUT.mem[i+48],DUT.RAMOUTPUT.mem[i+56]);
  end

  // Test if the two matrices match
  comparison = 1'b0;
  for(i=0;i<8;i=i+1) begin
    for(j=0;j<8;j=j+1) begin
      if (matrixC[8*i+j] != DUT.RAMOUTPUT.mem[8*i+j]) begin
        $display("Mismatch at indices [%1.1d,%1.1d]",j,i);
        comparison = 1'b1;
      end
    end  
  end
  if (comparison == 1'b0) begin
    $display("\nsuccess :)");
  end
  
  $display("Running Time = %d clock cycles",clock_count);
  
  $stop; // End Simulation
end


// Clock
always begin
   #10;           // wait for initial block to initialize clock
   clk = ~clk;
end

endmodule
