using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = parse.(Int, readlines(path))

# Part 1
function part_1(inputs::Array{Int64,1}, n_preamble::Int64, n_previous::Int64)
    for i ∈ n_preamble + 1:length(inputs)
        seen = BitSet()
        found_number = false
        for j ∈ i - n_previous:i - 1
            diff = inputs[i] - inputs[j]
            if diff ∈ seen
                found_number = true
            end
            push!(seen, inputs[j])
        end
        found_number == false && return inputs[i]
    end
end

@btime part_1(inputs,25,25)

# Part 2

function part_2(inputs::Array{Int64,1}, n_preamble::Int64, n_previous::Int64)
    target = part_1(inputs, n_preamble,n_previous)
    low = 1
    high = 2
    acc = sum(inputs[low:high])
    while acc!=target
        high += 1
        acc += inputs[high]
        if acc > target
            acc -= inputs[low] + inputs[high]
            low += 1
            high -= 1
        end
    end
    sum(extrema(@view inputs[low:high]))
end

@btime part_2(inputs,25,25)