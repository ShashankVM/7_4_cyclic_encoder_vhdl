-- Sample testbench written by Shashank V M

library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end entity;

architecture simulate of tb is

component cc_7_4 is
  port(  
      code_in     : in  std_logic_vector(3 downto 0); -- input code
      clk         : in  std_logic;                    -- input clk  
      reset       : in  std_logic;                    -- input synchronous reset  
      code_out    : out std_logic_vector(6 downto 0));-- output code  
end component cc_7_4; 

 signal clk       :  std_logic:= '0'; 
 signal reset     :  std_logic:= '1'; 
 signal code_in   :  std_logic_vector(3 downto 0):= "0011";   
 signal code_out  :  std_logic_vector(6 downto 0):= "0000000";
 
begin 
  --instantiate the unit under test (UUT)
   uut: cc_7_4
        port map (
          clk         => clk,
          reset       => reset,
          code_in     => code_in,
          code_out    => code_out
       );
       
  --Clock Process     
  clock_proc: process begin
  clk <= '1'; wait for 5 ns;
  clk <= '0'; wait for 5 ns;
  end process clock_proc;

    --Stimulus Process
  stim_proc: process
  begin  
  wait until falling_edge(clk);
  reset <= '0';
  wait until falling_edge(clk);
  wait until falling_edge(clk);
  wait until falling_edge(clk);
  wait until falling_edge(clk);
  wait until falling_edge(clk);
  wait until falling_edge(clk);
  wait until falling_edge(clk);
  std.env.stop(0);
  end process stim_proc;
  
end architecture simulate;  
