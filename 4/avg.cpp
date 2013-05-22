#include<iostream>
#include<algorithm>
using namespace std;

class Average
{
private:
	double sum;
	int N;
public:
	Average(int i = 0): sum(i){}
	void operator() (int i)
	{
		sum += i;
		N++;
	}
	int getAverage()
	{
		return sum / N;
	}
};

int main()
{
	int myArray[] = {5, 1, 27, 29, 17, 0, 15, 92};
	const int N = sizeof(myArray) / sizeof(int);

	const int* begin = myArray;
	const int* end = myArray + N;

	Average avg;

	avg = for_each(begin, end, avg);
	cout << "Average is: " << avg.getAverage() << endl;

	return 0;
}
