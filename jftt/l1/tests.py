from cgi import test
import finite_automata as fa
import knuth_morris_pratt as kmp

def read_tests(cases_path: str, tests_path: str):
  with open(cases_path) as cases:
    with open(tests_path) as tests:
      cases_data = cases.read()
      
      def m_split(x):
        p = x.find(' ')
        return (x[:p].strip("'"), 
          [] if x[p+1:].strip('\n') == '[]' else [int(i) for i in x[p+1:].strip('[]\n').split(', ')])

      tests_data = [m_split(line) for line in tests.readlines()]
      for pattern, res in tests_data:
        print("Test: {}".format(pattern))
        print("\tKMP: {} FA: {}".format(
          kmp.KMP_matcher(cases_data, pattern) == res,
          fa.match(cases_data, pattern) == res))

if __name__ == "__main__":
  read_tests("tests/cases-EMOJI.txt", "tests/tests-EMOJI.txt")