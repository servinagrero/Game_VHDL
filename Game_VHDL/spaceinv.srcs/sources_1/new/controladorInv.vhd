----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 11:39:07
-- Design Name: 
-- Module Name: controladorInv - Behavioral
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

entity controladorInv is
  port(
    clk    : in  std_logic;
    reset  : in  std_logic;
    x_inv  : out std_logic_vector (0 to 19);
    y_inv  : out integer range 0 to 14;
    x_bala : in  integer range 0 to 20;
    y_bala : in  integer range 0 to 15;
    state  : in  estado);
end controladorInv;

architecture Behavioral of controladorInv is
--componentes
  component temporizador is
    generic(t : integer := 1);  --el pulso se producira cada t milisegundos
    port(clk, reset, enable, clear : in  std_logic;
         q                         : out std_logic);
  end component;
  
--señales
  signal s_enable, s_clear : std_logic;
  signal s_q               : std_logic;
  signal s_x_inv           : std_logic_vector(0 to 19);
  signal s_y_inv           : integer range 0 to 14;
begin
  
  temp_inv : temporizador
    generic map (500)
    port map(clk => clk, reset => reset, enable => s_enable, clear => s_clear, q => s_q);

  process(clk, reset)
  begin
    if reset = '1' then
      
      s_x_inv  <= "11111111110000000000";
      s_y_inv  <= 0;
      s_enable <= '1';
      s_clear  <= '0';
      
    elsif rising_edge(clk) then

      -- Reseteamos los invasores si no estamos jugando
      if state = ganado or state = perdido or state = estado_test or state = estado_inicio then
        s_x_inv  <= "11111111110000000000";
        s_y_inv  <= 0;
        s_enable <= '1';
        s_clear  <= '0';

      elsif state = jugando then
        -- Si estamos jugando actualizamos los invasores
        -- Esto supone tanto movimiento como destruccion de los invasores
        -- cuando una bala los golpea
        --
        -- Si se golpea a un invasor, es el controlador de la bala
        -- el encargado de borrar la bala
        if s_q = '1' then
          if s_x_inv(x_bala) = '1' and y_bala = s_y_inv then
            s_x_inv(x_bala) <= '0';
          else
            if (s_y_inv mod 2) = 0 then
              if s_x_inv(19) = '0' then
                s_x_inv <= '0'&s_x_inv(0 to 18);
              else
                s_y_inv <= s_y_inv+1;
              end if;
            else
              if s_x_inv(0) = '0' then
                s_x_inv <= s_x_inv(1 to 19)&'0';
              else
                s_y_inv <= s_y_inv+1;
              end if;
            end if;
          end if;
          
        else
          s_clear  <= '0';
          s_enable <= '1';
        end if;
        
        if s_x_inv(x_bala) = '1' and y_bala = s_y_inv then
          s_x_inv(x_bala) <= '0';
        end if;
        
      else
      end if;
      
    end if;
  end process;

  x_inv <= s_x_inv;
  y_inv <= s_y_inv;

end Behavioral;
