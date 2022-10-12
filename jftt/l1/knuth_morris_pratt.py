#!/usr/bin/env python3

from sys import argv

def compute_prefix_function(pattern: str) -> list:
  pi = [0] * len(pattern)
  k = 0
  for q in range(1, len(pattern)):
    while k > 0 and pattern[k] != pattern[q]:
      k = pi[k]
    if pattern[k] == pattern[q]: k += 1
    pi[q] = k
  return pi

def KMP_matcher(text: str, pattern: str) -> list:
  n = len(text)
  m = len(pattern)
  pi = compute_prefix_function(pattern)
  q = 0
  res = []

  for i in range(n):
    while q > 0 and pattern[q] != text[i]:
      q = pi[q - 1]
    if pattern[q] == text[i]:
      q += 1
    if q == m - 1:
      res.append(i - m + 2)
      q = pi[q]
  return res

if __name__ == "__main__":
  if len(argv) != 3:
    print ("use:\n\tknuth_morris_pratt.py <pattern> <file to scan>")
    exit(1)
  with open(argv[2]) as file:
    data = file.read()
    print(KMP_matcher(data, argv[1]))