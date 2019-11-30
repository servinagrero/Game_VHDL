----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 11:36:23
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
use work.state.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SpaceInv is
  port (clk       : in  std_logic;
        reset     : in  std_logic;
        Inicio    : in  std_logic;
        Test      : in  std_logic;
        Izquierda : in  std_logic;
        Derecha   : in  std_logic;
        Disparo   : in  std_logic;
        Hsync     : out std_logic;
        Vsync     : out std_logic;
        R         : out std_logic_vector (3 downto 0);
        G         : out std_logic_vector (3 downto 0);
        B         : out std_logic_vector (3 downto 0));
end SpaceInv;

architecture Behavioral of SpaceInv is

--Declaraciones de componentes

--------------------------------------------------------

  component VGA is
    port (clk     : in  std_logic;
          reset   : in  std_logic;
          color   : in  std_logic_vector (2 downto 0);
          Hsync   : out std_logic;
          Vsync   : out std_logic;
          R, G, B : out std_logic_vector (3 downto 0);
          x       : out unsigned (9 downto 0);
          y       : out unsigned (9 downto 0));
  end component;

--------------------------------------------------------

  component formatoVGA is
    port (color   : out std_logic_vector (2 downto 0);
          x       : in  unsigned (9 downto 0);
          y       : in  unsigned (9 downto 0);
          estado1 : in  estado;

          x_nave : in integer range 0 to 19;
          y_nave : in integer range 0 to 14;

          x_bala : in integer range 0 to 20;
          y_bala : in integer range 0 to 15;

          x_inv : in std_logic_vector (0 to 19);
          y_inv : in integer range 0 to 14
          );
  end component;

--------------------------------------------------------

  component controladorNave is
    port (
      Clk                : in  std_logic;
      Reset              : in  std_logic;
      Derecha, Izquierda : in  std_logic;
      x_nave             : out integer range 0 to 19;
      y_nave             : out integer range 0 to 14
      );
  end component;

--------------------------------------------------------

  component controladorInv is
    port(
      clk    : in  std_logic;
      reset  : in  std_logic;
      x_inv  : out std_logic_vector (0 to 19);
      y_inv  : out integer range 0 to 14;
      x_bala : in  integer range 0 to 20;
      y_bala : in  integer range 0 to 15;
      state  : in  estado);
  end component;

--------------------------------------------------------

  component controladorBala is
    port (
      Clk     : in  std_logic;
      Reset   : in  std_logic;
      Disparo : in  std_logic;
      x_inv   : in  std_logic_vector(0 to 19);
      y_inv   : in  integer range 0 to 14;
      x_bala  : out integer range 0 to 20;
      y_bala  : out integer range 0 to 15;
      x_nave  : in  integer range 0 to 19
      );
  end component;

--------------------------------------------------------

  component GestionEntradas is
    port(clk, reset : in  std_logic;
         Izquierda  : in  std_logic;
         Derecha    : in  std_logic;
         Inicio     : in  std_logic;
         Disparo    : in  std_logic;
         Izquierda1 : out std_logic;
         Derecha1   : out std_logic;
         Inicio1    : out std_logic;
         Disparo1   : out std_logic);
  end component;

--------------------------------------------------------

--Declaraciones de señales auxiliares para conectar los bloques
  signal s_color  : std_logic_vector (2 downto 0);
  signal s_x, s_y : unsigned (9 downto 0);

  signal s1_x_nave : integer range 0 to 19;
  signal s1_y_nave : integer range 0 to 14;

  signal s1_y_inv : integer range 0 to 14;
  signal s1_x_inv : std_logic_vector (0 to 19);

  signal s1_x_bala : integer range 0 to 20;
  signal s1_y_bala : integer range 0 to 15;

  signal s_Derecha, s_Izquierda : std_logic;
  signal s_Inicio, s_Disparo    : std_logic;


--------------------------------------------------------

-- Maquina de estados

  signal actual, siguiente : estado;

--------------------------------------------------------

begin

--------------------------------------------------------
-- Instanciaciones de componentes

  vga_inst : VGA port map (clk   => clk, reset => reset,
                           Hsync => Hsync, Vsync => Vsync,
                           R     => R, G => G, B => B,
                           color => s_color,
                           x     => s_x, y => s_y);

  formVGA : formatoVGA port map (color   => s_color,
                                 x       => s_x, y => s_y,
                                 x_bala  => s1_x_bala,
                                 y_bala  => s1_y_bala,
                                 x_nave  => s1_x_nave,
                                 y_nave  => s1_y_nave,
                                 x_inv   => s1_x_inv,
                                 estado1 => actual,
                                 y_inv   => s1_y_inv);

  GestEn : GestionEntradas port map(clk        => clk, reset => reset,
                                    Izquierda  => Izquierda, Derecha => Derecha,
                                    Inicio     => Inicio, Disparo => Disparo,
                                    Izquierda1 => s_Izquierda, Derecha1 => s_Derecha,
                                    Inicio1    => s_Inicio, Disparo1 => s_Disparo);

  cinv : controladorInv port map (clk    => clk, reset => reset,
                                  x_bala => s1_x_bala,
                                  y_bala => s1_y_bala,
                                  x_inv  => s1_x_inv,
                                  y_inv  => s1_y_inv,
                                  state  => actual);

  cnave : controladorNave port map(clk       => clk, reset => reset,
                                   Derecha   => s_Derecha,
                                   Izquierda => s_Izquierda,
                                   x_nave    => s1_x_nave,
                                   y_nave    => s1_y_nave);

  cbala : controladorBala port map(clk     => clk,
                                   reset   => reset,
                                   Disparo => s_Disparo,
                                   x_bala  => s1_x_bala,
                                   y_bala  => s1_y_bala,
                                   x_nave  => s1_x_nave,
                                   x_inv   => s1_x_inv,
                                   y_inv   => s1_y_inv);

--------------------------------------------------------
-- Maquina de estados

  process(clk, reset)
  begin
    if reset = '1' then
      actual <= estado_inicio;
    elsif rising_edge(clk) then
      actual <= siguiente;
    end if;
  end process;

  -- Maquina de estados para el control del juego
  --
  -- En el estado inicio se muestra una pantalla de inicio del juego
  --
  -- En el estado Test se dibuja un patron de ajedrez
  -- Se esta en el estado siempre que se mantenga pulsado el boton Test
  --
  -- En el estado de jugando se juega al juego
  -- El juego se acaba cuando no quedan invasores o los invasores han
  -- conseguido llegar a la ultima fila
  --
  -- En el estado de ganado se muestra un mensaje de victoria en la pantalla
  --
  -- En el estado de perdido se muestra un mensaje de derrota en la pantalla
  
  process(actual, Test, s_inicio, s1_x_inv, s1_y_inv)
  begin
    case actual is
      
      when estado_inicio =>
        if s_Inicio = '1' then
          siguiente <= jugando;
        elsif Test = '1' then
          siguiente <= estado_test;
        else
          siguiente <= estado_inicio;
        end if;
        
      when estado_test =>
        if Test = '0' then
          siguiente <= estado_inicio;
        else
          siguiente <= estado_test;
        end if;
        
      when jugando =>
        if s1_x_inv = "00000000000000000000" then
          siguiente <= ganado;
        elsif s1_y_inv = 14 then
          siguiente <= perdido;
        else
          siguiente <= jugando;
        end if;
        
      when ganado =>
        if s_inicio = '1' then
          siguiente <= estado_inicio;
        else
          siguiente <= ganado;
        end if;
        
      when perdido =>
        if s_inicio = '1' then
          siguiente <= estado_inicio;
        else
          siguiente <= perdido;
        end if;
    end case;
    
  end process;

end Behavioral;

