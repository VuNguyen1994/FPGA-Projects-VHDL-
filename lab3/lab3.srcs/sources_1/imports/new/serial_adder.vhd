----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2019 10:00:54 PM
-- Design Name: 
-- Module Name: serial_adder - Beh
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity serial_adder is
generic (n:natural :=3);
  Port (a,b,ck,reset: in std_logic;
  s: out std_logic_vector(n-1 downto 0);
  c_out, done: out std_logic);
end serial_adder;

architecture Beh of serial_adder is
signal state: std_logic;
signal temp: std_logic_vector(n-1 downto 0);
signal carry, sum: std_logic;
component add3bits
  Port (x: in std_logic_vector (2 downto 0);
  z: out std_logic_vector (1 downto 0));
end component;

subtype my_int is integer range 0 to n;
signal count: my_int;

begin
F1: process(ck)
begin
if ck='1' and ck'event then
if reset = '1' then
    state <='0';
    count<=0;
    temp<= (others => '0');
    done<= '0';
else
    if count <n then
        state <= carry;
        temp(n-1)<=sum;
        for i in n-2 downto 0 loop
            temp(i)<=temp(i+1);
        end loop;
        count<=count+1;
    if count=n-1 then
        done<='1';
        else
        done<='0';
    end if;
    end if;
end if;
end if;
end process F1;
c_out <= state;
s<= temp;
ADD3b: add3bits port map(
z(1) => carry, z(0) =>sum,
x(2) => a, x(1) => b, x(0) => state);
end Beh;
