----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 17:58:07
-- Design Name: 
-- Module Name: DEBOUNCER - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DEBOUNCER is
    port (
        clk	: in std_logic;
        btn_in	: in std_logic;
        btn_out	: out std_logic);
end DEBOUNCER;

architecture Behavioral of DEBOUNCER is
    constant CNT_SIZE : integer := 19;
    signal btn_prev   : std_logic := '0';
    signal counter    : std_logic_vector(CNT_SIZE downto 0) := (others => '0');

begin
    process(clk)
    begin
        if (clk'event and clk='1') then
            if (btn_prev xor btn_in) = '1' then
                counter <= (others => '0');
                btn_prev <= btn_in;
            elsif (counter(CNT_SIZE) = '0') then
                counter <= counter + 1;
            else
                btn_out <= btn_prev;
            end if;
        end if;
    end process;
end Behavioral;
