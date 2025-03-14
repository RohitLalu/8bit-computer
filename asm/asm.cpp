#include <iostream>
#include <fstream>
#include <unordered_map>
#include <sstream>

void processLine(const std::string& line, const std::unordered_map<std::string, int>& inst) {
    std::string trimmed_line = line;
    
    // Remove leading and trailing whitespace
    size_t first = trimmed_line.find_first_not_of(" \t");
    size_t last = trimmed_line.find_last_not_of(" \t");
    if (first == std::string::npos || last == std::string::npos) return;
    trimmed_line = trimmed_line.substr(first, last - first + 1);

    // Ignore empty lines or comments
    if (trimmed_line.empty() || trimmed_line[0] == '#') return;

    // Tokenize the line
    std::istringstream iss(trimmed_line);
    std::string keyword;
    iss >> keyword;

    auto it = inst.find(keyword);
    if (it != inst.end()) {
        std::cout << std::hex << "0x" << it->second << std::endl;
    } else {
        std::cerr << "Warning: Unknown instruction '" << keyword << "' ignored." << std::endl;
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: ./assembler <assembly_file>" << std::endl;
        return 1;
    }

    std::string assembly_file = argv[1];

    std::unordered_map<std::string, int> inst = {
        {"nop", 0x00},
        {"call", 0b00000001},
        // Add more instructions as needed
    };

    std::ifstream file(assembly_file);
    if (!file) {
        std::cerr << "Error: File '" << assembly_file << "' not found." << std::endl;
        return 1;
    }

    std::string line;
    while (std::getline(file, line)) {
        processLine(line, inst);
    }

    return 0;
}
