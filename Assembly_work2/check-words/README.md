# Task 3 - Word sorting (25p)

For this task you will have to separate a text into words by some delimiters and then sort these words using the qsort function.
The sorting will be done first according to the length of the words and in case of equality it will be sorted lexicographically.

You will need to implement 2 functions with the signatures `void get_words(char *s, char **words, int number_of_words);` and `void sort(char **words, int number_of_words, int size);` from the `sort-words.asm` file.


The header of the first function is:
```
void get_words(char *s, char **words, int number_of_words);
```

The meaning of the arguments is:
   * **s** the text from which we extract the words
   * **words** the vector of strings in which the found words are saved
   * **number_of_words** the number of words

Attention, the function *does* not return anything, the words are saved in the words vector!

The header of the second function is:
```
void sort(char **words, int number_of_words, int size);
```

The meaning of the arguments is:
   * **words** the vector of words to be sorted
   * **number_of_words** the number of words
   * **size** size of a word

Attention, the function *does* not return anything, the sorting is done in-place!

## Specifications:
- the length of the text is less than 1000;
- the vector of words will have a maximum of 100 words of 100 characters each;
- the delimiters you have to take into account are: " ,.\n"
- you are not allowed to use any sorting method other than qsort.
If you use another method, the score on this task will be lost.

## Example
```
number_of_words: 9
s: "Ana has 27 apples and 32 pears."
after the call get_words: words = ["Ana", "are", "27", "de", "apples", "si", "32", "de", "pears"]
after the sort call: words = ["27", "32", "de", "de", "si", "Ana", "are", "apples", "peres"]
```
