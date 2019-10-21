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
  port (color : out std_logic_vector (2 downto 0);
        x     : in  std_logic_vector (9 downto 0);
        y     : in  std_logic_vector (9 downto 0);

        x_nave : in std_logic_vector (5 downto 0);
        y_nave : in std_logic_vector (4 downto 0);

        x_bala : in std_logic_vector (5 downto 0);
        y_bala : in std_logic_vector (4 downto 0);

        y_mars : in std_logic_vector (4 downto 0);
        x_mars : in std_logic_vector (0 to 19)
        );
end formatoVGA;

architecture Behavioral of formatoVGA is
  signal x_uns, y_uns : unsigned (9 downto 0);

  signal x_pos : integer range 0 to 25;
  signal y_pos : integer range 0 to 16;

begin

  x_uns <= unsigned(x);
  x_pos <= to_integer(x_uns(9 downto 5));
  y_uns <= unsigned(y);
  y_pos <= to_integer(y_uns(9 downto 5));


  -- Dibujar tablero de ajedrez
  -- color <= (others => (x_uns(5) xnor y_uns(5))) when x_pos <= 19 and y_pos <= 14
  -- else (others => '0');


  process(x_nave, y_nave, x_bala, y_bala, x_mars, y_mars)
    variable x_nave_pos : integer range 0 to 19 := to_integer(unsigned(x_nave, x_nave'length));
    variable y_nave_pos : integer range 0 to 14 := to_integer(unsigned(y_nave, y_nave'length));
    variable x_bala_pos : integer range 0 to 19 := to_integer(unsigned(x_bala, x_bala'length));
    variable y_bala_pos : integer range 0 to 14 := to_integer(unsigned(y_bala, y_bala'length));
    variable y_mars_pos : integer range 0 to 14 := to_integer(unsigned(y_mars, y_mars'length));
  begin
    
    if x_pos = x_nave_pos and y_pos = y_nave_pos then
      color <= "001";
      
    elsif x_pos = x_bala_pos and y_pos = y_bala_pos then
      color <= "010";
      
    elsif y_pos = y_mars_pos then
      for i in x_mars'range loop
        if x_mars(i) = '1' and x_pos = i then
          color <= (others => '1');
        else
          color <= (others => '0');
        end if;
      end loop;
      
    else
      color <= (others => '0');
    end if;
  end process;

end Behavioral;
