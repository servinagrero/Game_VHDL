----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2019 19:07:43
-- Design Name: 
-- Module Name: GestionEntradas - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Gestion de todas las entradas a la FPGA
--
-- Se utiliza un antirebote por boton
entity GestionEntradas is
  port(clk, reset : in  std_logic;
       Izquierda  : in  std_logic;
       Derecha    : in  std_logic;
       Inicio     : in  std_logic;
       Disparo    : in  std_logic;
       Izquierda1 : out std_logic;
       Derecha1   : out std_logic;
       Inicio1    : out std_logic;
       Disparo1   : out std_logic);
end GestionEntradas;

architecture Behavioral of GestionEntradas is

-- Componentes
  component Debounce is
    generic (t_d : integer := 100);     --tiempo de debounce
    port(clk     : in  std_logic;
         reset   : in  std_logic;
         entrada : in  std_logic;
         salida  : out std_logic);
  end component;

begin
  d_izq : Debounce port map (clk     => clk, reset => reset,
                             entrada => Izquierda, salida => Izquierda1);
  
  d_dcha : Debounce port map (clk => clk, reset => reset,
                              entrada => Derecha, salida => Derecha1);
  
  d_disp : Debounce port map (clk => clk, reset => reset,
                              entrada => Disparo, salida => Disparo1);
  
  d_inic : Debounce port map (clk => clk, reset => reset,
                              entrada => Inicio, salida => Inicio1);


end Behavioral;
