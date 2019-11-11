----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 11:38:40
-- Design Name: 
-- Module Name: controladorNave - Behavioral
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
    Clk   : in std_logic;
    Reset : in std_logic;

    -- Botones para controlar la direccion de la nave
    Derecha, Izquierda : in std_logic;

    -- Coordenadas de la x e y.
    -- La x esta codificada de 0 a 19
    -- La y es siempre contante e igual a 14
    x, y : out std_logic_vector (4 downto 0)
    );
end controladorNave;

architecture Behavioral of controladorNave is
  constant y_nave : integer := 0;
  signal x_nave   : integer range 0 to 19;
begin

  -- TODO: Detector de flancos para derecha e izquierda
  process(clk, reset)
  begin
    if reset = '1' then
      x_nave <= 1;
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
