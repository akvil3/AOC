# part one
function calculate_game_part_one(home::String, opponent::String)
    if opponent == "A"
        if home == "X"
            4
        elseif home == "Y"
            8
        elseif home == "Z"
            3
        end
    elseif opponent == "B"
        if home == "X"
            1
        elseif home == "Y"
            5
        elseif home == "Z"
            9
        end
    elseif opponent == "C"
        if home == "X"
            7
        elseif home == "Y"
            2
        elseif home == "Z"
            6
        end
    end
end

# part two
function calculate_game_part_two(home::String, opponent::String)
    if home == "X"
        if opponent == "A"
            3
        elseif opponent == "B"
            1
        elseif opponent == "C"
            2
        end
    elseif home == "Y"
        if opponent == "A"
            4
        elseif opponent == "B"
            5
        elseif opponent == "C"
            6
        end
    elseif home == "Z"
        if opponent == "A"
            8
        elseif opponent == "B"
            9
        elseif opponent == "C"
            7
        end
    end
end

function get_points(round::String, part::Int64)
    splitted = split(round, " ")
    opponent = String(splitted[1])
    home = String(splitted[2])
    if part == 1
        calculate_game_part_one(home, opponent)
    else
        calculate_game_part_two(home, opponent)
    end
end

function get_total(sum_points::Array{Int64})
    sum = 0
    for points in sum_points
        sum += points
    end
    sum
end

games = readlines("game.txt")

sum_points_part_one = Array{Int64}(map((game) -> get_points(game, 1), games))
sum_points_part_two = Array{Int64}(map((game) -> get_points(game, 2), games))

println(get_total(sum_points_part_one))
println(get_total(sum_points_part_two))
