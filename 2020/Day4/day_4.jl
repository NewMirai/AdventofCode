using BenchmarkTools

path = joinpath(@__DIR__, "2020", "Day4", "datas", "input.txt")
inputs = open(f -> read(f, String), path)
const set_required = Set(["byr","iyr","eyr","hgt","hcl","ecl","pid"])
passeports = split.(split(inputs, "\n\n"), r"(\n|\s)")

function valid_passport(passport)
    issubset(set_required, Set([k for (k, v) in split.(passport, ':')]))
end

get_match_result(x,g=1) = (filter(!isnothing, x) |> first).captures[g]

function valid_passport_2(passport)
    byr_match = match.(r"byr:(\d{4})", passport)
    byr_cond = false
    if any(!isnothing, byr_match) && 1920 <= parse(Int, get_match_result(byr_match)) <= 2002
        byr_cond = true
    end

    iyr_match = match.(r"iyr:(\d{4})", passport)
    iyr_cond = false
    if any(!isnothing, iyr_match) && 2010 <= parse(Int, get_match_result(iyr_match)) <= 2020
        iyr_cond = true
    end

    eyr_match = match.(r"eyr:(\d{4})", passport)
    eyr_cond = false
    if any(!isnothing, eyr_match) && 2020 <= parse(Int, get_match_result(eyr_match)) <= 2030
        eyr_cond = true
    end

    hgt_match = match.(r"hgt:(1([5-8][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in)\b", passport)
    hgt_cond = any(!isnothing, hgt_match)

    hcl_match = match.(r"hcl:(#[\da-f]{6})\b", passport)
    hcl_cond = any(!isnothing, hcl_match)

    ecl_match = match.(r"ecl:(amb|blu|brn|gry|grn|hzl|oth)\b", passport)
    ecl_cond = any(!isnothing, ecl_match)

    pid_match = match.(r"pid:(\d{9})\b", passport)
    pid_cond = any(!isnothing, pid_match)
    
    all([byr_cond,iyr_cond,eyr_cond,hgt_cond,hcl_cond,ecl_cond,pid_cond])
end

# Part 1
@btime mapreduce(valid_passport, +, passeports)

# Part 2
passeports_2 = passeports[map(valid_passport, passeports)]
@btime mapreduce(valid_passport_2, +, passeports_2)