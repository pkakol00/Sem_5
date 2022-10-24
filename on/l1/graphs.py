from matplotlib import pyplot as plt

def plot_dif():
  with open("res_3") as file:
    lines = [abs(float(line.split()[2][:-1])) for line in file.readlines()]
    xs = range(1,len(lines) + 1)
    plt.plot(xs,lines)
    plt.show()
    print(lines)


def plot_derivative():
  og = .11694228168853815
  with open("res_4") as file:
    lines = [abs(float(line.split()[1])-og) for line in file.readlines()]
    xs = range(len(lines))
    plt.plot(xs, lines)
    plt.show()

if __name__ == "__main__":
  plot_derivative()