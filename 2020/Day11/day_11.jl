using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = readlines(path)

# L means seat is empty
# means seat is occupied
# .  means the floor

function parse_grid(inputs)
    hcat(collect.(inputs)...) |> permutedims
end

function get_adj_pos(ci::CartesianIndex{2})::Array{CartesianIndex{2},1}
    [ci + CartesianIndex(1, 0),
    ci + CartesianIndex(1, 1),
    ci + CartesianIndex(1, -1),
    ci + CartesianIndex(-1, 0),
    ci + CartesianIndex(-1, -1),
    ci + CartesianIndex(-1, 1),
    ci + CartesianIndex(0, 1),
    ci + CartesianIndex(0, -1),
    ]
end

function next_step(pos::CartesianIndex{2}, grid::Array{Char,2})::Char
    neighbours = get_adj_pos(pos)
    neighbours = neighbours[[checkbounds(Bool, grid, neighbour) for neighbour in neighbours]]
    count_hash = count(==('#'), @view grid[neighbours])
    grid_pos = grid[pos]
    if grid_pos == 'L' && count_hash == 0
        return '#'
    elseif grid_pos == '#' && count_hash >= 4
        return 'L' 
    else
        return grid_pos
    end
end

function step(grid::Array{Char,2})
    new_grid = deepcopy(grid)
    for i in CartesianIndices(grid)
        new_grid[i] = next_step(i, grid)
    end
    new_grid
end

grid = parse_grid(inputs)

function part_1(grid::Array{Char,2})
    while true
        new_grid = step(grid)
        new_grid == grid && break
        grid = new_grid
    end
    count(==('#'), grid)
end

@btime part_1(grid)

# Part 2

function find_first_seat(grid::Array{Char,2}, pos::CartesianIndex{2}, d)
    while true
        pos += d
        if checkbounds(Bool, grid, pos)
            grid_pos = grid[pos]
            if grid_pos == 'L' || grid_pos == '#'
                return grid_pos
            end
        else
            return '.'
        end
    end
end

function next_step2(pos::CartesianIndex{2}, grid::Array{Char,2})::Char
    neighbours = get_adj_pos(pos)
    first_seats_find = [find_first_seat(grid, pos, d - pos) for d in neighbours]
    grid_pos = grid[pos]
    count_hash = count(==('#'), first_seats_find)
    if grid_pos == 'L' && count_hash == 0
        return '#'
    elseif grid_pos == '#' && count_hash >= 5
        return 'L' 
    else
        return grid_pos
    end
end

function step2(grid::Array{Char,2})
    new_grid = deepcopy(grid)
    for i in CartesianIndices(grid)
        new_grid[i] = next_step2(i, grid)
    end
    new_grid
end

function part_2(grid::Array{Char,2})
    while true
        new_grid = step2(grid)
        new_grid == grid && break
        grid = new_grid
    end
    count(==('#'), grid)
end

@btime part_2(grid)