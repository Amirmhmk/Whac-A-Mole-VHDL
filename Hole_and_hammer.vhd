-------------------------------------------------------------------------------
--
-- Title       : project_cad
-- Design      : project
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : project_cad.vhd
-- Generated   : Wed Jan 19 02:22:02 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {project_cad} architecture {project_cad}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity project_cad is
	port(
	signal start , reset , clk , random , stop : in std_logic;
	signal hammer : in std_logic_vector(2 downto 0);
	signal total_time :in integer;-- in std_logic_vector(10 downto 0);
	signal input_hole :in std_logic_vector(13 downto 0);
	signal number_mouse: out integer; -- std_logic_vector(10 downto 0);
	signal bomb  , coin , finish : out std_logic;
	signal time_left : out integer;-- out std_logic_vector(10 downto 0);
	signal score :out integer); -- std_logic_vector(10 downto 0)); 
end project_cad;

--}} End of automatically maintained section

architecture project_cad of project_cad is
 signal pseudo_rand : std_logic_vector(0 to 31) := (others => '0'); --rnadom signal process
 signal counter_of_convert : std_logic_vector(6 downto 0) := "0000000" ;	   -- counter of conver pulss
 
 --  system Machine
 type system_state_type is (reset_state , start_state , coin_state , bomb_state ,bomb_exe_state , coin_exe_state , exe_counter5_state);
 signal system_state , system_next_state : system_state_type ;
 signal reset_counter5  , reset_Hole , start_Hole : std_logic ;	--out put 
 signal Mouse : std_logic_vector(1 downto 0) := "00";	-- out put
 signal hit_bomb : std_logic := '0'; -- bomb1 or bomb2 , ... input
 signal hit_coin : std_logic := '0';-- coin1 , coin2 , coin3 ... input
 signal reset_system_total : std_logic := '0';
 --  system Machine 
 
 -- hoel1 machine
 type hole_state_type is (reset_state , start_state , coin_hole , bomb_hole , coinz  , bombz , mouse_hole , empty_hole , emptyz , mousez);
 signal hole_state1, hole_next_state1 : hole_state_type;
 signal hole_state2, hole_next_state2 : hole_state_type;
 signal hole_state3, hole_next_state3 : hole_state_type;
 signal hole_state4, hole_next_state4 : hole_state_type;
 signal hole_state5, hole_next_state5 : hole_state_type;
 signal hole_state6, hole_next_state6 : hole_state_type;
 signal hole_state7, hole_next_state7 : hole_state_type;	
 --out put hole machine
 signal coin1 , bomb1 , hit_mouse1 , Subtract_5_seconds1 :std_logic;
 signal coin2 , bomb2 , hit_mouse2 , Subtract_5_seconds2 :std_logic;
 signal coin3 , bomb3 , hit_mouse3 , Subtract_5_seconds3 :std_logic;
 signal coin4 , bomb4 , hit_mouse4 , Subtract_5_seconds4 :std_logic;
 signal coin5 , bomb5 , hit_mouse5 , Subtract_5_seconds5 :std_logic;
 signal coin6 , bomb6 , hit_mouse6 , Subtract_5_seconds6 :std_logic;
 signal coin7 , bomb7 , hit_mouse7 , Subtract_5_seconds7 :std_logic; 
 --input hole
 signal input_hole1 , input_hole2 , input_hole3 , input_hole4 , input_hole5 , input_hole6 , input_hole7 : std_logic_vector(1 downto 0 ) := "00";
 signal hammer1, hammer2 , hammer3 , hammer4 , hammer5 , hammer6  , hammer7 :std_logic := '0';
 signal reset_hole_total :std_logic := '0';	
--hole machine end

-- counter6 machine 
 type counter6_type is (a0 , a1 , a2 , a3 , a4 , a5 , a6 ,a7);
 signal counter6_state  , counter6_next_state : counter6_type;
 --out put counter5 
 signal counter6 : std_logic := '0';
 
 --counter5 machine
 type counter5_type is (s0 , s1 , s2 , s3 , s4 , s5);
 signal counter5_state  , counter5_next_state : counter5_type;
 --out put counter5 
 signal counter5 : std_logic := '0';
 --counter5 machine
 
-- control conter5 machine (cc) 
type control_counter5_state is (t0 ,t1 , t2);
signal cc_state , cc_next_state : control_counter5_state;
-- out put cc 
signal resetcounter5 :std_logic := '0';
-- control conter5 machine (cc)

-- show coin , bomb
type show_state_type is (r0 ,r1 , r2);
signal show_state , show_next_state : show_state_type; 
signal reset_show : std_logic := '0';
signal one_secend , reset_one_secend  :std_logic := '0';
signal counter_one_secend : integer := 0;
-- out put cc 
signal show_coin , show_bomb :std_logic := '0';

signal finish_game : std_logic := '0';
signal hit_mouse , Subtract_5_seconds  : std_logic := '0'; 
signal sum_of_hit_empty , sum_of_hit_mouse , sum_of_hit_bomb , sum_of_hit_coin : integer ;-- std_logic_vector(10 downto 0) := (others => '0');
--signal  check_time ,time : std_logic_vector(10 downto 0) := (others =>'0');
signal  check_time ,time : integer := 0;
signal hold_start  : std_logic := '0';
signal stop_time : std_logic;

signal finish_time :std_logic := '0';
signal new_clk :std_logic := '0';  --clk 1 secend 

begin		
	-- get random###############################################################
	process(reset , clk)		  								-- get random
	function lfsr32(x: std_logic_vector(0 to 31)) return std_logic_vector is
	begin
		return x(0 to 30) & (x(0) xnor x(1) xnor x(21) xnor x(31));
	end function;
	begin 
		if reset = '1' then
			pseudo_rand <= (others => '0');
		elsif rising_edge(clk) then
			pseudo_rand <= lfsr32(pseudo_rand);
		end if;
	end process; 
	-- get random end########################################################################################
	
	--Pulse conversion##############################################################################################
	process(clk , reset)
	begin
		if reset = '1' then
			counter_of_convert <= (others => '0');
			new_clk <= '0';
		elsif rising_edge(clk) then 
			if 	counter_of_convert = "0110001" then
				new_clk <= not new_clk;
				counter_of_convert <= (others => '0');
			else
				counter_of_convert <= counter_of_convert + 1 ;
			end if;
		end if;
	end process;
	--Pulse conversion end ###########################################################################################
	
	
	--  system Machine ###########################################################################################
	hit_bomb <= bomb1 or bomb2 or bomb3 or bomb4 or bomb5 or bomb6 or bomb7; 
	hit_coin <= coin1 or coin2 or coin3 or coin4 or coin5 or coin6 or coin7;
	reset_system_total <= reset or finish_time;
	--  state rigester
	
	process (clk , reset_system_total)
	begin 
		if reset_system_total = '1' then 
			system_state <= reset_state;
		elsif rising_edge(clk) then
			system_state <= system_next_state;
		end if ;
	end process;
	
	--next state logic	
	process(system_state , start , hit_bomb , hit_coin , counter5 , stop)
	begin
		system_next_state <= system_state;
		if stop = '1' then
			system_next_state <= system_state;
		else
			case system_state is
				when reset_state => if start = '1' then 
					system_next_state <= start_state;
				end if;
				when start_state => if counter5 = '1' then
					system_next_state <= exe_counter5_state;
				elsif hit_coin = '1' then
					system_next_state <= coin_state;
				elsif Hit_bomb = '1' then
					system_next_state <= bomb_state;
				end if ;
				when bomb_state => system_next_state <= bomb_exe_state;
				when coin_state => system_next_state <= coin_exe_state;
				when bomb_exe_state => if counter5 = '1' then
					system_next_state <= exe_counter5_state;
				end if ;
				when coin_exe_state => if counter5 = '1' then
					system_next_state <= exe_counter5_state;
				end if ;
				when exe_counter5_state => system_next_state <= start_state;
				when others => system_next_state <= reset_state;
			end case;
		end if;	
	end process;
	
	--out put logic 
	process (system_state)
	begin
		
		case system_state is
			when reset_state =>reset_counter5 <= '0'; Mouse <="00"; reset_Hole <= '1'; start_Hole <= '0'; 
			when start_state =>reset_counter5 <= '1'; Mouse <="00"; reset_Hole <= '0'; start_Hole <= '1';
			when bomb_state => reset_counter5 <= '0'; Mouse <="00"; reset_Hole <= '1'; start_Hole <= '0';
			when coin_state => reset_counter5 <= '0'; Mouse <="00"; reset_Hole <= '1'; start_Hole <= '0';
			when bomb_exe_state => reset_counter5 <= '1'; Mouse <= "01"; reset_Hole <= '0'; start_Hole <= '0';
			when coin_exe_state => reset_counter5 <= '1'; Mouse <="10"; reset_Hole <= '0'; start_Hole <= '0';
			when exe_counter5_state =>reset_counter5 <= '0'; Mouse <="00"; reset_Hole <= '1'; start_Hole <= '0';
			when others => reset_counter5 <= '0'; Mouse <="00"; reset_Hole <= '0'; start_Hole <= '0';
		end case;
	end process;
	--  system Machine end ##########(reset_state , start_state , coin_hole , bomb_hole , coinz  , bombz , mouse_hole , empty_hole , emptyz , mousez);
	
	--hole1 machine############################################################
	reset_hole_total <= reset or reset_hole ;
	
	process (clk , reset_hole_total)
	begin 
		if reset_hole_total = '1' then 
			hole_state1 <= reset_state;
		elsif rising_edge(clk) then
			hole_state1 <= hole_next_state1;
		end if ;
	end process;
	
	process(hole_state1 , mouse , start_hole , hammer1 , input_hole1)
	begin 
		if stop = '1' then 
			hole_next_state1 <= hole_state1;
		else
			case hole_state1 is 
				when reset_state => if (mouse = "00") and (start_hole ='1' ) then
					hole_next_state1 <= start_state;
				elsif (mouse = "10") and (start_hole ='0' )then
					hole_next_state1 <= mouse_hole;
				elsif (mouse = "01") and (start_hole ='0') then 
					hole_next_state1 <= empty_hole;
				end if ;
				when start_state => if input_hole1 = "00" then
					hole_next_state1 <= empty_hole;
				elsif input_hole1 = "01" then
					hole_next_state1 <= mouse_hole;
				elsif input_hole1 = "10" then 
					hole_next_state1 <= bomb_hole;
				elsif input_hole1 = "11" then 
					hole_next_state1  <= coin_hole;
				end if ;
				when coin_hole => if hammer1 = '1' then 
					hole_next_state1 <= coinz;
				else
					hole_next_state1 <= hole_state1;
				end if ;
				
				when coinz => hole_next_state1 <= hole_state1;
				when bomb_hole => if hammer1 = '1' then
					hole_next_state1 <= bombz;
				else
					hole_next_state1 <= hole_state1;
				end if;
				when bombz => hole_next_state1 <= hole_state1;
				when mouse_hole => if hammer1 = '1' then 
					hole_next_state1 <= mousez ;
				else 
					hole_next_state1 <= hole_state1;
				end if ;
				when mousez => hole_next_state1 <= empty_hole;
				when empty_hole => if hammer1 = '1' then
					hole_next_state1 <= emptyz ;
				else
					hole_next_state1 <= hole_state1;
				end if ;
				when emptyz => hole_next_state1 <= empty_hole; 
				when others => hole_next_state1 <= hole_state1;
			end case;
		end if;
	end process;
	
	process(hole_state1)
	begin
		coin1 <= '0' ; bomb1 <= '0' ; hit_mouse1 <= '0' ; Subtract_5_seconds1 <= '0' ;
		case hole_state1 is 
			when coinz => coin1 <= '1';
			when bombz => bomb1 <= '1';
			when mousez => hit_mouse1 <= '1';
			when emptyz => Subtract_5_seconds1 <= '1' ;
			when others => coin1 <= '0' ; bomb1 <= '0' ; hit_mouse1 <= '0' ; Subtract_5_seconds1 <= '0' ; 
		end case;
	end process; 
	


--	signal mouse , input_hole : in std_logic_vector(2 downto 0);
--	signal start_hole , hammer , clk , reset_hole_total , stop : in std_logic;
--	signal coin , bomb , hit_mouse , Subtract_5_seconds : out std_logic);

--hole1: entity work.hole_machine(hole_machine)
--	port map ( mouse => mouse , input_hole => input_hole1 , start_hole => start_hole , hammer => hammer1 ,
--	clk => clk , reset_hole_total => reset_hole_total , stop => stop , coin =>coin1 , bomb => bomb1 ,
--	hit_mouse => hit_mouse1 , Subtract_5_seconds => Subtract_5_seconds1 , state => state_hole1);
	
	-- end hoel1 machine##############################################################
	
	
	
	-- counte5 machine ################################################################
	process (new_clk , resetcounter5)
	begin 
		if resetcounter5 = '1' then 
			counter5_state <= s0;
		elsif rising_edge(new_clk) then
			counter5_state <= counter5_next_state;
		end if ;
	end process;
	
	
	process(counter5_state)
	begin
		if stop = '1' then 
			counter5_next_state	<= counter5_state;
		else 
			counter5_next_state <= counter5_state;
			case counter5_state is 
				when s0 => counter5_next_state <= s1; counter5 <= '0';
				when s1 => counter5_next_state <= s2; counter5 <= '0';
				when s2 => counter5_next_state <= s3; counter5 <= '0';
				when s3 => counter5_next_state <= s4; counter5 <= '0';
				when s4 => counter5_next_state <= s5; counter5 <= '0';
				when s5 => counter5_next_state <= s0; counter5 <= '1';
				when others => counter5_next_state <= s0; counter5 <= '0'; 
			end case;
		end if;
	end process;
	-- counter5 machine #########################################################################			
	
	
	-- cc machine ###################################################################################
	process (clk , reset)
	begin 
		if reset = '1' then 
			cc_state <= t0;
		elsif rising_edge(clk) then
			cc_state <= cc_next_state;
		end if ;
	end process; 
	
	process (cc_state , reset_counter5)
	begin 
		if stop = '1' then 
			cc_next_state <= cc_state;
		else
			case cc_state is 
				when t0 => if reset_counter5 ='1' then
					cc_next_state <= t1 ;
				else
					cc_next_state <= cc_state;
				end if ;
				when t1 =>cc_next_state <=t2;
				when t2 => if reset_counter5 = '0' then 
					cc_next_state <= t0;
				else
					cc_next_state <= cc_state;
				end if ;
				when others => cc_next_state <= t0;	
			end case;
		end if;
	end process;
	
	
	resetcounter5 <= '1' when cc_state = t1 else '0';
	-- cc machin end ##################################################################################################	
	
	
	
	-- random control  ##############################################################
	process(random , pseudo_rand , input_hole)
	begin
	if random = '1' then 
		input_hole1 <= (pseudo_rand(0) & pseudo_rand(1));
		input_hole2 <= (pseudo_rand(2) & pseudo_rand(3));
		input_hole3 <= (pseudo_rand(4) & pseudo_rand(5));
		input_hole4 <= (pseudo_rand(6) & pseudo_rand(7));
		input_hole5 <= (pseudo_rand(8) & pseudo_rand(9));
		input_hole6 <= (pseudo_rand(10) & pseudo_rand(11));
		input_hole7 <= (pseudo_rand(12) & pseudo_rand(13));
	else
		input_hole1 <= (input_hole(13) & input_hole(12));
		input_hole2 <= (input_hole(11) & input_hole(10));
		input_hole3 <= (input_hole(9) & input_hole(8));
		input_hole4 <= (input_hole(7) & input_hole(6));
		input_hole5 <= (input_hole(5) & input_hole(4));
		input_hole6 <= (input_hole(3) & input_hole(2));
		input_hole7 <= (input_hole(1) & input_hole(0));
	end if ; 
	end process;
	-- rondom contoro ###########################################################
	
	-- hammer control ###########################################################
	process(hammer)
	begin
	hammer1 <= '0'; hammer2 <= '0';hammer3 <= '0';hammer4 <= '0'; hammer5 <= '0'; hammer6 <= '0';hammer7 <= '0';
		if hammer = "001" then
			hammer1 <= '1';
		elsif hammer = "010" then
			hammer2 <= '1';
		elsif hammer = "011" then
			hammer3 <= '1';
		elsif hammer = "100" then
			hammer4 <= '1';
		elsif hammer = "101" then
			hammer5 <= '1';
		elsif hammer = "110" then
			hammer6 <= '1';
		elsif hammer = "111" then
			hammer7 <= '1';
		end if;
	end process;
	-- hammer control  end###########################################################

	-- time logic	

	process(clk , reset)
	begin 
		if reset = '1' then
			hold_start <= '0';
		elsif rising_edge(clk) then
			if start = '1' then
				hold_start <= start;
			else
				hold_start <= hold_start;
			end if;
		end if;
	end process;
	
	stop_time <= (not hold_start) or stop;
	process(new_clk , reset)
	begin 
		if reset = '1' then 
			time <= 0;
		elsif rising_edge(new_clk) then
			if stop_time = '1' then 
				time <= time;
			else
				time <= time + 1;
			end if;
		end if;
	end process;
	
	process(clk , reset)
	begin 
		if reset = '1' then 
			finish_game <= '0';
		elsif rising_edge(clk) then
			if check_time < 0 then 
				finish_game <= '1';
			else
				finish_game <= finish_game;
			end if ;
		end if ;
	end process;
	
	finish <= finish_game;
	check_time <= total_time - time - (5*sum_of_hit_empty);
	time_left <= check_time;
	
	--end time logic 
	
	
	-- sum of hit mouse and bomb and empty and coin
	hit_mouse <= hit_mouse1 or hit_mouse2 or hit_mouse3 or hit_mouse4 or hit_mouse5 or hit_mouse6 or hit_mouse7;
	Subtract_5_seconds <= Subtract_5_seconds1 or Subtract_5_seconds2 or Subtract_5_seconds3 or Subtract_5_seconds4 or Subtract_5_seconds5 or Subtract_5_seconds6 or Subtract_5_seconds7;
	process(clk , reset)
	begin 
		if reset = '1' then 
			sum_of_hit_mouse <= 0; --(others => '0');
			sum_of_hit_bomb	 <= 0;--(others => '0');
			sum_of_hit_empty <= 0; --(others => '0');
			sum_of_hit_coin <= 0; -- (others => '0');
		elsif rising_edge(clk) then 
			if hit_bomb = '1'then
				sum_of_hit_bomb <= sum_of_hit_bomb + 1 ;
			elsif hit_coin = '1' then 
				sum_of_hit_coin <= sum_of_hit_coin +1;
			elsif Subtract_5_seconds = '1' then
				sum_of_hit_empty <= sum_of_hit_empty + 1;
			elsif hit_mouse = '1' then 
				sum_of_hit_mouse <= sum_of_hit_mouse +1;
			end if ;
		end if ;
	end process;
	
	
	-- counte6 machine ################################################################ 
	process (new_clk , reset)
	begin 
		if reset= '1' then 
			counter6_state <= a0;
		elsif rising_edge(new_clk) then
			counter6_state <= counter6_next_state;
		end if ;
	end process;
	
	
	process(counter6_state , finish_game)
	begin
		if stop = '1' then 
			counter6_next_state	<= counter6_state;
		else 
			counter6_next_state <= counter6_state;
			case counter6_state is 
				when a0 => if finish_game = '1' then
					counter6_next_state <= a1; 
				else 
					counter6_next_state <= counter6_state; 
				end if;
				when a1 => counter6_next_state <= a2; 
				when a2 => counter6_next_state <= a3; 
				when a3 => counter6_next_state <= a4; 
				when a4 => counter6_next_state <= a5; 
				when a5 => counter6_next_state <= a6; 
				when a6 => counter6_next_state <= a7; 
				when a7 => counter6_next_state <= counter6_state;
				when others => counter6_next_state <= a0; 
			end case;
		end if;
	end process;
	
	process(counter6_state)
	begin
		counter6 <= '1';
		if	((counter6_state = a0) or (counter6_state = a7)) then 
			counter6 <= '0';
		end if; 
	end process;
	
	-- counter6 machine end ##########3	
	
	process(counter6)
	begin
		if counter6 = '1' then
			score <= 100 * ( 2 * sum_of_hit_mouse - sum_of_hit_empty ) / (sum_of_hit_mouse + sum_of_hit_empty + sum_of_hit_coin + sum_of_hit_bomb);
		else
			score <= 0;
		end if;
	end process;
		
		
    --show bomb , coin machine 
    reset_show <= reset; 	
	process (clk , reset_show)
	begin 
		if reset_show= '1' then 
			show_state <= r0;
		elsif rising_edge(clk) then
			show_state <= show_next_state;
		end if ;
	end process; 
	
	process(show_state , hit_bomb ,hit_coin , one_secend)
	begin
		if stop = '1' then
			show_next_state <= show_state;
		else
			case show_state is 
				when r0 => if hit_bomb = '1' then
					show_next_state <= r1;
				elsif hit_coin = '1' then 
					show_next_state <= r2;
				end if;
				when r1 => if hit_bomb = '1' then
					show_next_state <= show_state;
				elsif hit_coin = '1' then
					show_next_state <= r2;
				elsif one_secend = '1' then
					show_next_state <= r0;
				end if;
				when r2 => if hit_coin = '1' then
					show_next_state <= show_state;
				elsif hit_bomb = '1' then
					show_next_state <= r2;
				elsif one_secend = '1' then
					show_next_state <= r0;
				end if;
				when others => show_next_state <= r0;
			end case;
		end if;
	end process;
		
	process(show_state)
	begin
		show_bomb <= '0' ; show_coin <= '0';
		if show_state = r1 then
			show_bomb <= '1';
		elsif show_state = r2 then
			show_coin <= '1';
		end if;
	end process;
	
	reset_one_secend <= reset or hit_bomb or hit_coin ;
	process(clk , reset_one_secend)
	begin 
		if reset_one_secend = '1' then
			one_secend <= '0';
			counter_one_secend <= 0;
		elsif rising_edge(clk) then
			if counter_one_secend < 99 then
				one_secend <= '0';
				counter_one_secend <= counter_one_secend + 1;
			else
				one_secend <= '1';
				counter_one_secend <= 0;
			end if ;
		end if ;					  	
	end process;

	bomb <= show_bomb;
	coin <= show_coin;
    -- end show coin , bomb 
	
number_mouse <= sum_of_hit_mouse;
end project_cad;
