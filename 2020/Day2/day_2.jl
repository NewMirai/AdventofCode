using BenchmarkTools
path = joinpath(@__DIR__,"2020","Day2","datas","input.txt")

function solution_part_1(path)
    sums = 0
    for line in eachline(path)
        policy,password = split(line,':')
        range, c= split(policy)
        low_range,high_range = parse.(UInt8,split(range,'-'))
        counts = count(c,password)
        if counts >= low_range && counts <= high_range
            sums+=1
        end
    end
    sums
end

@btime solution_part_1($path)

sums2 = 0
for line in eachline(path)
    policy,password = split(line,':')
    range, (c,)= split(policy)
    low_pos,high_pos = parse.(UInt8,split(range,'-'))
    println(low_pos,high_pos)
end
sums2