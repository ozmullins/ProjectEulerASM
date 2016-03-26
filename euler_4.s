# https://projecteuler.net/problem=4
# A palindromic number reads the same both ways. The largest palindrome made from the
# product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.
#
# I decided to tackle the checking of the palindrome in a pure mathematical way instead of
# turning to a string and checking
#
# Solution by Joseph Mullins
# Answer: 906609
#
# Compile with gcc euler_4.s

  .global main

  .text

main:
  mov $1000000, %r15        #  r15 will hold our counter

find_next_palindrome:
  dec %r15                  # count down, to find the highest palindrome
  mov %r15, %r8             # Check palindrome function uses r8 for checking
  jmp palindrome_check      # Initiate check if its palindrome

see_if_divisible:
  mov $1000, %rbx

count_down_rbx:
  dec %rbx
  cmp $99, %rbx
  je find_next_palindrome
  mov %r15, %rax
  mov $0, %rdx
  div %rbx
  cmp $0, %rdx
  jne count_down_rbx
  cmp $100, %rax
  jl find_next_palindrome
  cmp $999, %rax
  jg find_next_palindrome
  jmp print



palindrome_check:
  mov $1, %rcx            # %rcx will return with the highest devisor so start at 1

calculate_highest_division:  # Get the biggest power of 10 the number is divisible by
  mov %rcx, %rax
  mov $10, %rbx
  mul %rbx
  mov %rax, %rcx
  mov $0, %rdx
  mov %r8, %rax
  mov %rcx, %rbx
  div %rbx
  cmp $0, %rax
  jne calculate_highest_division  # If the divison wasn't 0, then we can go higher

  mov %rcx, %rax
  mov $10, %rbx
  mov $0, %rdx
  div %rbx
  mov %rax, %r9           # we actually want one less, so divide by 10 and use r9 to save it

  mov %r8, %rax
  mov $1, %r11

loop:
  mov $0, %rdx
  mov $10, %rbx
  div %rbx                # rax now holds the current value of the number % 10
  push %rax               # save rax
  push %rdx               # rdx will have the right most number, so save it

  mov %r8, %rax
  mov %r9, %rbx
  mov $0, %rdx
  div %rbx                # rax will now hold our the left most number

  pop %rdx
  cmp %rdx, %rax
  jne not_palindrome      # if rax and rdx aren't same, then not palindrome

  mov %r9, %rbx           # so far we on right track, so reduce the starting number by its left most number
  mul %rbx
  sub %rax, %r8

  mov %r9, %rax           # now we want to reduce r9 by 10, to get the next left most number
  mov $10, %rbx
  mov $0, %rdx
  div %rbx
  mov %rax, %r9           # save it for good record keeping

  pop %rax                # get back the value of rax from the start, the starting number / 10n
  cmp $1, %r9
  je is_palindrome
  jmp loop

not_palindrome:
  pop %rax
  jmp find_next_palindrome

is_palindrome:
  jmp see_if_divisible

print:
  mov $format, %rdi
  mov %r15, %rsi
  xor %rax, %rax

  call printf
  ret

format:
  .asciz "%200d\n"
