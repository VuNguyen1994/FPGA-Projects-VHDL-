----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2019 01:43:04 AM
-- Design Name: 
-- Module Name: bcd_array_adder_tb - struc
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
use IEEE.STD_LOGIC_1164.ALL;
use work.bcd_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_array_adder_tb is
generic (n:natural := 1);
  Port (x, y: in std_logic_vector(4*n-1 downto 0);
  z: out std_logic_vector(4*n-1 downto 0);
  cin: in std_logic;
  cout: out std_logic);
end bcd_array_adder_tb;

architecture struc of bcd_array_adder_tb is

component bcd_array_adder
generic(n: natural := 1);
  Port (a, b: in bcd_vector(n-1 downto 0);
  c: out bcd_vector(n-1 downto 0);
  cin: in std_logic;
  cout: out std_logic);
end component;

signal a, b, c: bcd_vector (n-1 downto 0);
signal temp: std_logic_vector (3 downto 0);

begin
-- wire input bits to bcd vectors
W: for i in 0 to n-1 generate
    a(i) <= x(4*(i+1)-1 downto 4*i);
    b(i) <= y(4*(i+1)-1 downto 4*i);
    z(4*(i+1) -1 downto 4*i) <= c(i);
end generate W;

U: bcd_array_adder generic map(n)
port map (a, b, c, cin, cout);

end struc;
