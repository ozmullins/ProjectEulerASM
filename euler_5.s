#
# https://projecteuler.net/problem=5
# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
#
# Solution by Joseph Mullins
# Answer: 232792560
#
# compile with gcc euler_5.s

  .global main

  .text

main:
  mov $20, %r9

next_number:
  add $20, %r9            # Increment by 5, anything divisble of 1 to 20... must be a multiple of 20
  mov $2, %rbx            # start the dividing at 2... everyhings divisble by 1

check_if_divisible_everything_under_20:
  mov $0, %rdx
  mov %r9, %rax
  div %rbx
  cmp $0, %rdx
  jne next_number
  cmp $20, %rbx
  je print
  inc %rbx
  jmp check_if_divisible_everything_under_20

print:
  mov $format, %rdi       # set first paramter of print f, formatting
  mov %r9, %rsi          # set 2nd paramter (the result)
  xor %rax, %rax          # because printf is varargs

  call printf
  ret

format:
  .asciz "%200d\n"

