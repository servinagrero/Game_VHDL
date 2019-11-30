----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 11:39:35
-- Design Name: 
-- Module Name: controladorBala - Behavioral
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

entity controladorBala is
  port(
    Clk     : in  std_logic;
    Reset   : in  std_logic;
    Disparo : in  std_logic;
    x_inv   : in  std_logic_vector(0 to 19);
    y_inv   : in  integer range 0 to 14;
    x_bala  : out integer range 0 to 20;
    y_bala  : out integer range 0 to 15;
    x_nave  : in  integer range 0 to 19);
end controladorBala;

architecture Behavioral of controladorBala is
--componentes
  component temporizador is
    generic(t : integer := 1);  --el pulso se producira cada t milisegundos
    port(clk, reset, enable, clear : in  std_logic;
         q                         : out std_logic);
  end component;
  
--señales
  signal s_enable, s_clear : std_logic;
  signal s_q               : std_logic;
  signal s_x_bala          : integer range 0 to 20;
  signal s_y_bala          : integer range 0 to 15;
  signal flag_bala         : std_logic;
begin
  
  temp_bala : temporizador
    generic map (50)
    port map(clk => clk, reset => reset, enable => s_enable, clear => s_clear, q => s_q);
  process(clk, reset)
  begin
    if reset = '1' then
      
      s_enable  <= '1';
      s_clear   <= '0';
      s_x_bala  <= 20;
      s_y_bala  <= 15;
      flag_bala <= '0';
      
    elsif rising_edge(clk) then

      -- Actualizamos y habilitamos el movimiento de la bala
      if s_q = '1' and flag_bala = '1' then
        s_y_bala <= s_y_bala - 1;
      else
        s_clear  <= '0';
        s_enable <= '1';
      end if;

      -- Creamos una nueva bala o borramos la que ya hay
      -- Para borrar una bala la movemos fuera de la pantalla
      if Disparo = '1' and flag_bala = '0' then
        s_x_bala  <= x_nave;
        s_y_bala  <= 13;
        flag_bala <= '1';
      elsif (x_inv(s_x_bala) = '1' and s_y_bala = y_inv) or s_y_bala = 0 then
        s_x_bala  <= 20;
        s_y_bala  <= 15;
        flag_bala <= '0';
      end if;
      
    end if;
  end process;

  x_bala <= s_x_bala;
  y_bala <= s_y_bala;

end Behavioral;
