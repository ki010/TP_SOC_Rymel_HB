LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY robot_cutecar_de0nano IS
    PORT (
        SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        KEY : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        CLOCK_50 : IN STD_LOGIC;

        LED : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

        MTR_Sleep_n : OUT STD_LOGIC;
        VCC3P3_PWRON_n : OUT STD_LOGIC;

        MTRR_P : OUT STD_LOGIC;
        MTRR_N : OUT STD_LOGIC;
        MTRL_P : OUT STD_LOGIC;
        MTRL_N : OUT STD_LOGIC;

        DRAM_CLK, DRAM_CKE : OUT STD_LOGIC;
        DRAM_ADDR : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
        DRAM_BA : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        DRAM_CS_N, DRAM_CAS_N, DRAM_RAS_N, DRAM_WE_N : OUT STD_LOGIC;
        DRAM_DQ : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        DRAM_DQM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END robot_cutecar_de0nano;


ARCHITECTURE Structure OF robot_cutecar_de0nano IS

    COMPONENT cutecar
        PORT (
            clk_clk                 : in    std_logic                     := 'X';             -- clk
            reset_reset_n           : in    std_logic                     := 'X';             -- reset_n
            led_export              : out   std_logic_vector(7 downto 0);                     -- export
            sw_export               : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
            sdram_wire_addr         : out   std_logic_vector(12 downto 0);                    -- addr
            sdram_wire_ba           : out   std_logic_vector(1 downto 0);                     -- ba
            sdram_wire_cas_n        : out   std_logic;                                        -- cas_n
            sdram_wire_cke          : out   std_logic;                                        -- cke
            sdram_wire_cs_n         : out   std_logic;                                        -- cs_n
            sdram_wire_dq           : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            sdram_wire_dqm          : out   std_logic_vector(1 downto 0);                     -- dqm
            sdram_wire_ras_n        : out   std_logic;                                        -- ras_n
            sdram_wire_we_n         : out   std_logic;                                        -- we_n
            sdram_clk_clk           : out   std_logic                                        -- clk
          
        );
    END COMPONENT;


    -- horloges
    signal clk_40M : std_logic;
    signal clk_2k : std_logic;



BEGIN


------------------------------------------------
-- activation carte robot
------------------------------------------------

MTR_Sleep_n <= '1';
VCC3P3_PWRON_n <= '0';


------------------------------------------------
-- PLL
------------------------------------------------

PLL_inst : entity work.pll_2freqs
    port map(
        inclk0 => CLOCK_50,
        c0 => clk_40M,
        c1 => clk_2k
    );


------------------------------------------------
-- NIOS
------------------------------------------------

NiosII: nios_system
    PORT MAP (
        clk_clk => CLOCK_50,
        reset_reset_n => KEY(0),

        led_export => open,
        sw_export => SW,

        sdram_wire_addr => DRAM_ADDR,
        sdram_wire_ba => DRAM_BA,
        sdram_wire_cas_n => DRAM_CAS_N,
        sdram_wire_cke => DRAM_CKE,
        sdram_wire_cs_n => DRAM_CS_N,
        sdram_wire_dq => DRAM_DQ,
        sdram_wire_dqm => DRAM_DQM,
        sdram_wire_ras_n => DRAM_RAS_N,
        sdram_wire_we_n => DRAM_WE_N,
        sdram_clk_clk => DRAM_CLK
    );




END Structure;