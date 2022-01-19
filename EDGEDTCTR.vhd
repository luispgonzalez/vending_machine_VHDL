----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 18:03:41
-- Design Name: 
-- Module Name: EDGEDTCTR - Behavioral
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

entity EDGEDTCTR is
    port (
        clk : in std_logic;
        reset: in std_logic;
        sync_in : in std_logic;
        edge : out std_logic
    );
end EDGEDTCTR;

architecture Behavioral of EDGEDTCTR is
    signal sreg : std_logic_vector(2 downto 0);
begin
    process (reset,clk)
    begin
        if (reset='0') then
            sreg<="000";
        elsif rising_edge(clk) then
            sreg <= sreg(1 downto 0) & sync_in;
        end if;
    end process;

    edge<= '0' when reset='0' else
 '1' when sreg="100" else
 '0';
end Behavioral;
