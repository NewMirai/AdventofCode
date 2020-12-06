using BenchmarkTools
path = joinpath(@__DIR__, "datas", "input.txt")
inputs = open(f -> read(f, String), path)
# Part 1
@btime sum(length.(Set.(replace.(split($inputs, "\n\n"),"\n"=>""))))
# Part 2
@btime sum(length.(map(x -> reduce(intersect,x),Set.(split.(split($inputs, "\n\n"),"\n")))))