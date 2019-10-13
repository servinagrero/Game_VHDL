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

entity formatoVGA is
  port (color : out std_logic_vector (3 downto 0);
        x     : in  std_logic_vector (9 downto 0);
        y     : in  std_logic_vector (9 downto 0));
end formatoVGA;

architecture Behavioral of formatoVGA is
  signal x_uns, y_uns : unsigned (9 downto 0);

  signal x_pos : integer range 0 to 25;
  signal y_pos : integer range 0 to 20;

begin

  x_uns <= unsigned(x);
  x_pos <= to_integer(x_uns(9 downto 5));

  y_uns <= unsigned(y);
  y_pos <= to_integer(y_uns(9 downto 5));

  color <= (others => (x_uns(0) xnor y_uns(0)));

end Behavioral;
