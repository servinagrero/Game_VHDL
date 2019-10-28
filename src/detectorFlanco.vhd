library ieee;
use ieee.std_logic_1164.all;

entity detectorFlanco is
  port(clk    : in  std_logic;
       reset  : in  std_logic;
       input  : in  std_logic;
       output : out std_logic
       );
end detectorFlanco;

architecture behaviour of detectorFlanco is
  signal var : std_logic := '1';
begin
  output <= '1' when input = '1' and var = '1' else '0';

  process(clk, reset)
  begin
    if reset = '1' then
      var <= '1';
    elsif rising_edge(clk) then
      if (input = '0') then
        var <= '1';
      else var <= '0';
      end if;
    end if;
  end process;


end behaviour;



