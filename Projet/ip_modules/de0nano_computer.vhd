library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de0nano_computer IS
    port (
        SW : in STD_LOGIC_VECTOR(3 downto 0);
        KEY : in STD_LOGIC_VECTOR(0 downto 0);
        CLOCK_50 : in STD_LOGIC;

        LED : out STD_LOGIC_VECTOR(7 downto 0);

        MTR_Sleep_n : out STD_LOGIC;
        VCC3P3_PWRON_n : out STD_LOGIC;

        MTRR_P : out STD_LOGIC;
        MTRR_N : out STD_LOGIC;
        MTRL_P : out STD_LOGIC;
        MTRL_N : out STD_LOGIC;

        DRAM_CLK, DRAM_CKE : out STD_LOGIC;
        DRAM_ADDR : out STD_LOGIC_VECTOR(12 downto 0);
        DRAM_BA : out STD_LOGIC_VECTOR(1 downto 0);
        DRAM_CS_N, DRAM_CAS_N, DRAM_RAS_N, DRAM_WE_N : out STD_LOGIC;
        DRAM_DQ : inout STD_LOGIC_VECTOR(15 downto 0);
        DRAM_DQM : out STD_LOGIC_VECTOR(1 downto 0)
    );
end de0nano_computer;


architecture Structure of de0nano_computer is

        component nios_system is
        port (
            clk_clk          : in    std_logic                     := 'X';             -- clk
            reset_reset_n    : in    std_logic                     := 'X';             -- reset_n
            sw_export        : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
            sdram_wire_addr  : out   std_logic_vector(12 downto 0);                    -- addr
            sdram_wire_ba    : out   std_logic_vector(1 downto 0);                     -- ba
            sdram_wire_cas_n : out   std_logic;                                        -- cas_n
            sdram_wire_cke   : out   std_logic;                                        -- cke
            sdram_wire_cs_n  : out   std_logic;                                        -- cs_n
            sdram_wire_dq    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            sdram_wire_dqm   : out   std_logic_vector(1 downto 0);                     -- dqm
            sdram_wire_ras_n : out   std_logic;                                        -- ras_n
            sdram_wire_we_n  : out   std_logic;                                        -- we_n
            sdram_clk_clk    : out   std_logic;                                        -- clk
            to_hex_export       : out std_logic_vector(15 downto 0);                   -- export
            motor_wire_dc_motor_p_r : out std_logic;                                   -- dc_motor_p_R
            motor_wire_dc_motor_n_r : out std_logic;                                   -- dc_motor_n_R
            motor_wire_dc_motor_p_l : out std_logic;                                   -- dc_motor_p_L
            motor_wire_dc_motor_n_l : out std_logic                                    -- dc_motor_n_L
        );
    end component nios_system;


    -- horloges
    signal clk_40M : std_logic;
    signal clk_2k : std_logic;

    -- interfaces
    signal to_hex_sig : std_logic_vector(15 downto 0);


begin
------------------------------------------------
-- activation carte robot
------------------------------------------------
MTR_Sleep_n <= '1';
VCC3P3_PWRON_n <= '0';

------------------------------------------------
-- NIOS
------------------------------------------------
-- Testing reg16
LED <= to_hex_sig(7 downto 0);

NiosII: nios_system
    port map(
        clk_clk => CLOCK_50,
        reset_reset_n => KEY(0),

        sw_export => "0000" & SW,

        sdram_wire_addr => DRAM_ADDR,
        sdram_wire_ba => DRAM_BA,
        sdram_wire_cas_n => DRAM_CAS_N,
        sdram_wire_cke => DRAM_CKE,
        sdram_wire_cs_n => DRAM_CS_N,
        sdram_wire_dq => DRAM_DQ,
        sdram_wire_dqm => DRAM_DQM,
        sdram_wire_ras_n => DRAM_RAS_N,
        sdram_wire_we_n => DRAM_WE_N,
        sdram_clk_clk => DRAM_CLK,
        to_hex_export => to_hex_sig,
        motor_wire_dc_motor_p_r => MTRR_P,
        motor_wire_dc_motor_n_r => MTRR_N,
        motor_wire_dc_motor_p_l => MTRL_P,
        motor_wire_dc_motor_n_l => MTRL_N
    );


end Structure;

