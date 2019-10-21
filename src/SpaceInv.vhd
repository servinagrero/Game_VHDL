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

entity SpaceInv is
  port (clk       : in  std_logic;
        reset     : in  std_logic;
        Inicio    : in  std_logic;
        Izquierda : in  std_logic;
        Derecha   : in  std_logic;
        Hsync     : out std_logic;
        Vsync     : out std_logic;
        R         : out std_logic_vector (3 downto 0);
        G         : out std_logic_vector (3 downto 0);
        B         : out std_logic_vector (3 downto 0));
end SpaceInv;


architecture Behavioral of SpaceInv is

  component formatoVGA
    port (color : out std_logic_vector (2 downto 0);
          x     : in  std_logic_vector (9 downto 0);
          y     : in  std_logic_vector (9 downto 0));
  end component;

  signal color_s : std_logic_vector(2 downto 0);
  signal color_vga : std_logic_vector(2 downto 0);
  signal x_s, y_s : std_logic_vector(9 downto 0);

  component VGA
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

begin

  vga_m : VGA port map (clk,
                        reset,
                        color_vga,
                        Hsync,
                        Vsync,
                        R, G, B,
                        x_s, y_s
                        );

  fvga : formatoVGA port map (color_s,
                              x_s,
                              y_s);

  color_vga <= color_s;

end Behavioral;
