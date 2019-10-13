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

entity SpaceInv_tb is
end SpaceInv_tb;


architecture Test of SpaceInv_tb is

  component SpaceInv is
    port (clk   : in  std_logic;
          reset : in  std_logic;
          Hsync : out std_logic;
          Vsync : out std_logic;
          R     : out std_logic_vector (3 downto 0);
          G     : out std_logic_vector (3 downto 0);
          B     : out std_logic_vector (3 downto 0));
  end component;

  signal reset        : std_logic := '1';
  signal clk          : std_logic := '0';
  signal Hsync, Vsync : std_logic;
  signal R, G, B      : std_logic_vector(3 downto 0);

  signal counter : integer range 0 to 500 := 0;
begin

  SpaceInvm : SpaceInv port map (clk,
                                 reset,
                                 Hsync,
                                 Vsync,
                                 R, G, B);

  clk   <= not clk after 31.15 ns;
  reset <= '0'     after 5 ns;

  process
  begin
    if counter < 500 then
      counter <= counter + 1;
      wait for 5 ns;
    else
      wait;
    end if;
  end process;

end Test;
