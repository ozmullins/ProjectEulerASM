#
# https://projecteuler.net/problem=3
# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?
#
# Solution by Joseph Mullins
# Answer: 6857
#
# Compile with gcc euler_3.s

  .global main

  .text

main:
  mov $600851475143, %rcx         # The number
  mov $0, %rdx
  mov %rcx, %rax
  mov $2, %rbx
  div %rbx                        # Half is the max the prime factor can be
  cmp $0, %rdx                    # If it was divisible by 2 then we need to subtract 1
  jne setup
  dec %rax

setup:
  mov %rax, %rbx                  # rbx will hold our current count
  push %rcx

loop:
  pop %rcx
  sub $2, %rbx                       # Start the countdown to find highest factor
  mov %rcx, %rax                  # set up to see if starting number is divisible by rdx
  mov $0, %rdx
  div %rbx
  cmp $0, %rdx                    # Check if remainder is 0, if so then check if its a prime
  je check_if_prime
  push %rcx
  jmp loop

check_if_prime:
  push %rcx                       # Save our prime master number
  mov $2, %rcx                    # Start our checking if prime number at 2

prime_loop:
  cmp %rcx, %rbx                  # if rcx got high enough to only be divisible by itself, its prime
  je print
  mov %rbx, %rax                  # divide the current number, by 2..n
  mov $0, %rdx
  div %rcx
  cmp $0, %rdx                    # if remainder is 0, it was divisible by something other then itself
  je loop
  inc %rcx                        # increment and keep going
  jmp prime_loop

print:
  pop %rdx                        # So everythings off the stack
  mov $format, %rdi
  mov %rbx, %rsi
  xor %rax, %rax

  call printf
  ret

format:
  .asciz "%200d\n"

