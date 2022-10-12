#!/usr/bin/env python3

from sys import argv

def finite_automaton_matcher(T, delta, m):
  n = len(T)
  q = 0
  result = []
  for i in range(n):
    q = delta(q, T[i])
    if q == m: result.append(i - m + 1)
  return result

def ends_with(suffix, text):
  return True if len(suffix) == 0 else (text[-len(suffix):] == suffix)

def compute_transition_function(P, Sigma):
  m = len(P)
  delta = {}
  for q in range(m+1):
    for a in Sigma:
      k = min(m, q + 1)
      while not ends_with(P[:k], P[:q] + a): k -= 1
      delta[(q, a)] = k
  return lambda q, a: delta.get((q, a), 0) 

def match(text, pattern):
  transition_function = compute_transition_function(pattern, set(pattern))
  return finite_automaton_matcher(text, transition_function, len(pattern))

if __name__ == "__main__":
  if len(argv) != 3:
    print ("use:\n\tfinite_automata.py <pattern> <file to scan>")
    exit(1)
  with open(argv[2]) as file:
    data = file.read()
    print(match(data, argv[1]))