# Task 1 - Reversing vowels

The purpose of this task is to use only the stack, through push and pop operations,
to work with memory.

---

After the success in Baku, Ferrari realized that encrypted messages have
worked, and Mercedes had no chance against them. But unfortunately
Red Bull realized very quickly what they wanted to do, so after they passed
qualifications, they had no chance against the Austrian team.

But the people from Ferrari realized that they cannot surpass their intelligence
those from Red Bull, so they thought of a simpler way to encrypt
a message. They thought to take every vowel from their message, and display them
only on them in reverse order. So, when they ever want to talk
about Red Bull, all he will have to do is display the message:

c
rud bell // "red bull" with the vowels written in reverse order
```

That way, Red Bull will never know I'm talking about them. Unfortunately this method
it is not as efficient if we want to talk about Mercedes, but we have the other one
encryption mode, so they should come out.

To implement our function, we must start from the received string ca
parameter, and make all the necessary changes. **No** you are allowed to define yourself
another vector to keep a copy of the string or to store the vowels.

c
void reverse_vowels(char *string);
```

## Examples

These strings will contain only lowercase letters of the English alphabet and whitespace

```
"hello" -> "hello"
"max verstappen" -> "mex varsteppan"
```

**Attention!** You are not allowed to use the instructions from the mov family (mov, cmov,
stos, lods, etc), leave and enter. All transfer operations from and to memory
/ registers must be made using push and pop. You can use external functions.

