----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 18:04:43
-- Design Name: 
-- Module Name: SYNCHRNZR - Behavioral
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

entity SYNCHRNZR is
    Port (
        clk:in std_logic;
        reset:in std_logic;
        async_in: in std_logic;
        sync_out:out std_logic
    );
end SYNCHRNZR;

architecture Behavioral of SYNCHRNZR is
    signal sreg : std_logic_vector(1 downto 0);
begin
    process (reset,clk)
    begin
        if (reset='0') then
            sync_out <= '0';
            sreg <="00";
        elsif rising_edge(clk) then
            sync_out <= sreg(1);
            sreg <= sreg(0) & async_in;
        end if;
    end process;
end Behavioral;
