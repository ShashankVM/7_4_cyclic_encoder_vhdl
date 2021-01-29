-- Designed by Shashank V M

library IEEE;  
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;
 
 entity cc_7_4 is           
 port(  
      code_in     : in  std_logic_vector(3 downto 0); -- input code
      clk         : in  std_logic;                    -- input clk  
      reset       : in  std_logic;                    -- input synchronous reset  
      code_out    : out std_logic_vector(6 downto 0)); -- output code  
 end cc_7_4;  
 
 architecture rtl of cc_7_4 is
 signal     q   : std_logic_vector(2 downto 0) := (others => '0'); --linear feedback shift register (lfsr)
 signal   sReg  : std_logic_vector(2 downto 0) := (others => '0'); --serial shift register to shift the input code into the lfsr    
 signal cycle   : unsigned(2 downto 0) := (others => '0'); --signal to store value of the cycle 
 begin
   proc: process(clk) 
   begin
   if rising_edge(clk) then
     if reset = '1' then 
      code_out <= (others => '0');
      q     <= "000";  
      sReg  <= "000";
      cycle <= "000";
     elsif cycle = "000" then
        code_out(3 downto 0) <= code_in; 
        sReg <= code_in(3 downto 1);
        q(2) <= code_in(0) xor q(0);
        q(1) <= code_in(0) xor q(0) xor q(2);
        q(0) <= q(1); 
        cycle <= cycle + 1;
     elsif cycle <= "011" then
        sReg <= '0' & sReg(2 downto 1);
        q(2) <= sReg(0) xor q(0);
        q(1) <= sReg(0) xor q(0) xor q(2);
        q(0) <= q(1);
        cycle <= cycle + 1;
     elsif cycle = "100" then   
        code_out(6 downto 4) <= q;
        q     <= "000"; 
        cycle <= "000";
     end if;  
   end if; 
   end process proc;
 end architecture rtl;  
