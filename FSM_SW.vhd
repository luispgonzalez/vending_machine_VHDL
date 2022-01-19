----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2022 17:11:15
-- Design Name: 
-- Module Name: FSM_SW - Behavioral
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

entity FSM_SW is
    port(
        clk: in std_logic;
        reset:in std_logic;
        sw1: in std_logic;
        sw2: in std_logic;
        sw3: in std_logic;
        sw4: in std_logic;
        led: out std_logic_vector(3 downto 0);
        s_eleccion:out std_logic
    );
end FSM_SW;

architecture Behavioral of FSM_SW is
    TYPE REFRESCOS IS (nulo, agua, fanta_naranja, pepsi, aquarius);
    SIGNAL present_state, next_state: REFRESCOS;
    --signal reg: std_logic_vector(3 downto 0);
begin
    process (present_state)
    begin
        next_state <= present_state;
        s_eleccion<='0';
        if(sw1='1') then
            present_state<=agua;
            s_eleccion<='1';
            led(0)<='1';
        else
            led(0)<='0';
        end if;
        if (sw2='1') then
            present_state<=fanta_naranja;
            s_eleccion<='1';
            led(1)<='1';
        else
            led(1)<='0';
        end if;
        if (sw3='1') then
            present_state<=pepsi;
            s_eleccion<='1';
            led(2)<='1';
        else
            led(2)<='0';
        end if;
        if (sw4='1') then
            present_state<=aquarius;
            s_eleccion<='1';
            led(3)<='1';
        else
            led(3)<='0';
        end if;

        case(present_state) is
            when nulo=>
                --s_eleccion<='0';

            when agua =>
                --led(0)<='0';

            when fanta_naranja =>
                --led(1)<='0';

            when pepsi =>
                --led(2)<='0';

            when aquarius =>
                --led(3)<='0';

        end case;
    end process;

    process (clk, reset)
    begin
        if(reset='1') then
            present_state<=nulo;
        elsif (rising_edge(clk)) then
            present_state<=next_state;
        end if;
    end process;

end Behavioral;
