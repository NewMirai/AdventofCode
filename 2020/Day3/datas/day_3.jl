using BenchmarkTools

path = joinpath(@__DIR__, "2020", "Day3", "datas", "input.txt")
input = readlines(path)
const TREE_SYMBOL = '\u0023'

function toboggan_solution(slope::Tuple{Int,Int}, input::Array{String,1})
    w = length(input[1])
    h = length(input)
    tree_count = 0
    right = 1
    down = 1
    for i in 2:h
        if down < h
            right = mod1(right + slope[1], w)
            down += slope[2]
            if input[down][right] == TREE_SYMBOL
                tree_count += 1
            end
        end
    end
    tree_count
end

function toboggan_solution(slopes::Array{Tuple{Int,Int},1}, input::Array{String,1})
    tree_count = 1
    for slope in slopes
        tree_count *= toboggan_solution(slope, input)
    end
    tree_count
end

@btime toboggan_solution((3, 1), input)
@btime toboggan_solution([
    (1, 1),
    (3, 1),
    (5, 1),
    (7, 1),
    (1, 2)
],input)