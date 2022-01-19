----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 19:00:36
-- Design Name: 
-- Module Name: counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
Port (
    clk: in std_logic;
    c10,c20,c50,e1,reset:in std_logic;
    num: out std_logic_vector (3 downto 0)
 );
end counter;

architecture Behavioral of counter is
signal cnt, euro: natural;
signal unidades, decenas: natural;
signal total: std_logic_vector (7 downto 0);
signal decenas_b,unidades_b: std_logic_vector(3 downto 0);
begin
total <= decenas_b & unidades_b;
process (reset,c10,c20,c50,e1)
	begin
	  if (reset='0') then-- hemos cambiado a 0
	     cnt<=0;
      else
			if c10='1' then 
			cnt<=cnt+1;
			end if;
			if c20='1' then
			cnt<=cnt+2; 
			end if;
			if c50='1' then
			cnt<=cnt+5; 
			end if;
			if e1='1' then
			euro<=euro+1;  
			end if;	 
			
	  end if;
	  
	  case total is when "00000000"=>num<="0000";-- 0 cent
	  when "00000001"=>num<="0001";--10 cent
	  when "00000010"=>num<="0010";--20 cent
	  when "00000011"=>num<="0011";--30 cent
	  when "00000100"=>num<="0100";--40 cent
	  when "00000101"=>num<="0101";--50 cent
	  when "00000110"=>num<="0110";--60 cent
	  when "00000111"=>num<="0111";--70 cent
	  when "00001000"=>num<="1000";--80 cent
	  when "00001001"=>num<="1001";--90 cent
	  when "00010000"=>num<="1010";--1.00 euros
	  when "00010001"=>num<="1011";--1.10 euros
	  when "00010010"=>num<="1100";--1.20 euros
	  when others=>num<="1101";--error
	  end case;
	end process;
decenas<=euro;
unidades<=cnt;


with unidades select
    unidades_b<="0000" WHEN 0,
				"0001" WHEN 1,
				"0010" WHEN 2,
				"0011" WHEN 3,
				"0100" WHEN 4,
				"0101" WHEN 5,
				"0110" WHEN 6,
				"0111" WHEN 7,  
				"1000" WHEN 8, 
				"1001" WHEN 9, 
				"1010" WHEN others;
with decenas select
    decenas_b<="0000" WHEN 0,
				"0001" WHEN 1,
				"0010" WHEN 2,
				"0011" WHEN 3,
				"0100" WHEN 4,
				"0101" WHEN 5,
				"0110" WHEN 6,
				"0111" WHEN 7,  
				"1000" WHEN 8, 
				"1001" WHEN 9, 
				"1010" WHEN others;
				

end Behavioral;
