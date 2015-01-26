# looping and skipping
for i in {1..99}; do
  [[ $[$i%2] != 0 ]] && echo $i
done

# a personalized echo
read name
echo Welcome ${name}

# looping with numbers
for i in {1..50}; do
  echo $i
done

# the world of numbers
read X
read Y

echo $(($X+$Y))
echo $(($X-$Y))
echo $(($X*$Y))
echo $(($X/$Y))

# comparing numbers
read X
read Y

[[ $X < $Y ]] && echo "X is less than Y" && exit 0
[[ $X > $Y ]] && echo "X is greater than Y" && exit 0
echo "X is equal to Y"

# getting started with conditionals
read X
X=$(echo $X | tr "[:upper:]" "[:lower:]")
[[ "$X" == "y" ]] && echo YES || echo NO

# more on conditionals
read X
read Y
read Z

[[ $X == $Y && $Y == $Z ]] && echo EQUILATERAL && exit 0
[[ $X == $Y || $X == $Z || $Y == $Z ]] && echo ISOSCELES && exit 0
echo SCALENE

# arithmetic operations
read EXP
printf "%.3f" $(echo "$EXP" | bc -l)

# compute the average
read N
SUM=0
while read V || [ -n "$V" ]; do
  SUM=$(($SUM+$V))
done
printf "%.3f" $(echo "$SUM/$N" | bc -l)

# the cut command #1
while read V || [ -n "$V" ]; do
  echo $V | cut -c 3
done

# the cut command #2
while read V || [ -n "$V" ]; do
  echo $V | cut -c2,7
done

# the cut command #3
while read V || [ -n "$V" ]; do
  echo $V | cut -c2-7
done

# the cut command #4
while read V || [ -n "$V" ]; do
  echo $V | cut -c1-4
done

# the cut command #5
while read line || [ -n "$line" ]; do
  echo "$line" | cut -f 1-3
done

# the cut command #6
while read line || [ -n "$line" ]; do
  echo "$line" | cut -c13-
done

# the cut command #7
while read line || [-n "$line" ]; do
  echo "$line" | cut -d' ' -f4
done

# the cut command $8
while read line || [-n "$line" ]; do
  echo "$line" | cut -d' ' -f-3
done

# the cut command #9
while read line || [-n "$line" ]; do
  echo "$line" | cut -f2-
done

# the head #1
head -n 20

# the head #2
head -c 20

# the middle of a text file
head -n22 | tail -n11

# the tail #1
tail -n20

# the tail #2
tail -c20

# the tr command #1
tr "(" "[" | tr ")" "]"

# the tr command #2
tr -d [a-z]

# the tr command #3
tr -s " " " "
