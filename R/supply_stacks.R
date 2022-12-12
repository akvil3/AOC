library(rlist)
library(dplyr)

# Replace empty fields in txt file with [X] and check that there is only
# one space between each container
stacks_data <- read.delim2("R/resources/supply_stacks.txt", header = FALSE, sep = " ")
# The line where the first action is described
num_actions <- 0

# Loops throught the data frame and finds the line where
# the first action is described
for (i in 1:nrow(stacks_data)) {
    if (stacks_data[i, 1] == "move") {
        num_actions <- i
        break
    }
}

# DF for the containers ([Y], [M], etc.)
containers <- stacks_data[c(1:(num_actions - 4)), c(1:9)]
# DF for the actions ("move 1 from 2 to 8")
actions <- stacks_data[c(num_actions:nrow(stacks_data)), c(1:9)]

lists <- array()
# Format the data frame columns of containers to a list of containers lists
for (i in 1:ncol(containers)) {
    container <- containers[, i]
    container_list <- list.filter(container, . != "[X]")
    lists <- append(lists, list(container_list))
}

# PART I (Comment one of the parts)
for (i in 1:nrow(actions)) {
    print(actions[i, ])
    num_containers <- as.integer(actions[i, 2])
    home <- as.integer(actions[i, 4])
    target <- as.integer(actions[i, 6])
    for (i in 1:num_containers) {
        el <- lists[[home + 1]][1]
        lists[[home + 1]] <- lists[[home + 1]][-1]
        lists[[target + 1]] <- append(lists[[target + 1]], el, 0)
        print(el)
    }
}
#
print(lists)

# PART II ( Comment this if you want to run part one)
for (i in 1:nrow(actions)) {
    num_containers <- as.integer(actions[i, 2])
    home <- as.integer(actions[i, 4])
    target <- as.integer(actions[i, 6])
    for (i in num_containers:1) {
        el <- lists[[home + 1]][i]
        lists[[home + 1]] <- lists[[home + 1]][(-1 * i)]
        lists[[target + 1]] <- append(lists[[target + 1]], el, 0)
    }
}

print(lists)
