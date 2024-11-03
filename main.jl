using ForwardDiff

f(x) = x[1]^2 + x[2]^2


res = ForwardDiff.gradient(f,[1,3.3])

println(res)