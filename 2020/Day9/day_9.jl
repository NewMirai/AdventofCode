using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = readlines(path)