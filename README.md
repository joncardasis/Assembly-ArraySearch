# Assembly-ArraySearch
Simple Assembly (Intel x86) Array Input and Search Program

File: `windows32/arraySearch.asm`

## Description
An Intel x86 program which takes in a collection of positive integers into an array of doublewords (maximum of 10 elements) from user prompts, and then sequentially searches for values stored in the array.
To have an array of smaller than ten elements, a value of 0 or less can be entered. Valid search values are >= 0. The program returns the index in the array where the searched for element is found. If no element is found, an output states this.

## Dependancies
`io` - assembly/c for IO user input and display back to the user

## Screenshots
![Input Example](http://i.imgur.com/MRu475x.jpeg)

![Search Value](http://i.imgur.com/E4aNCuK.jpeg)

![Result Index](http://i.imgur.com/shnlati.jpeg)

![Continue Search Prompt](http://i.imgur.com/lhd3lqg.jpeg)

## General Algorithm
```
1) Data segment
	a) I will store a variable for the number of elements currently in an array
	b) I will create an array of size 10 with uninitialized values
	c) Three input prompts will be stored:
		i) Input prompt for inputting a number into the array
		ii) Input prompt for a search value
		iii) Input if the program should continue searching the array (more numbers to search for?)
	d) Three output prompts will be stored:
		i) Prompt stating the array is empty
		ii) Prompt stating the search value is not found
		iii) Prompt stating the search value is found
		iv) Prompt stating the search value is invalid
	e) Variable to store the current value to search for
	f) Count variable used for looping through the search array

2) Code segment
	a) Set number of elements to zero
	b) Get address of the array
	c) Prompt for and input number
	d) Loop while number >0 AND number of elements <= 10:
		i) Add 1 to the number of elements
		ii) Store the input number at address in array
		iii) Get address of next array element
		iv) Prompt for and input number
	e) If number of elements == 0
		i) Display array is empty prompt
		ii) Skip to end of the program. Do not search.
	f) Do search loop:
		i) Prompt for and input searchValue
		ii) If searchValue <= 0
			(1) Prompt user with invalid input
			(2) Jump back to beginning of search loop
		iii) Get array address
		iv) Set count to 1 0
		v) Loop forever:
			(1) If count > number of elements in the array
				(a) Display searchValue + “not in the array”
				(b) Exit forever loop
			(2)	If searchValue == current element in the array
				(a)	Display searchValue + “is element” + count
				(b)	Exit forever loop
			(3)	Add 1 to count
			(4)	Get address of next array element
		vi) Prompt for and obtain new response variable value
	g) If response is not ‘N’ or ‘n’ then do search loop again
		i) Get first character of string and compare ascii values to 'N’ and ‘n’
```

## License
Assembly-ArraySearch is available under the MIT license. See the LICENSE file for more info.
