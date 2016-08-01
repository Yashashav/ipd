#include "bit_io.h"
#include "common.h"

#include <iostream>
#include <cstdio>

// These are the default files to read from and write to when no
// command-line arguments are given:
#define DEFAULT_INFILE  "hamlet.txt.huff"
#define DEFAULT_OUTFILE "hamlet.txt.puff"

using namespace ipd;
using namespace std;

void decode(bifstream& in, ofstream& out);

int main(int argc, const char *argv[])
{
    const char *infile, *outfile;

    get_file_names(argc, argv, infile, outfile,
                   DEFAULT_INFILE, DEFAULT_OUTFILE);

    bifstream in(infile);
    assert_good(in, argv);

    ofstream out(outfile);
    assert_good(out, argv);

    decode(in, out);
}

void decode(bifstream& in, ofstream& out)
{
    char c;

    while (in.read_bits(c, 7)) {
        out << c;
    }
}
