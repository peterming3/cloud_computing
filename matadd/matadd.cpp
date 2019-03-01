#include <iostream>
#include <string>
using namespace std;
int main(int argc, char *argv[])
{
  if(argc<2){
    cout << "Usage: N";
    return 0;
  }
  int N=stoi(argv[1]);

  int* matrix = new int*[N*N];


  for(int i=0;i<=N*N;i=i+N/10){
	matrix[i]=10;
  }

  delete matrix;

}

