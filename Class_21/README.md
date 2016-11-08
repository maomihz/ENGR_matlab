# Activity 1

## Happy Birthday

> What happens if you forget to give it a value as input?

```
>> happy_birthday()
Not enough input arguments.
Error in happy_birthday (line 4)
    fprintf('Happy birthday, dear %s!\n', name);
```

> What happens if you give it a number as input?

```
>> happy_birthday(456)
Happy birthday to you!
Happy birthday to you!
Happy birthday, dear !
Happy birthday to you!
```
It does not always work as expected, sometimes the number is converted to string:
```
>> happy_birthday(21512512)
Happy birthday to you!
Happy birthday to you!
Happy birthday, dear 2.151251e+07!
Happy birthday to you!
```

> What happens if you give it two inputs?

```
>> happy_birthday(456,123)
Error using happy_birthday
Too many input arguments.
```

## Old MacDonald Had a Farm

*Script would be submitted separately*
