----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 11:46:05
-- Design Name: 
-- Module Name: SpaceInv - Behavioral
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

entity controladorNave is
  port (
    Clk                : in  std_logic;
    Reset              : in  std_logic;
    Derecha, Izquierda : in  std_logic;
    x                  : out std_logic_vector (5 downto 0);
    y                  : out std_logic_vector (5 downto 0)
    );
end controladorNave;

architecture Behavioral of controladorNave is
  constant y_nave : integer := 14;
  signal   x_nave : integer range 0 to 19;
begin

  process(clk, reset)
  begin
    if reset = '1' then
      x_nave <= 8;
    elsif rising_edge(clk) then
      if Derecha = '1' then
        if x_nave < 19 then
          x_nave <= x_nave + 1;
        end if;
      elsif Izquierda = '1' then
        if x_nave > 0 then
          x_nave <= x_nave - 1;
        end if;
      end if;
    end if;
  end process;

  x <= std_logic_vector(to_unsigned(x_nave, x'length));
  y <= std_logic_vector(to_unsigned(y_nave, y'length));

end Behavioral;
