library(dplyr)

instructions <- read.delim2("R/resources/instructions.txt",
header = FALSE, sep = " ")

instruction_cycle <- 1
x <- 1
cycles_values <- array()
values <- array()

for (i in seq_len(nrow(instructions))) {
    instruction <- toString(instructions[i, "V1"])
    value <- as.integer(instructions[i, "V2"])
    values <- append(values, x)
    if (instruction == "addx") {
        values <- append(values, x)

        for (c in 1:2) {
            if (instruction_cycle == 20 ||
                instruction_cycle == 60 ||
                instruction_cycle == 100 ||
                instruction_cycle == 140 ||
                instruction_cycle == 180 ||
                instruction_cycle == 220) {
                cycles_values <- append(cycles_values, x * instruction_cycle)
            }
            if (c == 1) {
                instruction_cycle <- instruction_cycle + 1
            } else {
                x <- x + value
            }
        }
    } else {
        if (instruction_cycle == 20 ||
                instruction_cycle == 60 ||
                instruction_cycle == 100 ||
                instruction_cycle == 140 ||
                instruction_cycle == 180 ||
                instruction_cycle == 220) {
                    cycles_values <-
                        append(cycles_values, x * instruction_cycle)
            }
    }
    instruction_cycle <- instruction_cycle + 1
}

sum_cycles <- 0
for (i in cycles_values) {
    if (!is.na(i)) {
        sum_cycles <- sum_cycles + i
    }
}
print(sum_cycles)

# PART_TWO
x <- 1
first <- TRUE
pixels <- ""
for (y in 0:5) {
    for (x in 0:39) {
        v <- values[y * 40 + x + 2]
        if (abs(v - x) <= 1) {
            pixels <- paste(pixels, "#")
        } else {
            pixels <- paste(pixels, " ")
        }
    }
    print(pixels)
    pixels <- ""
}