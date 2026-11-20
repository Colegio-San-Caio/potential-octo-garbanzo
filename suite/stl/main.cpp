// main.cpp - the KDP profile with the C++ standard library (STL): string, map, vector, algorithm.
#include <algorithm>
#include <cctype>
#include <iostream>
#include <map>
#include <string>
#include <vector>

int main()
{
    const std::string id = "KDPMember:KL5UQ4f48673352";
    const std::string prefix = "KDPMember:";
    const std::string code = id.compare(0, prefix.size(), prefix) == 0 ? id.substr(prefix.size()) : id;

    const std::map<std::string, std::string> profile = {
        {"Nickname", id}, {"Code", code}, {"Role", "Member"}, {"Points", "1"}};

    std::vector<std::string> order = {"Nickname", "Code", "Role", "Points"};
    std::cout << "=== KDP Forum Profile ===\n";
    for (const auto &key : order) {
        std::string label = key + std::string(8 - key.size(), ' ');
        std::cout << label << " : " << profile.at(key) << "\n";
    }
    std::cout << "(" << std::count_if(code.begin(), code.end(), [](char c) { return std::isdigit((unsigned char)c) != 0; })
              << " digits in the code)\n";
    return 0;
}
