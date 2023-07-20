# Task 2 - Pwd (25p)

For this task, a function must be implemented that will receive as parameters a matrix of characters that will contain the names of `n' folders on which the linux cd command is given in the order in which they appear, the number of folders
(aka number of lines in the matrix) and output that will contain the resulting path.

"." will also be implemented. (current folder) and ".." (previous folder) as well
the name of a folder does not contain spaces.

The ".." behavior is similar to that in linux, so the output from
folders are created as long as there is space.

For the management of character strings it is mandatory to use the stack.

c
void pwd(char **directories, int n, char *output)
```

Example:

n = 5

directories =

```
man
folder1
.
folder2
..
folder3
```

```
output = /home/folder1/folder3
```

The behavior is as follows:

/home will be added, then /folder1 will be added, so: /home/folder1

It will find "." which refers to the current folder, so it remains:/home/folder1

Then folder2 is added, so /home/folder1/folder2.

You will find .., which refers to the previous folder, so it will exit from the current one resulting in: /home/folder1

Then folder3 is added, and the final result is: /home/folder1/folder3
