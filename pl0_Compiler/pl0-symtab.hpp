#include <map>
#include <vector>
#include <string>
using namespace std;

enum {st_var = 1, st_const = 2, st_proc = 4};

class symtab_entry{
	public:
		symtab_entry(const int = -1, const int = -1);
		int type;	// Art des Eintrags
		int val;	// Wert (z.B. procnr)
};

class symtab {
	public:
		symtab ();
		void level_up();
		void level_down();
		int insert(const string name, const int typ, const int value);
		int lookup(string name, int type, int & l, int & value);
		void print();
	private:
		vector< map<string,symtab_entry> > content;
};
