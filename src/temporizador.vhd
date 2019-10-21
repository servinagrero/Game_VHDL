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

entity temporizador is
  generic (
    Ancho : integer := 8
    );
  port (
    Clk    : in  std_logic;
    Reset  : in  std_logic;
    Clear  : in  std_logic;
    Enable : in  std_logic;
    Cuenta : out unsigned(Ancho - 1 downto 0)
    );
end temporizador;

architecture Behavioral of temporizador is
  process(clk, reset)
  begin
    if reset = '1' then
    if rising_edge(clk) then
    end if;
  end process;

end Behavioral;
