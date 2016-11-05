## Activity 2

The code to ask user input and display name and age:

```
% name_and_age.m

name = input('Type Your Name! ==> ','s');
age = input('Type your age!! ==> ');

fprintf('Howdy, %s! You are %d years old!!!\n', name, age);
```

Test run:

```
>> name_and_age
Type Your Name! ==> sean
Type your age!! ==> 123
Howdy, sean! You are 123 years old!!!
```

## Activity 3:

<u>***Understand the Problem***</u>

**Given:**

- Speed of sound in ft/sec
- Conversion between mile and feet

**Input:** Time elapsed between the flash and the sound of thunder

**Output:** Distance between you and the lightning strike (in miles)

<u>***Make a Plan***</u>

Pseudocode:

```
speedOfSound = 1100 ft/sec
feetToMile = 5280 ft

time = Time input by user in seconds

distanceInFeet = speedOfSound * time / feetToMile
distanceInMiles = distanceInFeet / feetToMile
```

<u>***Execute the Plan***</u>

 - Open Matlab and create a new script `lightning.m`
 - Copy in the pseudocode and comment it
 - Write in help document:

```
%LIGHTNING      computes the distance between you and a lightning strike
%   LIGHTNING   computes the distance between you and a lightning strike
%
%   LIGHTNING   overwrites these variables:
%       time - the time between seeing a lightning strike and hearing it
%       distanceInFeet - the total distance in feet
%       ditanceInMiles - the total distance in miles
%
%   LIGHTNING prompts the user to input values for time
%
%   Author: Xucheng Guo, 11/03/2016
```

 - Implement the algorithm

```
% lightning.m

% constants
SPEED_OF_SOUND = 1100;
FEET_TO_MILE = 5280;

% input
time = input('Type the time in seconds ==> ');

% processing
distanceInFeet = SPEED_OF_SOUND * time;
distanceInMiles = distanceInFeet / FEET_TO_MILE;

% output
fprintf('Distance to the lightning strike is: %.2f miles\n', distanceInMiles);
```

<u>***Test the Code***</u>

- Test for 0 seconds

```
>> lightning
Type the time in seconds ==> 0
Distance to the lightning strike is: 0.00 miles
```

- Test for 20 seconds

```
>> lightning
Type the time in seconds ==> 20
Distance to the lightning strike is: 4.17 miles
```

The result is expected and the output is a nice 2 decimal digit number. And is probably reasonable because "For every 5 seconds the storm is one mile away"(“Dangerous weather,” n.d.)

<u>***Evaluate the Solution***</u>

What's good about the code:
- Constants are all-caps.
- Use fprintf for pretty printing
- Variables are descriptive.
- Help comments are written.
- Program segments are labeled.

More changes could be made:
- Clean up the workspace after the script completes.

## Activity 4

**Trace Table**

|Line|`year`|`C`|`epact`|`tmp`|
|:---:|:---:|:---:|:---:|:---:|
|9|||||
|11|2020||||
|17|2020|20.2000|||
|18|2020|20|||
|21|2020|20|8|5|
|23|2020|20|13|5|
|28|2020|20|-7|6.92|
|29|2020|20|-7|6|
|32|2020|20|-1|6|
|34|2020|20|65|66|

**coffee.m**

```
%COFFEE computes the cost when you order from a coffee shop
%   COFFEE is a simple calculator to calculate the cost.
%
%   Cost consists of $10.50 per pound + cost of shipping,
%   which is $0.86 per pound plus flat fee $1.50.
%
%   COFFEE asks the user for number of pounds and print
%   the total cost of an order.
%
%   COFFEE overwrites these variables:
%       fee - total cost of the order
%

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   None
% Date:         3 November 2016

% constants
COFFEE_PER_POUND = 10.5;
SHIPPING_PER_POUND = 0.86;
SHIPPING_FEE = 1.50;

% input
pounds = input('Type number of pounds ==> ');

% Processing
fee = (COFFEE_PER_POUND + SHIPPING_PER_POUND) * pounds + SHIPPING_FEE;

% output
fprintf('Hey, your order costs $%.2f! Have a great day!\n',fee);
```


<hr />
Dangerous weather. Retrieved November 3, 2016, from https://eo.ucar.edu/kids/dangerwx/tstorm6.htm
