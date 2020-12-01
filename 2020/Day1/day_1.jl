using DelimitedFiles

const TARGET = 2020
path = joinpath(@__DIR__,"2020","Day1","datas","input.txt")

create_map(data) = Dict(d => i for (i, d) ∈ enumerate(data))

function find_idx(data, hash)
    for (i, d) ∈ enumerate(data)
        diff = TARGET - d
        if haskey(hash, diff)
            return (hash[diff], i)
        end
    end
end

compute_expense(data,idx_tuple) = data[idx_tuple[1]] * data[idx_tuple[2]]

data = readdlm(path, '\n', Int)
hash = create_map(data)

# Part 1
idx = find_idx(data, hash)
result = compute_expense(data, idx)

# Part 2

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

idx3 = find_idx_3(data,hash)
result2 = compute_expense_3(data,idx3)