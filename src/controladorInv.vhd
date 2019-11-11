----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 11:39:07
-- Design Name: 
-- Module Name: controladorInv - Behavioral
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

entity controladorInv is
  port(
    clk   : in  std_logic;
    reset : in  std_logic;
    -- Posiciones de los invasores
    x_inv : out std_logic_vector (0 to 19);
    y_inv : out std_logic_vector (4 downto 0)
    );
end controladorInv;

architecture Behavioral of controladorInv is
  signal s_y_inv : integer range 0 to 14;
  signal s_x_inv : unsigned (0 to 19);

begin

  process(clk, reset)
  begin
    if reset = '1' then
      s_y_inv <= 0;
      s_x_inv <= "10101010101010101010";

    elsif rising_edge(clk) then
      -- TODO: implementar si coincide bala con marciano

      if (s_y_inv mod 2) = 0 then
        if s_x_inv(19) = '0' then
          s_x_inv <= '0' & s_x_inv(0 to 18);
        else
          if s_y_inv < 14 then
            s_y_inv <= s_y_inv + 1;
          end if;
        end if;
      else

        if s_x_inv(0) = '0' then
          s_x_inv <= s_x_inv(1 to 19) & '0';
        else
          if s_y_inv < 14 then
            s_y_inv <= s_y_inv + 1;
          end if;
        end if;
      end if;
    end if;
  end process;

  x_inv <= std_logic_vector(s_x_inv);
  y_inv <= std_logic_vector(to_unsigned(s_y_inv, y_inv'length));

end Behavioral;
