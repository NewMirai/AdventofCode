using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = parse.(Int, readlines(path))

# Part 1
function part_1(inputs::Array{Int,1})::Array{Int,1}
    sort!(inputs)
    start_jolt = 0
    diffs::Array{Int,1} = []
    while start_jolt < max(inputs...)
        range_lookup = (start_jolt .+ collect([1:3]...))
        idx_choice = findfirst(x -> x ∈ range_lookup, inputs)
        diff = inputs[idx_choice] - start_jolt
        push!(diffs, diff)
        start_jolt = inputs[idx_choice]
    end
    push!(diffs, 3)
end

diffs = part_1(inputs)
counts = map(unique(diffs)) do x
    count(==(x), diffs)
end
prod(counts)

# Part 2

function part_2(inputs::Array{Int,1})::BigInt
    sort!(inputs)
    inputs = vcat(0, inputs, max(inputs...) + 3)
    n = inputs[end]
    dp = zeros(BigInt, n)
    dp[1] = 1
    dp[2] = 2
    dp[3] = 4 
    @inbounds for i ∈ 4:n
        i ∉ inputs && continue
        dp[i] += dp[i - 1] + dp[i - 2] + dp[i - 3]
    end
    dp[n]
end

@btime part_2(inputs)
