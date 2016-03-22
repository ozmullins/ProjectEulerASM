#
# https://projecteuler.net/problem=3
# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?
#
# Using algorithm taken from:
# http://code.jasonbhill.com/c/project-euler-problem-3/
# Works by dividing itself by a counter, untill it / counter can't be divided by anything
# other then 1 and itself
#
# Solution by Joseph Mullins
# Answer: 6857
#
# Compile with gcc euler_3.s

  .global main

  .text

main:
  mov $600851475143, %rcx     # The number
  mov $1, %rbx                # rbx will hold our current count

loop:
  add $2, %rbx                # count in 2's as even numbers can't be a prime factorial
  mov %rcx, %rax              # setup for divison
  mov $0, %rdx
  div %rbx
  cmp $0, %rdx                # Check if remainder is 0, if so then set into rdx
  je  set_rcx
  cmp $1, %rax                # if the division was equal to one, we have our largest prime
  je print                    # so print it if that was the case
  jmp loop                    # repeat if it wasnt

set_rcx:
  mov %rax, %rcx              # store the result of the divison into rcx
  jmp loop

print:
  mov $format, %rdi
  mov %rcx, %rsi
  xor %rax, %rax

  call printf
  ret

format:
  .asciz "%200d\n"

