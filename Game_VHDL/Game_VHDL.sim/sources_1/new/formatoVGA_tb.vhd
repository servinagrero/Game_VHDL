----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 11:46:05
-- Design Name: 
-- Module Name: formatoVGA - Behavioral
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

entity formatoVGA_tb is
end formatoVGA_tb;

architecture Test of formatoVGA_tb is
  component formatoVGA is
    port (color : out std_logic_vector (3 downto 0);
          x     : in  std_logic_vector (9 downto 0);
          y     : in  std_logic_vector (9 downto 0));
  end component;

  signal color_out : std_logic_vector (3 downto 0);
  signal x_pos     : std_logic_vector (9 downto 0) := (others => '0');
  signal y_pos     : std_logic_vector (9 downto 0) := (others => '0');

  signal x : integer range 0 to 20 := 0;
  signal y : integer range 0 to 15 := 0;

begin

  fVGA : formatoVGA port map (color_out,
                              x_pos,
                              y_pos
                              );

  y_pos <= std_logic_vector(to_unsigned(y, y_pos'length));
  x_pos <= std_logic_vector(to_unsigned(x, x_pos'length));

  process
  begin
    if x = 19 then
      x <= 0;
      y <= y + 1;
      wait for 2 ns;
    else
      x <= x + 1;
      wait for 2 ns;
    end if;

    if y = 14 then
      wait;
    end if;

  end process;

end Test;
