# Code by Piotr Kakol 254635

function calcualte_macheps(x::AbstractFloat)::AbstractFloat
  one_m = one(typeof(x))
  m = one_m
  old_m = m
  while one_m + m > one_m
    old_m = m
    m /= convert(typeof(x), 2.0)
  end
  return old_m
end

function calculate_eta(x::AbstractFloat)::AbstractFloat
  m = one(typeof(x))
  old_m = m
  while m > zero(typeof(x))
    old_m = m
    m /= convert(typeof(x), 2.0)
  end
  return old_m
end

function calculate_floatmax(x::AbstractFloat)::AbstractFloat
  m = one(typeof(x))
  old_m = m
  while !isinf(m)
    old_m = m
    m *= convert(typeof(x), 2.0)
  end
  return old_m * (convert(typeof(x), 2.0) - calcualte_macheps(x))
end

function excersize1()
  println("Calculate macheps for half, float and double")
  println("Float16: eps: ", eps(Float16), " my eps: ", calcualte_macheps(Float16(1)))
  println("Float32: eps: ", eps(Float32), " my eps: ", calcualte_macheps(Float32(1)))
  println("Float64: eps: ", eps(Float64), " my eps: ", calcualte_macheps(Float64(1)))
  
  println("\nCalculate eta for half, float and double")
  println("Float16: nextfloat: ", nextfloat(zero(Float16)), " my eta: ", calculate_eta(Float16(1)))
  println("Float32: nextfloat: ", nextfloat(zero(Float32)), " my eta: ", calculate_eta(Float32(1)))
  println("Float64: nextfloat: ", nextfloat(zero(Float64)), " my eta: ", calculate_eta(Float64(1)))
  
  println("\nCalculate floatmax for half, float and double")
  println("Float16: floatmax: ", floatmax(Float16), " my floatmax: ", calculate_floatmax(Float16(1)))
  println("Float32: floatmax: ", floatmax(Float32), " my floatmax: ", calculate_floatmax(Float32(1)))
  println("Float64: floatmax: ", floatmax(Float64), " my floatmax: ", calculate_floatmax(Float64(1)))
end

function compare_macheps(x::AbstractFloat)
  type = typeof(x)
  macheps = convert(type, 3) * (convert(type, 4) / convert(type, 3) - 
    convert(type, 1)) - convert(type, 1)
  println(typeof(macheps), ": ", macheps, " ", eps(type))
  macheps == eps(x), macheps == -eps(x)
end

function  excersize2()
  println("\nExcersize 2:")
  println(compare_macheps(Float16(1)))
  println(compare_macheps(Float32(1)))
  println(compare_macheps(Float64(1)))  
end

function calculate_representation(x::Float64)
  k = parse(Int, bitstring(x)[13:end], base=2)
  x_reconstructed = 1.0 + k * 2.0^-52
  println("x: ", x, ", 1 + ", k, " * 2^(-52): ", x_reconstructed)
  println(x == x_reconstructed)
end

function  excersize3()
  println("\nExcersize 3:")
  println(calculate_representation(1.0))
end


function excersize4()
  println("\nExcersize 4:")
  x = nextfloat(1.0)
  i = 1
  while x * (1.0 / x) == 1.0
    i += 1
    x = nextfloat(x)
  end
  println(i, " ", x, " ",  x * (1.0 / x))
end

function forward_sum(x::Array{<:Number}, y::Array{<:Number})::Number
  sum = zero(typeof(x[1]))
  for p in zip(x, y)
    sum += *(p...)
  end
  return sum
end

function backward_sum(x::Array{<:Number}, y::Array{<:Number})::Number
  forward_sum(reverse(x), reverse(y))
end

function decreasing_sum(x::Array{<:Number}, y::Array{<:Number})::Number
  positive = zeros(typeof(x[1]), 0)
  negative = zeros(typeof(x[1]), 0)
  for p in zip(x, y)
    sum = *(p...)
    if (sum > 0)
      append!(positive, sum)
    else
      append!(negative, sum)
    end
  end
  +(sort!(positive, rev=true)...) +(sort!(negative)...)
end

function decreasing_sum(x::Array{<:Number}, y::Array{<:Number})::Number
  positive = zeros(typeof(x[1]), 0)
  negative = zeros(typeof(x[1]), 0)
  for p in zip(x, y)
    sum = *(p...)
    if (sum > 0)
      append!(positive, sum)
    else
      append!(negative, sum)
    end
  end
  +(sort!(positive, rev=true)...) +(sort!(negative)...)
end

function increasing_sum(x::Array{<:Number}, y::Array{<:Number})::Number
  positive = zeros(typeof(x[1]), 0)
  negative = zeros(typeof(x[1]), 0)
  for p in zip(x, y)
    sum = *(p...)
    if (sum > 0)
      append!(positive, sum)
    else
      append!(negative, sum)
    end
  end
  +(sort!(positive, rev=false)...) +(sort!(negative, rev=true)...)
end

function error(original::Number, current::Number)::Number
  abs(original - current)
end

function excersize5()
  println("\nExcersize 5:")

  x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
  y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
  sum = -1.00657107000000 * 10^(-11)

  x_32 = map(x -> Float32(x), x)
  y_32 = map(x -> Float32(x), y)
  sum_32 = Float32(sum)

  println(sum_32)

  s = forward_sum(x, y)
  println("forward_sum: ", s, " ", error(sum, s))
  s = backward_sum(x, y)
  println("backward_sum: ", s, " ", error(sum, s))
  s = decreasing_sum(x, y)
  println("decrasing_sum: ", s, " ", error(sum, s))
  s = increasing_sum(x, y)
  println("increasing_sum: ", s, " ", error(sum, s))

  println("Float32")

  s = forward_sum(x_32, y_32)
  println("forward_sum_32: ", s, " ", error(sum_32, s))
  s = backward_sum(x_32, y_32)
  println("backward_sum_32: ", s, " ", error(sum_32, s))
  s = decreasing_sum(x_32, y_32)
  println("decrasing_sum_32: ", s, " ", error(sum_32, s))
  s = increasing_sum(x_32, y_32)
  println("increasing_sum_32: ", s, " ", error(sum_32, s))

end



function evaluate_f_and_g(x::AbstractFloat)
  f = sqrt(x ^ 2  + 1) - 1
  g = x ^ 2 / (sqrt(x ^ 2  + 1) + 1)
  (f, g, f - g)
end

function excersize6(n::Integer=54)
  println("Excersize6")
  for x in map(x -> x ^ -1, 1:n)
    println(evaluate_f_and_g(x))
  end
end

function calculatte_derivative(x::AbstractFloat, h::AbstractFloat, f::Function)::Number
  (f(x + h) - f(x)) / h
end

function derivative_in_range(x::AbstractFloat, f::Function, n::Integer = 54)
  for h in 0:n
    println(h, ": ", calculatte_derivative(x, 2.0^(-h), f))
  end
end

function excersize7()
  println("Excersize7")
  derivative_in_range(1.0, x->(sin(x) + cos(3 * x)))
  println("Exact value: ", cos(1.0) - 3.0*sin(3.0))
end

excersize1()
excersize2()
excersize3()
excersize4()
excersize5()
excersize6()
excersize7()
