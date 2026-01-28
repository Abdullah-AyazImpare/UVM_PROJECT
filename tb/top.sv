import uvm_pkg::*;

module top;
  logic clk;
  axi_if if1(clk);
  axi_lite_slave d0(if1);
initial clk = 0;
always #5 clk = ~clk;

  initial begin
    if1.ARESETN =0;
    #20;
    if1.ARESETN =1;
  end
initial begin
    uvm_config_db#(virtual axi_if)::set(null,"*","axi_if",if1);
    run_test("test");
    #10000;
    $finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
end

initial begin
  #100000000;
$finish;
end
endmodule
