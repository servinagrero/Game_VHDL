----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 11:39:35
-- Design Name: 
-- Module Name: controladorBala - Behavioral
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
    Disparo        : in  std_logic;     -- Signal de disparo
    Enable         : in  std_logic;
    -- Posicion de la nave
    x_nave, y_nave : in  std_logic_vector (4 downto 0);
    -- Posicion de todas las balas
    x              : out std_logic_vector (0 to 19);
    y              : out std_logic_vector (0 to 14)
    );
end controladorBala;

architecture Behavioral of controladorBala is
  signal x_bala : unsigned(0 to 20);
  signal y_bala : unsigned(0 to 21);

  signal x_nave_pos : integer range 0 to 19;
  signal y_nave_pos : integer range 0 to 14 := 14;
begin

  x_nave_pos <= to_integer(unsigned(x_nave));
  y_nave_pos <= to_integer(unsigned(y_nave));
  
  process(clk, reset)
  begin
    if reset = '1' then
      x_bala <= (others => '0');
      y_bala <= (others => '0');
    elsif rising_edge(clk) then
      -- TODO: Mover el vector y_bala para mover todas las balas
      if y_bala(20) = '1' then
        y_bala(20) <= '0';
      end if;
      -- Si disparamos creamos una bala nueva
      -- Ademas tenemos que mover todas las balas hacia arriba
      if Disparo = '1' then
        x_bala(x_nave_pos)     <= '1';
        y_bala(y_nave_pos + 1) <= '1';
      else

      end if;
    end if;
  end process;

  x <= std_logic_vector(x_bala);
  y <= std_logic_vector(y_bala);

end Behavioral;
