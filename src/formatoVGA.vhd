----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 11:36:57
-- Design Name: 
-- Module Name: formatoVGA - Behavioral
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

entity formatoVGA is
  port (color : out std_logic_vector (2 downto 0);
        -- Posiciones del rastreo de la pantalla
        x     : in  std_logic_vector (9 downto 0);
        y     : in  std_logic_vector (9 downto 0);

        -- Posiciones de la nave
        -- La coordenada 'y' siempre va a ser 14;
        x_nave : in std_logic_vector (4 downto 0);
        y_nave : in std_logic_vector (4 downto 0);

        -- Posiciones de la bala
        x_bala : in std_logic_vector (4 downto 0);
        y_bala : in std_logic_vector (4 downto 0);

        -- Posiciones de los invasores
        x_inv : in std_logic_vector (0 to 19);
        y_inv : in std_logic_vector (4 downto 0)
        );
end formatoVGA;

architecture Behavioral of formatoVGA is
  -- Colores predefinidos
  constant BLANCO : std_logic_vector(2 downto 0) := "111";
  constant NEGRO  : std_logic_vector(2 downto 0) := "000";
  constant ROJO   : std_logic_vector(2 downto 0) := "100";
  constant VERDE  : std_logic_vector(2 downto 0) := "010";
  constant AZUL   : std_logic_vector(2 downto 0) := "001";
  --

  signal x_uns, y_uns : unsigned (9 downto 0);

  signal x_pos : integer range 0 to 25;
  signal y_pos : integer range 0 to 16;

begin

  x_uns <= unsigned(x);
  x_pos <= to_integer(x_uns(9 downto 5));
  y_uns <= unsigned(y);
  y_pos <= to_integer(y_uns(9 downto 5));


  -- Dibujar tablero de ajedrez
  -- color <= (others => (x_uns(5) xnor y_uns(5))) when x_pos <= 19 and y_pos <= 14
  -- else (others => '0');


  -- TODO: Eliminar el proceso y hacerlo concurrente ?
  process(x_pos, y_pos, x_nave, y_nave, x_bala, y_bala, x_inv, y_inv)
    variable x_nave_pos : integer range 0 to 19 := to_integer(unsigned(x_nave));
    variable y_nave_pos : integer range 0 to 14 := to_integer(unsigned(y_nave));
    variable x_bala_pos : integer range 0 to 19 := to_integer(unsigned(x_bala));
    variable y_bala_pos : integer range 0 to 14 := to_integer(unsigned(y_bala));
    variable y_inv_pos  : integer range 0 to 14 := to_integer(unsigned(y_inv));
  begin

    -- Dibujo de la nave
    if x_pos = x_nave_pos and y_pos = y_nave_pos then
      color <= VERDE;

    -- Dibujo de la bala
    elsif x_pos = x_bala_pos and y_pos = y_bala_pos then
      color <= AZUL;

    -- Dibujo de los invasores
    elsif y_pos = y_inv_pos then
      for i in x_inv'range loop
        if x_inv(i) = '1' and x_pos = i then
          color <= BLANCO;
        else
          color <= NEGRO;
        end if;
      end loop;

    -- Dibujo del fondo
    else
      color <= NEGRO;
    end if;

  end process;

end Behavioral;
