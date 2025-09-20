import os
import random
from random_bits_alice import random_bit as generate_bit

def generate_bb84_mem_file(num_bits, filename="C:/Users/TARUN/QKD_128bit/QKD_128bit.sim/sim_1/behave/xsim/data.mem"):
    os.makedirs(os.path.dirname(filename), exist_ok=True)

    # Generate bits
    alice_bits = [generate_bit() for _ in range(num_bits)]
    alice_bases = [generate_bit() for _ in range(num_bits)]
    bob_bases = [generate_bit() for _ in range(num_bits)]

    # Format: each line contains one 3-bit value: [alice_bit][alice_base][bob_base]
    with open(filename, 'w') as f:
        for a_bit, a_base, b_base in zip(alice_bits, alice_bases, bob_bases):
            # Concatenate as 3-bit binary string
            packed_bits = f"{a_bit}{a_base}{b_base}"
            f.write(packed_bits + '\n')

    print(f"[INFO] Memory file saved at: {os.path.abspath(filename)}")


# Message bit length
d = 1
n = int(input("Length of message bits: "))
y = (4 + d) * n

if __name__ == '__main__':
    generate_bb84_mem_file(y)
    print(f"Total bits (y): {y}")
    print(f"Message bits (n): {n}")






