# https://projecteuler.net/problem=1
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
# The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.
#
# Solution by Joseph Mullins,
# Answer: 233168
#
# Compile with gcc euler_1.s


  .global main

  .text

main:
  mov $1000, %rcx       # rcx will countdown to 0
  xor %rax, %rax        # rax will hold current number
  dec %rcx              # we want everything below this

loop:
  push %rax             # we want to store its current value so its not lost below
  mov $0, %rdx
  mov %rcx, %rax        # Move current counter to rcx
  mov $3, %rbx          # Move 3 into rbx
  div %rbx              # divide it by 3, rdx will hold the remainder

  cmp $0, %rdx          # if rcx was divisible by 5, then rdx will be 0
  je add_to_total       # add this if compare passed

  mov $0, %rdx
  mov %rcx, %rax
  mov $5, %rbx          # check if divisible by 5
  div %rbx              # divide it by 3, rdx will hold the remainder

  cmp $0, %rdx
  je add_to_total       # add this if compare passed

  pop %rax
  dec %rcx              # reduce rcx by 1
  jnz loop              # if not 0 then repeat
  jmp print             # print the output

add_to_total:
  pop %rax              # retrieve what eax was
  add %rcx, %rax        # add current value of rcx to it
  dec %rcx              # reduce rcx by 1
  jmp loop              # rinse and repeat

print:
  mov $format, %rdi     # set first paramter of printf, formatting
  mov %rax, %rsi        # set 2nd paramter (the total value)
  xor %rax, %rax        # printf is varags

  call printf
  ret

format:
  .asciz "%200d\n"
