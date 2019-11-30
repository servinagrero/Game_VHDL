----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2019 19:48:39
-- Design Name: 
-- Module Name: Debounce - Behavioral
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


-- Modulo basico de antirebotes
--
-- Por defecto se permite el registo de pulsacion cada 100 ms
entity Debounce is
  generic (t_d : integer := 100);       -- Tiempo de antirebot
  port(clk     : in  std_logic;
       reset   : in  std_logic;
       entrada : in  std_logic;
       salida  : out std_logic);
end Debounce;

architecture Behavioral of Debounce is

-- Componentes
  component temporizador is
    generic(t : integer := 1);  -- El pulso se producira cada t milisegundos
    port(clk, reset, enable, clear : in  std_logic;
         q                         : out std_logic);
  end component;

-- Signals y estados
  type estado is (reposo, flanco, espera, dis);
  signal actual, siguiente : estado;
  signal s_clear           : std_logic;
  signal ton, cout         : std_logic;

begin

-- Instanciacion
  tim1 : temporizador
    generic map (t => t_d)
    port map(clk   => clk, reset => reset, enable => ton, clear => s_clear, q => cout);

  s_clear <= '1' when ton = '0' else '0';

  process(clk, reset)
  begin
    if reset = '1' then
      actual <= reposo;
    elsif rising_edge(clk) then
      actual <= siguiente;
    end if;
  end process;

  process(actual, entrada, cout)
  begin
    case actual is
      when reposo => salida <= '0'; ton <= '0';
                     if entrada = '1' then
                       siguiente <= flanco;
                     else
                       siguiente <= reposo;
                     end if;
                     
      when flanco => salida <= '1'; ton <= '0';
                     siguiente <= dis;
                     
      when dis => salida <= '0'; ton <= '1';
                  if cout = '1' then
                    if entrada = '0' then
                      siguiente <= reposo;
                    else
                      siguiente <= espera;
                    end if;
                  else
                    siguiente <= dis;
                  end if;
                  
      when espera => salida <= '0'; ton <= '0';
                     if entrada = '0' then
                       siguiente <= reposo;
                     else
                       siguiente <= espera;
                     end if;
    end case;
    
  end process;

end Behavioral;
