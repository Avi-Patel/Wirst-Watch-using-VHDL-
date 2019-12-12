
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_bit.all;

entity seven is
    Port ( main_clk : in bit;-- 100Mhz clock on Basys 3 FPGA board
           reset : in bit; -- reset
			  displayed_number: in unsigned (31 downto 0);
           Anode_Activate : out STD_LOGIC_VECTOR (7 downto 0);-- 4 Anode signals
           LED_out : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display
end seven;

architecture Behavioral of seven is
	signal one_second_counter: STD_LOGIC_VECTOR (27 downto 0);
	-- counter for generating 1-second clock enable
	signal one_second_enable: std_logic;
	-- one second enable for counting numbers
	-- counting decimal number to be displayed on 4-digit 7-segment display
	signal LED_BCD: unsigned (3 downto 0);
	signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
	-- creating 10.5ms refresh period
	signal LED_activating_counter: std_logic_vector(2 downto 0);
	-- the other 2-bit for creating 4 LED-activating signals
	-- count         0    ->  1  ->  2  ->  3  ->  4  ->  5  ->  6  ->  7 
	-- activates    LED1    LED2   LED3   LED4    LED5   LED6   LED7   LED8
	-- and repeat
begin
-- VHDL code for BCD to 7-segment decoder
-- Cathode patterns of the 7-segment LED display
process(LED_BCD)
begin
    case LED_BCD is
    when "0000" => LED_out <= "0000001"; -- "0"    
    when "0001" => LED_out <= "1001111"; -- "1"
    when "0010" => LED_out <= "0010010"; -- "2"
    when "0011" => LED_out <= "0000110"; -- "3"
    when "0100" => LED_out <= "1001100"; -- "4"
    when "0101" => LED_out <= "0100100"; -- "5"
    when "0110" => LED_out <= "0100000"; -- "6"
    when "0111" => LED_out <= "0001111"; -- "7"
    when "1000" => LED_out <= "0000000"; -- "8"    
    when "1001" => LED_out <= "0000100"; -- "9"
    when "1010" => LED_out <= "0000010"; -- a
    when "1011" => LED_out <= "1100000"; -- b
    when "1100" => LED_out <= "0110001"; -- C
    when "1101" => LED_out <= "0001000"; -- A
    when "1110" => LED_out <= "0011000"; -- P
    when "1111" => LED_out <= "1111111"; -- F
    end case;
end process;
-- 7-segment display controller
-- generate refresh period of 10.5ms
process(main_clk,reset)
begin
    if(reset='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(main_clk)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;
 LED_activating_counter <= refresh_counter(19 downto 17);
-- 8-to-1 MUX to generate anode activating signals for 8 LEDs
process(LED_activating_counter)
begin
    case LED_activating_counter is
    when "000" =>
        Anode_Activate <= "01111111";
        -- activate LED1 and Deactivate LED(2 to 8)
        LED_BCD <= displayed_number(31 downto 28);
        -- the first hex digit of the 16-bit number
    when "001" =>
        Anode_Activate <= "10111111";
        -- activate LED2 and Deactivate LED(1,3,4,5,6,,6,7,8)
        LED_BCD <= displayed_number(27 downto 24);
        -- the second hex digit of the 16-bit number
    when "010" =>
        Anode_Activate <= "11011111";
        -- activate LED3 and Deactivate LED(1,2,4,5,6,7,8)
        LED_BCD <= displayed_number(23 downto 20);
        -- the third hex digit of the 16-bit number
    when "011" =>
        Anode_Activate <= "11101111";
        LED_BCD <= displayed_number(19 downto 16);
	 when "100" =>
        Anode_Activate <= "11110111";
        LED_BCD <= displayed_number(15 downto 12);
    when "101" =>
        Anode_Activate <= "11111011";
        LED_BCD <= displayed_number(11 downto 8);
    when "110" =>
        Anode_Activate <= "11111101";
        LED_BCD <= displayed_number(7 downto 4);
    when "111" =>
        Anode_Activate <= "11111110";
        LED_BCD <= displayed_number(3 downto 0);
	 when others =>
		  LED_BCD <= "1111";
    end case;
end process;
-- Counting the number to be displayed on 4-digit 7-segment Display
-- on Basys 3 FPGA board
process(main_clk, reset)
begin
        if(reset='1') then
            one_second_counter <= (others => '0');
        elsif(rising_edge(main_clk)) then
            if(one_second_counter>=x"5F5E0FF") then
                one_second_counter <= (others => '0');
            else
                one_second_counter <= one_second_counter + "0000001";
            end if;
        end if;
end process;
one_second_enable <= '1' when one_second_counter=x"5F5E0FF" else '0';

end Behavioral;