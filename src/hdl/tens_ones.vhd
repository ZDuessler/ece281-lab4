--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2017 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : TDM4.vhd
--| AUTHOR(S)     : Capt Phillip Warner
--| CREATED       : 03/2017
--| DESCRIPTION   : This file implements a 4 to 1 Time Division MUX (TDM).
--|					Input and output data has a variable width set by k_WIDTH.
--|					An internal MUX select line is connected to a 2 bit counter 
--|					so that all inputs are selected 1/4 of the clocked time.
--|					D0 is selected upon the asynchronous reset.
--|					The selected data line number is also output with a 4-bit 
--|					one-cold encoding.
--|  
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : None
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tens_ones is
    Port ( i_dec		: in  STD_LOGIC_VECTOR (3 downto 0);
		   o_tens		: out STD_LOGIC_VECTOR (3 downto 0);
		   o_ones		: out STD_LOGIC_VECTOR (3 downto 0)
	);
end tens_ones;

architecture behavioral of tens_ones is
	
begin	
	
	-- PROCESSES ----------------------------------------
    o_tens <= "0001" when i_dec > "1001" or i_dec = "0000" else 
              "0000";
    o_ones <= "0000" when i_dec = "1010" else 
              "0001" when i_dec = "1011" else
              "0010" when i_dec = "1100" else 
              "0011" when i_dec = "1101" else 
              "0100" when i_dec = "1110" else 
              "0101" when i_dec = "1111" else 
              "0110" when i_dec = "0000" else 
              i_dec;
		
end behavioral;

