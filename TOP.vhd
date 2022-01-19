----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 17:53:16
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
    port(

        clk: in std_logic;
        PUSH_10CENT:in std_logic;
        PUSH_20CENT:in std_logic;
        PUSH_50CENT:in std_logic;
        PUSH_1EURO:in std_logic;
        reset: in std_logic;
        segmentos:out std_logic_vector(7 downto 0);
        digsel:out std_logic_vector(7 downto 0);
        sw1: in std_logic;
        sw2: in std_logic;
        sw3: in std_logic;
        sw4: in std_logic;
        led:out std_logic_vector(3 downto 0)
    );
end TOP;

architecture Behavioral of TOP is

    --signals
    signal sync1: std_logic;
    signal sync2: std_logic;
    signal sync3: std_logic;
    signal sync4:std_logic;
    signal debo1:std_logic;
    signal debo2:std_logic;
    signal debo3: std_logic;
    signal debo4:std_logic;
    signal edge1:std_logic;
    signal edge2:std_logic;
    signal edge3:std_logic;
    signal edge4:std_logic;
    signal numero1:std_logic_vector(3 downto 0);
    signal venerr1:std_logic_vector(1 downto 0);
    signal eleccion:std_logic;

    --components
    component DEBOUNCER is
        port(
            clk:in std_logic;
            btn_in: in std_logic;
            btn_out:out std_logic
        );
    end component;

    component EDGEDTCTR is
        port(
            clk: in std_logic;
            sync_in: in std_logic;
            edge: out std_logic;
            reset:in std_logic
        );
    end component;

    component SYNCHRNZR is
        port(
            clk: in std_logic;
            async_in: in std_logic;
            sync_out:out std_logic;
            reset: in std_logic
        );
    end component;

    component counter is
        port(
            clk: in std_logic;
            c10:in std_logic;
            c20: in std_logic;
            c50: in std_logic;
            e1:in std_logic;
            reset: in std_logic;
            num:out std_logic_vector(3 downto 0)
        );
    end component;

    component FSM is
        port(
            clk: in std_logic;
            reset:in std_logic;
            bits_venta:out std_logic_vector(1 downto 0);
            pushbutton: in std_logic_vector(3 downto 0);
            s_eleccion:in std_logic
        );
    end component;

    component FSM_SW is
        port(
            clk: in std_logic;
            reset:in std_logic;
            sw1: in std_logic;
            sw2: in std_logic;
            sw3: in std_logic;
            sw4: in std_logic;
            s_eleccion: out std_logic;
            led: out std_logic_vector(3 downto 0)
        );
    end component;


    component Display_Control is
        port(
            num: in std_logic_vector(3 downto 0);
            clk: in std_logic;
            Venerr: in std_logic_vector(1 downto 0);
            digsel:out std_logic_vector(7 downto 0);
            segmentos: out std_logic_vector(7 downto 0)
        );
    end component;

begin


    --INSTANCIACION BOTONES:
    --10cent
    inst_sincronizador1: SYNCHRNZR port map(
            clk=>clk,
            async_in=>PUSH_10CENT,
            sync_out=>sync1,
            reset=>reset
        );

    inst_debouncer1: DEBOUNCER port map(
            clk=>clk,
            btn_in=>sync1,
            btn_out=>debo1
        );

    inst_edgedtctr1: EDGEDTCTR port map(
            clk=>clk,
            reset=>reset,
            sync_in=>debo1,
            edge=>edge1
        );

    --20 cent
    inst_sincronizador2: SYNCHRNZR port map(
            clk=>clk,
            async_in=>PUSH_20CENT,
            sync_out=>sync2,
            reset=>reset
        );

    inst_debouncer2: DEBOUNCER port map(
            clk=>clk,
            btn_in=>sync2,
            btn_out=>debo2
        );

    inst_edgedtctr2: EDGEDTCTR port map(
            clk=>clk,
            reset=>reset,
            sync_in=>debo2,
            edge=>edge2
        );

    --50 cent
    inst_sincronizador3: SYNCHRNZR port map(
            clk=>clk,
            async_in=>PUSH_50CENT,
            sync_out=>sync3,
            reset=>reset
        );

    inst_debouncer3: DEBOUNCER port map(
            clk=>clk,
            btn_in=>sync3,
            btn_out=>debo3
        );

    inst_edgedtctr3: EDGEDTCTR port map(
            clk=>clk,
            reset=>reset,
            sync_in=>debo3,
            edge=>edge1
        );

    --1 euro
    inst_sincronizador4: SYNCHRNZR port map(
            clk=>clk,
            async_in=>PUSH_1EURO,
            sync_out=>sync4,
            reset=>reset
        );

    inst_debouncer4: DEBOUNCER port map(
            clk=>clk,
            btn_in=>sync4,
            btn_out=>debo4
        );

    inst_edgedtctr4: EDGEDTCTR port map(
            clk=>clk,
            reset=>reset,
            sync_in=>debo4,
            edge=>edge4
        );


    --INSTANCIACION CONTADOR

    inst_sumador:counter port map(

            clk=>clk,
            c10=>edge1,
            c20=>edge2,
            c50=>edge3,
            e1=>edge4,
            reset=>reset,
            num=>numero1
        );



    inst_fsmdinero:FSM port map(
            clk=>clk,
            pushbutton=>numero1,
            bits_venta=>venerr1,
            reset=>reset,
            s_eleccion=>eleccion
        );

inst_fsmsw:FSM_SW port map(
            clk=>clk,
            reset=>reset,
            sw1=>sw1,
            sw2=>sw2,
            sw3=>sw3,
            sw4=>sw4,
            led=>led,
            s_eleccion=>eleccion
        );


    inst_display1:Display_Control port map(
            clk=>clk,
            num=>numero1,
            Venerr=>venerr1,
            digsel=>digsel,
            segmentos=>segmentos
        );

end Behavioral;
