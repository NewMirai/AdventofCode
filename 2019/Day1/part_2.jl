# Read all lines of the files and convert to int
f = readlines("2019/datas/input_day_1.txt")
masses = parse.(Int64,f)

# Part 2

function fuel_required(mass::Int64)::Int64
    res = floor(Int,(mass/3)- 2)
    return res  
end

function rec_fuel(mass::Int64)::Int64
    total = 0
    fuel = fuel_required(mass)
    total += fuel
    while fuel_required(fuel) > 0
        fuel = fuel_required(fuel)
        total += fuel
    end
    return total
end

# Now computing the recursive sum of fuel required
Total_sum_2 = sum(rec_fuel,masses)
println("Sum of fuel required: ",Total_sum_2)