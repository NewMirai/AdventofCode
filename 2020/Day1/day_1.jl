using DelimitedFiles
using  BenchmarkTools

const TARGET = 2020
path = joinpath(@__DIR__,"2020","Day1","datas","input.txt")
data = readdlm(path, '\n', Int32)
hash = Dict{Int32,Int16}(d => i for (i, d) ∈ enumerate(data))

function find_idx(data, hash)
    for (i, d) ∈ enumerate(data)
        diff = TARGET - d
        if haskey(hash, diff)
            return (hash[diff], i)
        end
    end
end

compute_expense(data,idx_tuple) = data[idx_tuple[1]] * data[idx_tuple[2]]

function find_idx_3(data,hash)
    for (i,d) ∈ enumerate(data)
        first = d
        next = i+1
        diff = TARGET- first
        for j = next:length(data)
            diff2 = diff-data[j]
            if haskey(hash,diff2)
               return (i,hash[diff2], j)
            end
        end
    end
end

compute_expense_3(data,idx_tuple) = data[idx_tuple[1]] * data[idx_tuple[2]] * data[idx_tuple[3]]

# Part 1
function solution_part_1(data,hash)
    idx = find_idx(data, hash)
    compute_expense(data, idx)
end

@btime solution_part_1($data,$hash)

# Part 2
function solution_part_2(data,hash)
    idx = find_idx_3(data, hash)
    compute_expense_3(data, idx)
end

@btime solution_part_2($data,$hash)