# The sum of the squares of the first ten natural numbers is,
#
# 1^2 + 2^2 + ... + 10^2 = 385
# The square of the sum of the first ten natural numbers is,
#
# (1 + 2 + ... + 10)^2 = 55^2 = 3025
# Hence the difference between the sum of the squares of the first ten natural numbers and the square of
# the sum is 3025 − 385 = 2640.
#
# Find the difference between the sum of the squares of the first one hundred natural numbers and the square
# of the sum.
#
# Solution by Joseph Mullins
# Answer: 25164150
#
# Compile with gcc euler_6.s

  .global main

  .text

main:
  mov $1, %r9               # Sum
  mov $1, %r10              # Multiples
  mov $1, %rbx

start_incrementing:
  inc %rbx
  add %rbx, %r9             # Add to the sum

  mov %rbx, %rax            # move current counter into %rax
  mul %rbx                  # times by itself ^2
  add %rax, %r10            # add to r10

  cmp $100, %rbx            # If incrementer gets to 100, we have the sum of them all
  je find_diff
  jmp start_incrementing


find_diff:
  mov %r9, %rax             # now we need the sum of (1..100)^2
  mul %r9
  sub %r10, %rax            # sub the multiples from the total power

print:
  mov $format, %rdi   # set first paramter of print f, formatting
  mov %rax, %rsi      # set 2nd paramter (the result)
  xor %rax, %rax      # because printf is varargs

  call printf
  ret

format:
  .asciz "%200d\n"
