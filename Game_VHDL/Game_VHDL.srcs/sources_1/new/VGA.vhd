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

entity VGA is
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
end VGA;

architecture Behavioral of VGA is

  signal pixel_counter_enable, line_counter_enable : std_logic;

  signal division_counter : integer range 0 to 3;
  signal pixel_counter    : integer range 0 to 799;
  signal line_counter     : integer range 0 to 520;

begin

-- Divisor de ciclos de reloj
  pixel_counter_enable <= '1' when division_counter = 3 else '0';

  process(clk, reset)
  begin
    if reset = '1' then
      division_counter <= 0;
    elsif rising_edge(clk) then
      if division_counter = 3 then
        division_counter <= 0;
      else
        division_counter <= division_counter +1;
      end if;
    end if;
  end process;


-- Contador de pixeles
  line_counter_enable <= '1' when pixel_counter = 799 and pixel_counter_enable = '1' else '0';

  process(clk, reset)
  begin
    if reset = '1' then
      pixel_counter <= 0;
    elsif rising_edge(clk) then
      if pixel_counter_enable = '1' then
        if pixel_counter = 799 then
          pixel_counter <= 0;
        else
          pixel_counter <= pixel_counter +1;
        end if;
      end if;
    end if;
  end process;


-- Contador de lineas
  process(clk, reset)
  begin
    if reset = '1' then
      line_counter <= 0;
    elsif rising_edge(clk) then
      if line_counter_enable = '1' then
        if line_counter = 520 then
          line_counter <= 0;
        else
          line_counter <= line_counter + 1;
        end if;
      end if;
    end if;
  end process;
--

  y <= std_logic_vector(to_unsigned(line_counter, 10));
  x <= std_logic_vector(to_unsigned(pixel_counter, 10));

  Hsync <= '0' when (pixel_counter >= 654 and pixel_counter <= 752) else '1';
  Vsync <= '0' when (line_counter >= 490 and line_counter <= 492)   else '1';

-- Colores de salida
  R <= (others => color(2));
  G <= (others => color(1));
  B <= (others => color(0));
  
end Behavioral;
