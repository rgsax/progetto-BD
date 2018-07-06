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
    out.open(get_date() + "query_dipendente.sql");
    out<<"INSERT INTO DIPENDENTE VALUES\n";
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

    cout<<"cognome: ";
    getline(cin, value);
    tuple += "'" + value + "'" + ", ";

    cout<<"eta: ";
    cin>>value;
    tuple += value + ", ";

    cout<<"sesso: ";
    cin>>value;
    tuple += "'" + value + "'" + ", ";

    cout<<"num figli: ";
    cin>>value;
    tuple += value + ", ";

    cout<<"stato civile: ";
    cin>>value;
    tuple += "'" + value + "'" + ", ";

    cout<<"indirizzo: ";
    cin.ignore();
    getline(cin, value);
    tuple += "'" + value + "'" + ", ";

    cout<<"telefono: ";
    cin>>value;
    tuple += "'" + value + "'" + ", ";

    cout<<"codice_fiscale: ";
    cin>>value;
    tuple += "'" + value + "'" + ")";

    out<<tuple;
}