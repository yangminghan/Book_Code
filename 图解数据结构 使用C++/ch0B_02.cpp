#include<iostream>
using namespace std;
const double PI =3.1415926;
int main(void){
	cout<<"请输入圆的半径（厘米）"; //声明全局变量 
	int r;
	cin>>r;
	cout<<"半径="<<r<<"圆的面积为："<<r*r*PI<<"平方厘米"<<endl;
	system("pause");
	return 0;
}
