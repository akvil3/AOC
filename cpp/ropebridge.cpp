#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;

struct Coordinates
{
    int x;
    int y;
};

struct Motions
{
    string direction;
    int steps;
};

template <typename T>
std::pair<bool, int> findInVector(const std::vector<T> &vecOfElements, const T &element)
{
    std::pair<bool, int> result;
    // Find given element in vector
    auto it = std::find(vecOfElements.begin(), vecOfElements.end(), element);
    if (it != vecOfElements.end())
    {
        result.second = distance(vecOfElements.begin(), it);
        result.first = true;
    }
    else
    {
        result.first = false;
        result.second = -1;
    }
    return result;
}

static vector<string>
split(string s, string delimiter)
{
    size_t pos_start = 0, pos_end, delimiter_len = delimiter.length();
    string token;
    vector<string> result;

    while ((pos_end = s.find(delimiter, pos_start)) != string::npos)
    {
        token = s.substr(pos_start, pos_end - pos_start);
        pos_start = pos_end + delimiter_len;
        result.push_back(token);
    }

    result.push_back(s.substr(pos_start));
    return result;
}

static void move_knot(Coordinates &head, string direction)
{
    if (direction == "R")
    {
        head.x += 1;
    }
    else if (direction == "L")
    {
        head.x -= 1;
    }
    else if (direction == "U")
    {
        head.y += 1;
    }
    else if (direction == "D")
    {
        head.y -= 1;
    }
}

Coordinates move_to_head(Coordinates head, Coordinates knot)
{
    Coordinates thisKnot = knot;
    if ((abs(head.x - thisKnot.x) > 1) || (abs(head.y - thisKnot.y) > 1))
    {
        if (head.x != thisKnot.x)
            thisKnot.x += (thisKnot.x < head.x ? 1 : -1);
        if (head.y != thisKnot.y)
            thisKnot.y += (thisKnot.y < head.y ? 1 : -1);
    }
    return thisKnot;
}

int main()
{
    vector<Coordinates> tails_coords;
    string line;

    Coordinates start;
    start.x = 0;
    start.y = 0;

    vector<Motions> motion_moves;

    ifstream MotionsFile("resources/ropebridge.txt");
    while (getline(MotionsFile, line))
    {
        ;
        vector<string> splitted_motion_line = split(line, " ");

        Motions motion;
        motion.direction = splitted_motion_line[0];
        motion.steps = stoi(splitted_motion_line[1]);
        motion_moves.push_back(motion);
    }
    MotionsFile.close();
    bool start_loop = true;
    for (Motions motions : motion_moves)
    {
        int i = 0;
        while (i < motions.steps)
        {
            if (start_loop)
            {
                move_knot(start, motions.direction);
                Coordinates new_knot = move_to_head(start, start);
                tails_coords.push_back(new_knot);
                start_loop = false;
            }
            else
            {
                move_knot(start, motions.direction);
                Coordinates new_knot = move_to_head(start, tails_coords.back());
                tails_coords.push_back(new_knot);
            }
            i++;
        }
    }

    // Part TWo
    Coordinates start_tails;
    start_tails.x = 0;
    start_tails.y = 0;
    vector<Coordinates> long_tails(10, start_tails);
    vector<Coordinates> empty_vec(1, start_tails);
    vector<vector<Coordinates> > all_tails(10, empty_vec);
    start_loop = true;
    for (Motions motions : motion_moves)
    {
        int i = 0;
        while (i < motions.steps)
        {
            cout << "Motion step: " << i << endl;
            int k = 1;
            move_knot(long_tails[0], motions.direction);
            while (k < 10)
            {
                Coordinates new_knot = move_to_head(long_tails[k - 1], long_tails[k]);
                long_tails[k] = new_knot;
                all_tails[k].push_back(new_knot);
                k++;
            }
            i++;
        }
    }

    vector<Coordinates> unique_coords;

    for (Coordinates coords_two : tails_coords)
    {
        bool present = false;
        for (Coordinates unique_coord : unique_coords)
        {
            if (coords_two.x == unique_coord.x && coords_two.y == unique_coord.y)
            {
                present = true;
            }
        }
        if (!present)
        {
            unique_coords.push_back(coords_two);
        }
    }

    vector<Coordinates> unique_coords_part_two;

    for (Coordinates coords : all_tails.back())
    {
        bool present = false;
        for (Coordinates unique_coord : unique_coords_part_two)
        {
            if (coords.x == unique_coord.x && coords.y == unique_coord.y)
            {
                present = true;
            }
        }
        if (!present)
        {
            unique_coords_part_two.push_back(coords);
        }
    }

    cout << "Tails positions: " << unique_coords.size() << endl;

    cout << "9th Tails positions: " << unique_coords_part_two.size() << endl;
    return 0;
}
