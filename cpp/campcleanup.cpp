#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;

struct elfSectionsStruct
{
    int first_section;
    int last_section;
};

struct Row
{
    elfSectionsStruct first_elf;
    elfSectionsStruct last_elf;
};

vector<string>
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

int main()
{
    vector<string> elfSections;
    string line;

    ifstream MyReadFile("camp_cleanup.txt");

    while (getline(MyReadFile, line))
    {
        elfSections.push_back(line);
    }
    MyReadFile.close();

    int sum = 0;
    int overlapping = 0;

    for (string two_sections : elfSections)
    {
        vector<string> range = split(two_sections, ",");
        vector<elfSectionsStruct> elfs_construct;
        for (string sections : range)
        {
            vector<string> section = split(sections, "-");
            elfSectionsStruct current_elf;
            current_elf.first_section = stoi(section[0]);
            current_elf.last_section = stoi(section[1]);
            elfs_construct.push_back(current_elf);
        }
        elfSectionsStruct elf_one = elfs_construct[0];
        elfSectionsStruct elf_two = elfs_construct[1];
        // Part One
        if (elf_one.first_section <= elf_two.first_section && elf_one.last_section >= elf_two.last_section)
        {
            sum++;
        }
        else if (elf_two.first_section <= elf_one.first_section && elf_two.last_section >= elf_one.last_section)
        {
            sum++;
        }

        // Part Two
        if (elf_one.first_section <= elf_two.first_section && elf_one.last_section >= elf_two.first_section)
        {
            overlapping++;
        }
        else if (elf_two.first_section <= elf_one.first_section && elf_two.last_section >= elf_one.first_section)
        {
            overlapping++;
        }
    }

    cout << "sum: " << sum << endl;
    cout << "overlapping: " << overlapping << endl;
    return 0;
}