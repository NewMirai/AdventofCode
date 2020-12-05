using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = readlines(path)

function get_col(s)
    low = 0.0
    high = 7.0
    i = 1 
    while low != high && i <= length(s)
        if s[i] == 'R'
            low = mean([low,high]) |> ceil
        elseif s[i] == 'L'
            high = mean([low,high]) |> floor
        end
        i += 1
    end
    max(low, high)
end

function get_row(s)
    low = 0.0
    high = 127.0
    i = 1 
    while low != high && i <= length(s)
        if s[i] == 'B'
            low = mean([low,high]) |> ceil
        elseif s[i] == 'F'
            high = mean([low,high]) |> floor
        end
        i += 1
    end
    min(low, high)
end

function get_row_string_col_string(s)
    col = last(s, 3)
    row = first(s, 7)
    row, col
end

function get_id(board)
    row_s, col_s = get_row_string_col_string(board)
    get_row(row_s) * 8 + get_col(col_s)
end

function solution_part_1(inputs)
    mapreduce(get_id, max, inputs)
end

function solution_part_2(inputs)
    sorted_v = map(get_id, inputs) |> sort! 
    diff_v = sorted_v |> diff
    sorted_v[findfirst(isequal(2), diff_v)] + 1
end

# Part 1
@btime solution_part_1($inputs)
# Part 2 
@btime solution_part_2($inputs)