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
use work.state.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity formatoVGA is
  port (color   : out std_logic_vector (2 downto 0);
        x       : in  unsigned (9 downto 0);
        y       : in  unsigned (9 downto 0);
        estado1 : in  estado;

        x_nave : in integer range 0 to 19;
        y_nave : in integer range 0 to 14;

        x_bala : in integer range 0 to 20;
        y_bala : in integer range 0 to 15;

        x_inv : in std_logic_vector (0 to 19);  --la informacion de los invasores va a ir codificada en el vector
        y_inv : in integer range 0 to 14
        );
end formatoVGA;

architecture Behavioral of formatoVGA is

  signal x_pos : integer range 0 to 24;
  signal y_pos : integer range 0 to 16;

  signal x_pos1 : integer range 0 to 49;
  signal y_pos1 : integer range 0 to 32;

  signal s_x_bala : integer range 0 to 20;
  signal s_y_bala : integer range 0 to 15;

  type matriz is array (0 to 31) of std_logic_vector(0 to 31);
  type matriz1 is array (0 to 29) of std_logic_vector(0 to 39);

  constant matriz_inicio : matriz1 :=
    ((others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     "0000000000111011101110111011100000000000",
     "0000000000100010101010100010000000000000",
     "0000000000111011101110100011100000000000",
     "0000000000001010001010100010000000000000",
     "0000000000111010001010111011100000000000",
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     "0000111010010101011101100111011101110000",
     "0000010011010101010101010100010101000000",
     "0000010011110101011101010111011101110000",
     "0000010010110101010101010100011000010000",
     "0000111010010010010101100111010101110000",
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'));

  constant matriz_win : matriz1 :=
    ((others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     "0000000000001000100110010010000000000000",
     "0000000000001000101001010010000000000000",
     "0000000000000111001001010010000000000000",
     "0000000000000010001001010010000000000000",
     "0000000000000010000110001100000000000000",
     (others => '0'),
     "0000000000001000101110100100000000000000",
     "0000000000001000100100110100000000000000",
     "0000000000001010100100101100000000000000",
     "0000000000001101100100100100000000000000",
     "0000000000001000101110100100000000000000",
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'));

  constant matriz_lose : matriz1 :=
    ((others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     "0000000000001000100110010010000000000000",
     "0000000000001000101001010010000000000000",
     "0000000000000111001001010010000000000000",
     "0000000000000010001001010010000000000000",
     "0000000000000010000110001100000000000000",
     (others => '0'),
     "0000000000001000001100011101111000000000",
     "0000000000001000010010100001000000000000",
     "0000000000001000010010011001110000000000",
     "0000000000001000010010000101000000000000",
     "0000000000001111001100111001111000000000",
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'));

  constant sprite_inv : matriz :=
    ((others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     "00000000011000000000011000000000",
     "00000000011000000000011000000000",
     "00000000000110000001100000000000",
     "00000000000110000001100000000000",
     "00000000011111111111111000000000",
     "00000000011111111111111000000000",
     "00000001111001111110011110000000",
     "00000001111001111110011110000000",
     "00000111111111111111111111100000",
     "00000111111111111111111111100000",
     "00000110011111111111111001100000",
     "00000110011111111111111001100000",
     "00000110011000000000011001100000",
     "00000110011000000000011001100000",
     "00000000000111100111100000000000",
     "00000000000111100111100000000000",
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'));

  constant sprite_nave : matriz :=
    ("00000000000000011000000000000000",
     "00000000000000011000000000000000",
     "00000000000000011000000000000000",
     "00000000000000011000000000000000",
     "00000000000001111110000000000000",
     "00000000000001111110000000000000",
     "00000000000001111110000000000000",
     "00000000000001111110000000000000",
     "00000001100001111110000110000000",
     "00000001100001111110000110000000",
     "00000001100001111110000110000000",
     "00000001100001111110000110000000",
     "00000001100111111111100110000000",
     "00000001100111111111100110000000",
     "00000001111111100111111110000000",
     "00000001111111100111111110000000",
     "01100001111110000001111110000110",
     "01100001111110000001111110000110",
     "01100001111110011001111110000110",
     "01100001111110011001111110000110",
     "01100001111111111111111110000110",
     "01100001111111111111111110000110",
     "01100111111111111111111111100110",
     "01100111111111111111111111100110",
     "01111111111111111111111111111110",
     "01111111111111111111111111111110",
     "01111110011111111111111001111110",
     "01111110011111111111111001111110",
     "01111000011110011001111000011110",
     "01111000011110011001111000011110",
     "01100000000000011000000000000110",
     "01100000000000011000000000000110");

  constant sprite_bala : matriz :=
    ("00000000000000111100000000000000",
     "00000000000001111110000000000000",
     "00000000000010111111000000000000",
     "00000000000111111111100000000000",
     "00000000001111111111110000000000",
     "00000000001111111111110000000000",
     "00000000011111111111111000000000",
     "00000000011111111111111000000000",
     "00000000011111111111111000000000",
     "00000000011111111111111000000000",
     "00000000011111111111111000000000",
     "00000000011111111111111000000000",
     "00000000011111111111111000000000",
     "00000000011111111111111000000000",
     "00000111111111111111111111100000",
     "00000110011111111111111001100000",
     "00001100011111111111111000110000",
     "00110000011111111111111000001100",
     "00110000000000000000000000001100",
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'),
     (others => '0'));

  -- Colores a utilizar
  constant BLANCO : std_logic_vector(2 downto 0) := "111";
  constant NEGRO  : std_logic_vector(2 downto 0) := "000";
  constant ROJO   : std_logic_vector(2 downto 0) := "100";
  constant VERDE  : std_logic_vector(2 downto 0) := "010";
  constant AZUL   : std_logic_vector(2 downto 0) := "001";

begin

  x_pos <= to_integer(x(9 downto 5));   -- Coordenadas de 32x32 pixeles
  y_pos <= to_integer(y(9 downto 5));

  x_pos1 <= to_integer(x(9 downto 4));  -- Coordenadas 16x16 pixeles
  y_pos1 <= to_integer(y(9 downto 4));

  s_x_bala <= x_bala;
  s_y_bala <= y_bala;

  process(estado1, x_pos, y_pos, x_nave, y_nave, x_inv, y_inv, s_x_bala, s_y_bala, x, y, x_pos1, y_pos1)
  begin

    -- Dibujar tablero de ajedrez
    if estado1 = estado_test then
      if x_pos < 20 and y_pos < 15 then
        if (x(5) xor y(5)) = '1' then
          color <= NEGRO;
        else
          color <= BLANCO;
        end if;
      else
        color <= NEGRO;
      end if;

    elsif estado1 = jugando then

      -- Dibujo de la nave
      if x_pos = x_nave and y_pos = y_nave then
        if sprite_nave(to_integer(y(4 downto 0)))(to_integer(x(4 downto 0))) = '1' then
          color <= ROJO;
        else
          color <= NEGRO;
        end if;

      -- Dibujo de los invasores
      elsif y_pos = y_inv and x_inv(x_pos) = '1' then
        if sprite_inv(to_integer(y(4 downto 0)))(to_integer(x(4 downto 0))) = '1' then
          color <= VERDE;
        else
          color <= NEGRO;
        end if;

      -- Dibujo de la bala
      elsif y_pos = s_y_bala and x_pos = s_x_bala then
        if sprite_bala(to_integer(y(4 downto 0)))(to_integer(x(4 downto 0))) = '1' then
          color <= AZUL;
        else
          color <= NEGRO;
        end if;
      else
        color <= NEGRO;
      end if;

      -- Dibujo de la pantalla de inicio
    elsif estado1 = estado_inicio then
      if matriz_inicio(y_pos1)(x_pos1) = '1' then
        color <= VERDE;
      else
        color <= NEGRO;
      end if;

      -- Dibujo de la pantalla cuando se ha ganado la partida
    elsif estado1 = ganado then
      if matriz_win(y_pos1)(x_pos1) = '1' then
        color <= VERDE;
      else
        color <= NEGRO;
      end if;

      -- Dibujo de la pantalla cuando se ha perdido la partida
    elsif estado1 = perdido then
      if matriz_lose(y_pos1)(x_pos1) = '1' then
        color <= ROJO;
      else
        color <= NEGRO;
      end if;

      -- Dibujamos el fondo en caso de que no se cumpla ninguna condicion
    else
      color <= NEGRO;
    end if;
    
  end process;

end Behavioral;
