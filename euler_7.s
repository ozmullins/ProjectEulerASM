# https://projecteuler.net/problem=7
#
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# What is the 10 001st prime number?
#
# Solution by Joseph Mullins
# Answer: 104743
#
# compile with gcc euler_7.s

  .global main
  .text

main:
  movq $1, %rcx
  movq $0, %rdx

prime_counter:
  add $2, %rcx
  pushq %rdx
  pushq %rcx
  call check_power
  popq %rcx
  popq %rdx

  cmp $0, %rax
  je prime_counter
  incq %rdx
  cmp $10000, %rdx
  je print
  jmp prime_counter


# PURPOSE: Checks prime
# 0 is not a prime, anything else is
  .type check_power, @function
check_power:
  pushq %rbp
  movq %rsp, %rbp
  movq 16(%rbp), %rcx         # get argument

  movq $2, %rbx               # Find half of the factor
  movq $0, %rdx
  movq %rcx, %rax
  idivq %rbx
  cmpq $0, %rdx               # Though if divisible by 2, not a prime
  je not_prime
  cmpq $2, %rax
  jle end_func
  decq %rax
  movq %rax, %r9
  movq $2, %rbx

loop:
  movq %rcx, %rax
  movq $0, %rdx
  idivq %rbx
  cmpq $0, %rdx
  je not_prime
  cmpq %r9, %rbx              # if we have got to half of it, then we know it must be prime
  je end_func
  incq %rbx
  jmp loop

not_prime:
  movq $0, %rax

end_func:                     # end of a function, %rax must hold return value before here
  movq %rbp, %rsp
  popq %rbp
  ret

print:
  movq $format, %rdi          # set first paramter of printf, formatting
  movq %rcx, %rsi             # set 2nd paramter (the total value)
  xorq %rax, %rax             # printf is varags

  call printf
  ret

format:
  .asciz "%200d\n"
