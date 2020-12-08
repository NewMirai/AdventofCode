using BenchmarkTools

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = readlines(path)

struct Bag
    color::String
    contains::Dict{String,Int}
end

rules = map(inputs) do x
    color, contained_bags = split(x, "contain")
    color = match(r"([a-z A-Z]+)\sbags", color).captures[1]
    contained_bags_match = eachmatch(r"(\d+)\s([a-z\s]+)\s(?:bag|bags)", contained_bags)
    contained_bag_dict = Dict(match.captures[2] => parse(Int, match.captures[1]) for match ∈ contained_bags_match)
    Bag(color, contained_bag_dict)
end

# Part 1
function find_shiny_bags(rules::Array{Bag,1})
    check_queue = ["shiny gold"]
    results = Set{String}()
    while !isempty(check_queue)
        color = pop!(check_queue)
        for rule ∈ rules
            if color ∈ [k for k ∈ keys(rule.contains)]
                push!(results, rule.color)
                if rule.color ∉ check_queue
                    push!(check_queue, rule.color)
                end
            end
        end
    end
    results
end

@btime length(find_shiny_bags(rules))

# Part 2
function count_bags_deeply(rules::Array{Bag,1}, color::String)::Int
    rec_rules = Dict(bag.color => bag for bag ∈ rules)
    num_bags = 0
    queue = [(color, 1)]
    while !isempty(queue)
        new_color, m = pop!(queue)
        bag = rec_rules[new_color]
        for (child_bag, c) ∈ bag.contains
            num_bags += m * c
            push!(queue, (child_bag, c * m))
        end
    end
    num_bags
end

@btime count_bags_deeply(rules, "shiny gold")