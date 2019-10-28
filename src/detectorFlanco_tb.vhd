library ieee;
use ieee.std_logic_1164.all;

entity detectorflanco_tb is
end detectorflanco_tb;

architecture beh of detectorflanco_tb is
  
  component detector_flanco port(clk    : in  std_logic;
                                 rst    : in  std_logic;
                                 input  : in  std_logic;
                                 output : out std_logic
                                 );
  end component;
  signal clk, rst, input : std_logic := '0';
  signal output          : std_logic;

begin
  flc : detector_flanco port map(clk => clk,
                                 rst => rst,
                                 input => input,
                                 output => output);
  clk <= not clk after 10 ns;

  process
  begin
    wait for 20 ns;
    input <= '1';
    wait for 50 ns;
    input <= '0';
    wait for 60 ns;
  end process;
end beh;



