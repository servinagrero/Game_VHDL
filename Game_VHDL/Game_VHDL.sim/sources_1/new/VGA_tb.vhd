----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2019 11:46:05
-- Design Name: 
-- Module Name: VGA - Behavioral
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
--arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_tb is
end VGA_tb;

architecture Test of VGA_tb is
  component VGA is
    port (clk   : in  std_logic;
          reset : in  std_logic;
          color : in  std_logic_vector (2 downto 0);
          Hsync : out std_logic;
          Vsync : out std_logic;
          R     : out std_logic_vector (3 downto 0);
          G     : out std_logic_vector (3 downto 0);
          B     : out std_logic_vector (3 downto 0);
          x     : out std_logic_vector (9 downto 0);
          y     : out std_logic_vector (9 downto 0));
  end component;

  signal reset        : std_logic := '1';
  signal clk          : std_logic := '0';
  signal color        : std_logic_vector(2 downto 0);
  signal Hsync, Vsync : std_logic;
  signal R, G, B      : std_logic_vector(3 downto 0);
  signal x, y         : std_logic_vector(9 downto 0);

begin
  VGAm : VGA port map (clk,
                       reset,
                       color,
                       Hsync,
                       Vsync,
                       R, G, B,
                       x, y);

  clk <= not clk after 31.25 ns;
  reset <= '0' after 1 ns;
  -- For this test we only allow the colors "000" and "111"
  -- Later we would need to teste for multiple values
  process
  begin
    color <= "000";
    wait for 90 ns;
    color <= "111";
    wait for 90 ns;
    color <= "010";
    wait for 90 ns;
    wait;
  end process;


end Test;
