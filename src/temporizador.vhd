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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity temporizador is
  generic(
    Ancho : integer := 6
    );
  port (
    Clk    : in  std_logic;
    Reset  : in  std_logic;
    Clear  : in  std_logic;
    Enable : in  std_logic;
    Cuenta : out unsigned(Ancho-1 downto 0);
    pulse  : out std_logic
    );
end temporizador;

architecture Behavioral of temporizador is
  signal count    : unsigned(Ancho-1 downto 0);
  signal maxCount : unsigned(Ancho-1 downto 0) := (others => '1');
begin
  Cuenta <= count;
  pulse  <= '1' when count = maxCount else '0';

  process (Clk, Reset)
  begin
    if Reset = '1' then
      count <= (others => '0');
    elsif rising_edge(Clk) then
      if Enable = '1' then
        if count = maxCount then
          count <= (others => '0');
        else
          count <= count + 1;
        end if;
      elsif Clear = '1' then
        count <= (others => '0');
      end if;
    end if;
  end process;

end Behavioral;
