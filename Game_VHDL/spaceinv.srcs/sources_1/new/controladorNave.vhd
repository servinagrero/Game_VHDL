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
  port(
    Clk                : in  std_logic;
    Reset              : in  std_logic;
    Derecha, Izquierda : in  std_logic;
    x_nave             : out integer range 0 to 19;
    y_nave             : out integer range 0 to 14);
end controladorNave;

architecture Behavioral of controladorNave is
-- Signals
  signal s_x_nave : integer range 0 to 19;
begin
  
  process(clk, reset)
  begin
    
    if reset = '1' then
      s_x_nave <= 8;
      
    elsif rising_edge(clk) then
      -- Evitamos que la nave se mueva de los limites de la pantalla
      if Derecha = '1' then
        if s_x_nave < 19 then
          s_x_nave <= s_x_nave + 1;
        end if;
        
      elsif Izquierda = '1' then
        if s_x_nave > 0 then
          s_x_nave <= s_x_nave - 1;
        end if;
      end if;
      
    end if;
  end process;
  
  x_nave <= s_x_nave;
  
  -- La nave siempre permanece en la ultima fila
  y_nave <= 14;
  
end Behavioral;
