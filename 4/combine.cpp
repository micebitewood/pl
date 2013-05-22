#include<iostream>
#include<algorithm>
#include<iterator>
using namespace std;

typedef int (*BinaryFunction)(int, int);

template<typename ForwardIterator, typename OutputIterator>
void combine(ForwardIterator beginFirst, ForwardIterator endFirst, ForwardIterator beginSecond, BinaryFunction fun, OutputIterator output)
{
	ForwardIterator it2 = beginSecond;
	for(ForwardIterator it1 = beginFirst; it1 < endFirst; it1++)
	{
		*output++ = fun(*it1, *it2);
		it2++;
	}
}

int add(int a, int b)
{
	return a + b;
}

int main()
{
	ostream_iterator<int> out_it (cout, " ");
	int a[] = {1, 2, 3, 4, 5};
	int N = sizeof(a) / sizeof(int);
	int* beginFirst = a;
	int* endFirst = a + N;

	int b[] = {1, 2, 3, 4, 5, 1};
	int* beginSecond = b;

	combine(beginFirst, endFirst, beginSecond, add, out_it);

	return 0;
}
