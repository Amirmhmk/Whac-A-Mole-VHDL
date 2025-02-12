library ieee;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity new_project2_tb is
end new_project2_tb;

architecture TB_ARCHITECTURE of new_project2_tb is
	-- Component declaration of the tested unit
	component new_project2
	port(
		start : in STD_LOGIC;
		reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		random : in STD_LOGIC;
		stop : in STD_LOGIC;
		hammer : in STD_LOGIC_VECTOR(2 downto 0);
		total_time : in INTEGER;
		input_hole : in STD_LOGIC_VECTOR(13 downto 0);
		number_mouse : out INTEGER;
		bomb : out STD_LOGIC;
		coin : out STD_LOGIC;
		finish : out STD_LOGIC;
		time_left : out INTEGER;
		score : out INTEGER;
		state_hole1 : out STD_LOGIC_VECTOR(1 downto 0);
		state_hole2 : out STD_LOGIC_VECTOR(1 downto 0);
		state_hole3 : out STD_LOGIC_VECTOR(1 downto 0);
		state_hole4 : out STD_LOGIC_VECTOR(1 downto 0);
		state_hole5 : out STD_LOGIC_VECTOR(1 downto 0);
		state_hole6 : out STD_LOGIC_VECTOR(1 downto 0);
		state_hole7 : out STD_LOGIC_VECTOR(1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal start : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal clk : STD_LOGIC := '1';
	signal random : STD_LOGIC;
	signal stop : STD_LOGIC;
	signal hammer : STD_LOGIC_VECTOR(2 downto 0);
	signal total_time : INTEGER;
	signal input_hole : STD_LOGIC_VECTOR(13 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal number_mouse : INTEGER;
	signal bomb : STD_LOGIC;
	signal coin : STD_LOGIC;
	signal finish : STD_LOGIC;
	signal time_left : INTEGER;
	signal score : INTEGER;
	signal state_hole1 : STD_LOGIC_VECTOR(1 downto 0);
	signal state_hole2 : STD_LOGIC_VECTOR(1 downto 0);
	signal state_hole3 : STD_LOGIC_VECTOR(1 downto 0);
	signal state_hole4 : STD_LOGIC_VECTOR(1 downto 0);
	signal state_hole5 : STD_LOGIC_VECTOR(1 downto 0);
	signal state_hole6 : STD_LOGIC_VECTOR(1 downto 0);
	signal state_hole7 : STD_LOGIC_VECTOR(1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : new_project2
		port map (
			start => start,
			reset => reset,
			clk => clk,
			random => random,
			stop => stop,
			hammer => hammer,
			total_time => total_time,
			input_hole => input_hole,
			number_mouse => number_mouse,
			bomb => bomb,
			coin => coin,
			finish => finish,
			time_left => time_left,
			score => score,
			state_hole1 => state_hole1,
			state_hole2 => state_hole2,
			state_hole3 => state_hole3,
			state_hole4 => state_hole4,
			state_hole5 => state_hole5,
			state_hole6 => state_hole6,
			state_hole7 => state_hole7
		);
		
		clk <= not clk after 5ms;
		reset <= '1'   after 1 ms , '0' after 2 ms , '1'   after 40000 ms , '0' after 40002ms;
		start <= '1' after 2000 ms , '0' after  2500 ms , '1'   after 41000 ms , '0' after 41500 ms;
		random <= '0';
		input_hole <= "10110010101101";
		stop <= '0' , '1' after 20000 ms , '0' after 27000 ms;
		total_time <= 30;
		hammer <= "001" after 3000 ms , "000" after 3010 ms ,
		"001" after 4000 ms , "000" after 4010ms , 
		"010" after 8000 ms , "000" after 8010ms , 
		"001" after 9000 ms , "000" after 9010ms ,
		"100" after 10000 ms , "000" after 10010ms ,
		"111" after 11000 ms , "000" after 11010ms ,
		"011" after 15000 ms , "000" after 15010ms ,
		"111" after 16000 ms , "000" after 16010ms ,
		"010" after 18000 ms , "000" after 18010ms ,
		"001" after 19000 ms , "000" after 19010ms ,
		"001" after 23000 ms , "000" after 23010ms ,
		"010" after 28000 ms , "000" after 28010ms, 
		"111" after 43000 ms , "000" after 43010ms ,
		"100" after 46000 ms , "000" after 46010ms 
		;

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_new_project2 of new_project2_tb is
	for TB_ARCHITECTURE
		for UUT : new_project2
			use entity work.new_project2(new_project2);
		end for;
	end for;
end TESTBENCH_FOR_new_project2;

