function total_size(path, tree)
    s = 0
    for (k, v) in tree
        if startswith(k, path)
            s += sum(v)
        end
    end
    return s
end

function parse(input)
    tree = Dict{String,Vector{Integer}}()
    cwd = []  # current working directory
    for line in input
        if startswith(line, raw"$ ")  # command
            if startswith(line[3:end], "cd")  # change directory
                if line[6:end] == ".."  # move out
                    pop!(cwd)
                else  # move in
                    push!(cwd, line[6:end])
                    tree[abspath(cwd...)] = []
                end
            end
        else  # contents (file or directory)
            size, _ = split(line)
            if size != "dir"  # add file size
                push!(tree[abspath(cwd...)], Base.parse(Int, String(size)))
            end
        end
    end
    return Dict(k => total_size(k, tree) for (k, v) in tree)
end
commands = readlines("julia/resources/no_space_left.txt")

parsed_commands = parse(commands)

function part1(input)
    total = 0
    for v in values(input)
        if v <= 100000
            total += v
        end
    end
    return total
end

function part2(input)
    free_size = 70000000
    free = free_size - parsed_commands["/"]
    for v in values(input)
        if v >= (30000000 - free) && (v < free_size)
            free_size = v
        end
    end
    return free_size
end

parsed_commands = parse(commands)

part1_sum = part1(parsed_commands)
part2_free_size = part2(parsed_commands)
println(part1_sum)
println(part2_free_size)
