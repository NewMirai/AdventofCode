# Read all lines of the files and convert to int
f = readlines("2019/datas/input_day_1.txt")
masses = parse.(Int64,f)

function fuel_required(mass::Int64)::Int64
    res = floor(Int,(mass/3)- 2)
    return res  
end

# Now computing sum of fuel required
Total_sum = sum(fuel_required,masses)

println("Sum of fuel required: ",Total_sum)
