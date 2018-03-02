#include<iostream>
using namespace std;
int main(){
	int num;
	cout<<"请输入一个数字：";
	cin>>num;
	//条件运算符 条件表达式 ？ 程序语句1：程序语句2; 
	num%2==0 ? cout<<num<<"为偶数"<<endl:cout<<num<<"为奇数"<<endl;
	system("pause");
	return 0; 
} 
