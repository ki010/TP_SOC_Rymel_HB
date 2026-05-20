LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg32_avalon_interface IS
PORT (
	clock, resetn : IN STD_LOGIC;
	read, write, chipselect : IN STD_LOGIC;
	writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	dc_motor_p_R : OUT STD_LOGIC;
	dc_motor_n_R : OUT STD_LOGIC;
	dc_motor_p_L : OUT STD_LOGIC;
	dc_motor_n_L : OUT STD_LOGIC );
END reg32_avalon_interface;

ARCHITECTURE Structure OF reg32_avalon_interface IS
SIGNAL local_byteenable : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL to_reg, from_reg : STD_LOGIC_VECTOR(31 DOWNTO 0);

COMPONENT reg32
	PORT (
	clock, resetn : IN STD_LOGIC;
	D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
END COMPONENT;

COMPONENT PWM_generation
	PORT (
		clk, reset_n : IN STD_LOGIC;
		s_writedataR, s_writedataL : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		dc_motor_p_R, dc_motor_n_R, dc_motor_p_L, dc_motor_n_L : OUT STD_LOGIC );
END COMPONENT;

BEGIN
	to_reg <= writedata;
	WITH (chipselect AND write) SELECT
	local_byteenable <= byteenable WHEN '1', "0000" WHEN OTHERS;

	reg_instance: reg32 PORT MAP (clock, resetn, to_reg, local_byteenable, from_reg);
	motor_pwm_instance: PWM_generation PORT MAP (
		clock,
		resetn,
		from_reg(13 DOWNTO 0),
		from_reg(29 DOWNTO 16),
		dc_motor_p_R,
		dc_motor_n_R,
		dc_motor_p_L,
		dc_motor_n_L);
	readdata <= from_reg;

END Structure;
