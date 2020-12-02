using BenchmarkTools
path = joinpath(@__DIR__, "2020", "Day2", "datas", "input.txt")

input = readlines(path)

function extract_line_info(line)
    # Regex FTW
    low, high, char, password = match(r"([0-9]*)-([0-9]*) ([a-z]): ([a-z]*)", line).captures
    parse(UInt16, low), parse(UInt16, high), only(collect(char)), password
end

function solution_part_1(line)
    low, high, char, password  = extract_line_info(line)
    low <= count(==(char), password) <= high
end

function solution_part_2(line)
    low, high, char, password  = extract_line_info(line)
    (password[low] == char) ⊻ (password[high] == char)
end

@btime count(solution_part_1, input)
@btime count(solution_part_2, input)