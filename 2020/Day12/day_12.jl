using BenchmarkTools
using Luxor,Colors

path = joinpath(@__DIR__, "datas", "input.txt")
inputs = readlines(path)

mutable struct Instruction
    action::String
    units::Int
end

function parse_inputs(inputs::Array{String,1})::Array{Instruction,1}
    instructions::Array{Instruction,1} = map(inputs) do x
        matches = match(r"([a-zA-Z]{1})(\d+)", x)
        Instruction(matches.captures[1], parse(Int, matches.captures[2]))
    end
    instructions
end

function part_1(inputs)
    inputs = parse_inputs(inputs)
    position = complex(0,0)
    direction = complex(1,0)
    for instruction ∈ inputs
        instruction.action == "N" && ( position += instruction.units * im )
        instruction.action == "S" && ( position -= instruction.units * im )
        instruction.action == "E" && ( position += instruction.units )
        instruction.action == "W" && ( position -= instruction.units )
        instruction.action == "F" && ( position += direction * instruction.units )
        instruction.action == "L" && ( direction *= im^(instruction.units ÷ 90) )
        instruction.action == "R" && ( direction *= (-im)^(instruction.units ÷ 90) )
    end
    abs(real(position)) + abs(imag(position))
end

@btime part_1(inputs)

function part_2(inputs)
    inputs = parse_inputs(inputs)
    waypoint = complex(10,1)
    position = complex(0,0)
    direction = complex(1,0)
    for instruction ∈ inputs
        instruction.action == "N" && ( waypoint += instruction.units * im )
        instruction.action == "S" && ( waypoint -= instruction.units * im )
        instruction.action == "E" && ( waypoint += instruction.units )
        instruction.action == "W" && ( waypoint -= instruction.units )
        instruction.action == "F" && ( position += waypoint * instruction.units )
        instruction.action == "L" && ( waypoint *= im^(instruction.units ÷ 90) )
        instruction.action == "R" && ( waypoint *= (-im)^(instruction.units ÷ 90) )
    end
    abs(real(position)) + abs(imag(position))
end

@btime part_2(inputs)