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
  port (clk   : in  std_logic;
        reset : in  std_logic;
        Hsync : out std_logic;
        Vsync : out std_logic;
        R     : out std_logic_vector (3 downto 0);
        G     : out std_logic_vector (3 downto 0);
        B     : out std_logic_vector (3 downto 0));
end SpaceInv;


architecture Behavioral of SpaceInv is

  component formatoVGA
    port (color : out std_logic_vector (3 downto 0);
          x     : in  std_logic_vector (9 downto 0);
          y     : in  std_logic_vector (9 downto 0));
  end component;

  signal color_s  : std_logic_vector(3 downto 0);
  signal x_s, y_s : std_logic_vector(9 downto 0);

  component VGA
    port (clk   : in  std_logic;
          reset : in  std_logic;
          color : in  std_logic_vector (2 downto 0);
          Hsync : out std_logic;
          Vsync : out std_logic;
          R     : in  std_logic_vector (3 downto 0);
          G     : in  std_logic_vector (3 downto 0);
          B     : in  std_logic_vector (3 downto 0);
          x     : out std_logic_vector (9 downto 0);
          y     : out std_logic_vector (9 downto 0));
  end component;

  signal color_vga        : std_logic_vector(2 downto 0);
  signal Hsync_s, Vsync_s : std_logic;
  signal R_s, G_s, B_s    : std_logic_vector(3 downto 0);

begin

  fvga : formatoVGA port map (color => color_s,
                              x     => x_s,
                              y     => y_s);

  vga : VGA port map (clk   => clk,
                      reset => reset,
                      color => color_vga,
                      Hsync => Hsync_s,
                      Vsync => Vsync_s,
                      R     => R_s,
                      G     => G_s,
                      B     => B_s,
                      x     => x_s,
                      y     => y_s);

  process(clk, reset)
  begin
    if reset = 1 then
      color   <= "000";
      Hsync_s <= '1';
      Vsync_s <= '0';
    end if;
  end process;

  Hsync <= Hsync_s;
  Vsync <= Vsync_s;

  R <= R_s;
  G <= G_s;
  B <= B_s;

end Behavioral;
