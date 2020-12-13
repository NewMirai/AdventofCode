using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")

function parse_inputs(path)
    ts, list = readlines(path)
    buses = [(i - 1, parse(Int, b)) for (i, b) in enumerate(split(list, ',')) if b != "x"]
    return parse(Int, ts), buses
end

function part_1(path)
    ts, buses = parse_inputs(path)
    wait_time = [(b, b - mod(ts, b)) for b in last.(buses)]
    first.(wait_time)[argmin(last.(wait_time))] * minimum(last.(wait_time))
end
@btime part_1(path)

# Part 2
function part_2(path)
    _, buses = parse_inputs(path)
    bus_n = last.(buses)
    bus_dt = first.(buses)
    inc = bus_n[1]
    n = 0
    for (i, offset) ∈ zip(bus_n[2:end], bus_dt[2:end])
        while (n + offset) % i != 0
            n += inc
        end
        inc = lcm(inc, i)
    end
    n
end
part_2(path)