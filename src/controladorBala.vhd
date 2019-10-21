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

entity controladorBala is
  port (
    Clk            : in  std_logic;
    Reset          : in  std_logic;
    Disparo        : in  std_logic;
    Enable         : in  std_logic;
    x_nave, y_nave : in  std_logic_vector (9 downto 0);
    -- TODO: Implementar mas de una bala mediante un array
    -- Se puede usar un array de vectores donde la x es fija y la y se modifica
    -- en el vector superior
    x              : out std_logic_vector (5 downto 0);
    y              : out std_logic_vector (4 downto 0)
    );
end controladorBala;

architecture Behavioral of controladorBala is
  signal x_bala : integer range 0 to 19;
  signal y_bala : integer range 0 to 14;
begin
  process(clk, reset)
  begin
    if reset = '1' then
      x_bala <= 0;
      y_bala <= 0;
    elsif rising_edge(clk) then
      if Disparo = '1' then
      end if;
    end if;
  end process;

  x <= std_logic_vector(to_unsigned(x_bala, x'length));
  y <= std_logic_vector(to_unsigned(y_bala, y'length));

end Behavioral;
