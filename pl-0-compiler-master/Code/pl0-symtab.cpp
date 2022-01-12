#include "pl0-symtab.hpp"
#include <map>
#include <string>
#include <iostream>
using namespace std;

symtab_entry::symtab_entry(const int type_,
	const int val_) {
	type = type_, val = val_;
}

symtab::symtab () {
}

int varCount;

void symtab::level_up() {
	cerr << ">Symtab-level-up\n";
	map<string,symtab_entry> tmp;
	content.push_back(tmp);
	varCount = 0;
}

void symtab::level_down() {
	int level = content.size() - 1;
	cerr << ">Symtab-level-down " << level << ":" << content.size() << "\n";
	content[level].clear();
	content.pop_back();
}

int symtab::insert(const string name, const int typ, const int value){
	int level = content.size() - 1, r = -1;
	int val = value;
	if (val == -1){
		val = varCount++;
	}
	if (content[level].find(name) == content[level].end()) {
		content[level][name] = symtab_entry(typ, val);
		cerr << ">Symtab-insert '" << name << "':" <<
			content[level][name].type <<
			 " |value: " << val << endl;
		r = 0;
	}
	return r;
}

int symtab::lookup(string name, int type, int * l,
	int * value) {
	int level = content.size() - 1;
	int i = level+1, rc = 0;
	cerr << ">Symtab-lookup '" << name <<
		"' (Typ " << type << ")" << endl;
	*l = -1;
	while (--i >= 0 && content[i].find(name) == content[i].end());
	if (i >= 0)
		if (content[i][name].type & type)
			*l = level - i,
				*value = content[i][name].val;
		else {
			rc = -1; // Falscher Typ
			cerr << ">>> Falscher Typ\n";}
	else {
		rc = -2; // Nicht gefunden
		cerr << ">>> Nicht gefunden\n";}
	return rc;
}

void symtab::print(){
	int level = content.size() - 1;
	map<string,symtab_entry> ::iterator pos;
	cerr << ">>>>>Akt. Level: "<<  level << endl;
	for (int i = 0; i <= level; i++) {
		cerr << ">>>>>Level " << i << ": Hoehe " <<
			content[i].size() << endl;
		pos = content[i].begin();
		for(pos = content[i].begin();
			pos != content[i].end();
			++pos){
			cerr << ">>>>>Key: " << (*pos).first << " " <<
				(*pos).second.type << endl;
		}
	}
}
