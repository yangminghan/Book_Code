#include<iostream>
using namespace std;
int main(){
	int num;
	cout<<"������һ�����֣�";
	cin>>num;
	//��������� �������ʽ �� �������1���������2; 
	num%2==0 ? cout<<num<<"Ϊż��"<<endl:cout<<num<<"Ϊ����"<<endl;
	system("pause");
	return 0; 
} 
