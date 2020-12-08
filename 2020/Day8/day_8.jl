using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = readlines(path)

inputs = map(inputs) do x
    op, arg = split(x)
    Symbol(op), parse(Int, arg)
end

# Part 1
function part_1(inputs)
    acc = 0
    i = 1
    seen = BitSet()
    n = length(inputs) 
    while i ≤ n && i ∉ seen
        push!(seen, i)
        @inbounds op, val = inputs[i]
        if op == :acc
            acc += val
            i += 1
        elseif op == :jmp
            i += val
        else
            i += 1
        end
    end
    i <= n, acc
end

@btime part_1($inputs)

# Part 2
function part_2(inputs)
    @inbounds @simd for i in eachindex(inputs)
        op, arg = inputs[i]
        if op ∈ (:jmp, :nop)
            inputs[i] = (op == :jmp ? :nop : :jmp, arg)
            (inf_cond, acc) = part_1(inputs)
            !inf_cond && return acc
            inputs[i] = (op, arg)
        end
    end
end

@btime part_2($inputs)