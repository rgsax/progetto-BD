#include <fstream>
#include <iostream>
#include <chrono>
#include <iomanip>
#include <sstream>
#include <cstdlib>
#include <ctime>

using namespace std;

ofstream out;

inline void line_in();
inline string get_date();

int main(){
    srand(time(0));
    out.open(get_date() + "query_prodotto.sql");
    out<<"INSERT INTO PRODOTTO VALUES\n";
    char continua = 's';
    do {
        line_in();
        cout<<"continue?(s/n) ";
        cin>>continua;
        if(continua != 'n')
            out<<",\n";
        cin.ignore();
    }while(continua != 'n');
    out<<";";
}

string get_date() {
    stringstream s;
    auto now = chrono::system_clock::now();
    auto in_time_t = chrono::system_clock::to_time_t(now);
    s<<put_time(std::localtime(&in_time_t), "%Y-%m-%d-%H%M%S");
    return s.str();
}

void line_in() {
    string tuple = "(" + to_string(rand() % 256 + 1) + ", ";
    string value;

    cout<<"nome: ";
    getline(cin, value);
    tuple += "'" + value + "'" + ", ";

    cout<<"descrizione: ";
    getline(cin, value);
    tuple += (value != "null" ? "'" : "") + value + (value != "null" ? "'" : "") + ", ";

    cout<<"eta minima: ";
    cin>>value;
    tuple += value + ", ";

    cout<<"taglia: ";
    cin>>value;
    tuple += value + ", ";

    cout<<"materiale: ";
    cin>>value;
    tuple += (value != "null" ? "'" : "") + value + (value != "null" ? "'" : "") + ", ";

    cout<<"subcategoria: ";
    cin>>value;
    tuple += value + ")";

    out<<tuple;
}