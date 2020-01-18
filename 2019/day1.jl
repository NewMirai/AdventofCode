println("-"^10,"DAY 1","-"^10)
# Read all lines of the files and convert to int
f = readlines("2019/datas/input_day_1.txt")
masses = parse.(Int64,f)
println("Data loaded...")

# Part 1
println("-"^3,"PART 1","-"^3)

function fuel_required(mass::Int64)::Int64
    res = floor(Int,(mass/3)- 2)
    return res  
end

# Now computing sum of fuel required
Total_sum = sum(fuel_required,masses)
println("Sum of fuel required: ",Total_sum)

# Part 2
println("-"^3,"PART 2","-"^3)

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