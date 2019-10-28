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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SpaceInv is
  port (
    clk    : in std_logic;
    reset  : in std_logic;
    Inicio : in std_logic;              -- Para iniciar el juego
    -- Test      : in  std_logic;   -- Para dibujar el patron de prueba

    -- Control de la nave
    Derecha   : in std_logic;
    Izquierda : in std_logic;

    -- Signals de sincronismo
    Hsync : out std_logic;
    Vsync : out std_logic;

    -- Colores para dibujar en pantalla
    R : out std_logic_vector (3 downto 0);
    G : out std_logic_vector (3 downto 0);
    B : out std_logic_vector (3 downto 0));
end SpaceInv;


architecture Behavioral of SpaceInv is

--------------------------------------------------
  component formatoVGA
    port (
      color  : out std_logic_vector (2 downto 0);
      x      : in  std_logic_vector (9 downto 0);
      y      : in  std_logic_vector (9 downto 0);
      -- Coordenadas de la nave
      x_nave : in  std_logic_vector (4 downto 0);
      y_nave : in  std_logic_vector (4 downto 0);
      -- Coordenadas de la bala
      x_bala : in  std_logic_vector (4 downto 0);
      y_bala : in  std_logic_vector (4 downto 0);
      -- Coordenadas de los invasores
      x_inv  : in  std_logic_vector (0 to 19);
      y_inv  : in  std_logic_vector (4 downto 0)
      );
  end component;

  signal color_s   : std_logic_vector(2 downto 0);
  signal color_vga : std_logic_vector(2 downto 0);
  signal x_s, y_s  : std_logic_vector(9 downto 0);

  signal x_nave : std_logic_vector (4 downto 0);
  signal y_nave : std_logic_vector (4 downto 0);

  signal x_bala : std_logic_vector (4 downto 0);
  signal y_bala : std_logic_vector (4 downto 0);

  signal y_inv : std_logic_vector (4 downto 0);
  signal x_inv : std_logic_vector (0 to 19);

--------------------------------------------------
  component VGA
    port (
      clk   : in  std_logic;
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

--------------------------------------------------
  component controladorNave
    port (
      clk                : in  std_logic;
      Reset              : in  std_logic;
      Derecha, Izquierda : in  std_logic;
      x, y               : out std_logic_vector (4 downto 0)
      );
  end component;

  signal clk_nave : std_logic;

--------------------------------------------------
  component controladorInv
    port(
      clk   : in std_logic;
      reset : in std_logic;

      x_bala : in std_logic_vector (4 downto 0);
      y_bala : in std_logic_vector (4 downto 0);

      x_inv : out std_logic_vector (0 to 19);
      y_inv : out std_logic_vector (4 downto 0)
      );
  end component;

  signal clk_inv : std_logic;

--------------------------------------------------
  component temporizador
    generic (Ancho : integer := 6);
    port (
      Clk    : in  std_logic;
      Reset  : in  std_logic;
      Clear  : in  std_logic;
      Enable : in  std_logic;
      Cuenta : out unsigned(Ancho-1 downto 0);
      pulse  : out std_logic
      );
  end component;

  signal clear_nave      : std_logic;
  signal tempNave_en     : std_logic;
  signal tempNave_cuenta : unsigned(500 downto 0);
  signal tempNave_pulse  : std_logic;

  signal clear_inv      : std_logic;
  signal tempInv_en     : std_logic;
  signal tempInv_cuenta : unsigned(500 downto 0);
  signal tempInv_pulse  : std_logic;

--------------------------------------------------
begin

  vga_m : VGA port map (clk   => clk,
                        reset => reset,
                        color => color_vga,
                        Hsync => Hsync,
                        Vsync => Vsync,
                        R     => R, G => G, B => B,
                        x     => x_s, y => y_s
                        );

  fvga : formatoVGA port map (color  => color_s,
                              x      => x_s, y => y_s,
                              x_nave => x_nave, y_nave => y_nave,
                              x_bala => x_bala, y_bala => y_bala,
                              x_inv  => x_inv, y_inv => y_inv
                              );



  cNave : controladorNave port map (clk       => clk_nave,
                                    reset     => reset,
                                    Derecha   => Derecha,
                                    Izquierda => Izquierda,
                                    x         => x_nave, y => y_nave
                                    );

  tempNave : temporizador generic map (Ancho => 501)
    port map (clk    => clk,
              reset  => reset,
              clear  => clear_nave,
              enable => tempNave_en,
              Cuenta => tempNave_cuenta,
              pulse  => tempNave_pulse);




  cInv : controladorInv port map (clk    => clk_inv,
                                  reset  => reset,
                                  x_bala => x_bala, y_bala => y_bala,
                                  x_inv  => x_inv, y_inv  => y_inv);

  tempInv : temporizador generic map (Ancho => 501)
    port map (clk    => clk,
              reset  => reset,
              clear  => clear_inv,
              enable => tempInv_en,
              Cuenta => tempInv_cuenta,
              pulse  => tempInv_pulse
              );


  tempInv_en  <= '1';
  tempNave_en <= '1';
  clear_inv   <= '0';
  clear_nave  <= '0';

  color_vga <= color_s;
  clk_inv   <= tempInv_pulse;
  clk_nave  <= tempNave_pulse;

end Behavioral;
