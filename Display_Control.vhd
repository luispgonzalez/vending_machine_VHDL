----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 23:04:23
-- Design Name: 
-- Module Name: Display_Control - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Display_Control is
    PORT(num : IN std_logic_vector(3 DOWNTO 0);
         clk: IN std_logic;
         -- error: IN std_logic;
         --vending: IN std_logic;
         Venerr:in std_logic_vector(1 downto 0);
         digsel : OUT std_logic_vector(7 DOWNTO 0);
         segmentos : OUT std_logic_vector(7 DOWNTO 0) --teniendo en cuenta el punto del display será vector de 8 bits
        );
end Display_Control;

architecture Behavioral of Display_Control is
    signal numero : integer;
    signal digitos: natural range 0 to 7 :=0;
    signal counter: natural range 0 to 18 :=0;
    signal clk_counter: natural range 0 to 2000 :=0;
begin
    process(clk)
    begin
        --Periodo 1.6 ms-> clk_counter=160000
        if rising_edge(clk) then
            clk_counter<=clk_counter + 1;
            --periodo/8 = 0.2 ms -> clk_counter=20000
            if clk_counter>=20000 then
                clk_counter<=0;
                digitos<=digitos +1;
            end if;
            if digitos > 7 then
                digitos<=0;
            end if;
        end if;

    end process;

    process(digitos)
    begin
        numero <= to_integer(unsigned(num));
        if numero<=12 then
            if numero=0 then --0€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10000001";
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=1 then --0.1€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="11001111";--nº 1
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=2 then --0.2€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10010010";--nº 2
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=3 then --0.3€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10000110";--nº 3
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=4 then --0.4€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="11001100";--nº 4
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=5 then --0.5€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10100100";--nº 5
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=6 then --0.6€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10100000";--nº 6
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=7 then --0.7€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10001111";--nº 7
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=8 then --0.8€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10000000";--nº 8
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=9 then --0.9€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10000100";--nº 9
                        digsel <="11111101";
                    when 2=>
                        segmentos<="00000001"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=10 then --1.0€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="10000001";
                        digsel <="11111101";
                    when 2=>
                        segmentos<="01001111"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=11 then --1.1€
                case digitos is
                    when 0=>
                        segmentos<="10000001";
                        digsel <="11111110";
                    when 1=>
                        segmentos<="11001111";
                        digsel <="11111101";
                    when 2=>
                        segmentos<="01001111"; --nºcero con punto
                        digsel <="11111011";
                    when others=>
                        segmentos<="11111111";--no muestra nada en display
                        digsel<="11111111";
                end case;
            end if;

            if numero=12 then
                if Venerr="01" then --1.2€
                    case digitos is
                        when 0=>
                            segmentos<="10000001";
                            digsel <="11111110";
                        when 1=>
                            segmentos<="10010010";
                            digsel <="11111101";
                        when 2=>
                            segmentos<="01001111";
                            digsel <="11111011";
                        when others=>
                            segmentos<="11111111";--no muestra nada en display
                            digsel<="11111111";
                    end case;
                end if;
            end if;

            if numero=13 then -- Da error y se muestra ------
                if Venerr="10" then
                    case digitos is
                        when 0=>
                            digsel <="11111110";
                            segmentos<="11111110";
                        when 1=>
                            digsel <="11111101";
                            segmentos<="11111110";
                        when 2=>
                            digsel <="11111011";
                            segmentos<="11111110";
                        when 3=>
                            digsel <="11110111";
                            segmentos<="11111110";
                        when 4=>
                            digsel <="11101111";
                            segmentos<="11111110";
                        when 5=>
                            digsel <="11011111";
                            segmentos<="11111110";
                        when 6=>
                            digsel <="10111111";
                            segmentos<="11111110";
                        when 7=>
                            digsel <="01111111";
                            segmentos<="11111110";
                        when others=>
                            digsel<="11111111";
                            segmentos<="11111111";
                    end case;
                end if;
            end if;
        end if;


    end process;

end Behavioral;