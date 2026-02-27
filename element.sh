#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
echo "Please provide an element as an argument."

if [[ -z $(echo "$1" | grep ^[0-9]+$) ]]
then
  ATOM1=$($PSQL "select atomic_number from elements where symbol='$1'")
  ATOM2=$($PSQL "select atomic_number from elements where name='$1'")
else
  ATOM3=$($PSQL "select atomic_number from elements where atomic_number=$1")
fi

# assign atomic number to atomic variable
if [[ -n $ATOM1 ]]
then
  ATOMIC=$ATOM1
elif [[ -n $ATOM2 ]]
then
  ATOMIC=$ATOM2
elif [[ -n $ATOM3 ]]
then
  ATOMIC=$ATOM3
else
  echo "I could not find that element in the database"
fi

# query for info based on atomic number
echo $($PSQL "select e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius from elements as e left join properties as p using (atomic_number) left join types as t using (type_id) where e.atomic_number=$ATOMIC")

