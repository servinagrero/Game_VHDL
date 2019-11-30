----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 11:38:10
-- Design Name: 
-- Module Name: temporizador - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temporizador is
  generic(t : integer := 1);  -- El pulso se producira cada t milisegundos
  port(clk, reset, enable, clear : in  std_logic;
       q                         : out std_logic);
end temporizador;

architecture Behavioral of temporizador is
  constant frecuencia : integer := 100_000;
  constant max        : integer := (t*frecuencia)-1;
  signal cuenta       : integer range 0 to max;
begin

  process(clk, reset)
  begin
    
    if reset = '1' then
      cuenta <= 0;
      
    elsif rising_edge(clk) then
      
      if clear = '1' then
        cuenta <= 0;
      elsif enable = '1' then
        if cuenta = max then
          cuenta <= 0;
        else
          cuenta <= cuenta + 1;
        end if;
      end if;
      
    end if;
  end process;

  q <= '1' when cuenta = max else '0';

end Behavioral;


