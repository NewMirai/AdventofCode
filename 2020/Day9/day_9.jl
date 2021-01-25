using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = parse.(Int, readlines(path))

# Part 1
function solution(inputs::Array{Int,1}, n_preamble::Int, n_previous::Int)
    for i ∈ n_preamble + 1:length(inputs)
        seen = Set{Int}()
        found_number = false
        for j ∈ i - n_previous:i - 1
            @inbounds if inputs[i] - inputs[j] ∈ seen
                found_number = true
            end
            @inbounds push!(seen, inputs[j])
        end
        @inbounds found_number == false && return inputs[i]
    end
end
 
@btime solution($inputs, 25, 25)
solution_part_1 = solution(inputs, 25, 25)

# Part 2
function solution(inputs::Array{Int,1}, invalid_number::Int)
    low = 1
    high = 2
    acc = sum(@view inputs[low:high])
    while acc != invalid_number
        high += 1
        @inbounds acc += inputs[high]
        if acc > invalid_number
            @inbounds acc -= inputs[low] + inputs[high]
            low += 1
            high -= 1
        end
    end
    sum(extrema(@view inputs[low:high]))
end

@btime solution($inputs, $solution_part_1)