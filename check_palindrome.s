# This is part of the way for project euler problem 4, and checks if a number is a palindrome
#
# 1 := Palindrome | 0 := Not Palindrome
#
# https://projecteuler.net/problem=4
# A palindromic number reads the same both ways. The largest palindrome made from the
# product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.
#
# Solution by Joseph Mullins
#
# Compile with gcc check_palindrome.s

  .global main

  .text

main:
  mov $52311325, %r8        # Number to check if palindrome

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
  mov $0, %rax
  jmp print

is_palindrome:
  mov $1, %rax
  jmp print

print:
  mov $format, %rdi
  mov %rax, %rsi
  xor %rax, %rax

  call printf
  ret

format:
  .asciz "%200d\n"
