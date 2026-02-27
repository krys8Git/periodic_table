#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
echo "Please provide an element as an argument."

# helper function to get attributes of element
GET_ATTRIBUTES() {
  # query for info based on atomic number
  ATTRIBUTES=$($PSQL "select e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius from elements as e left join properties as p using (atomic_number) left join types as t using (type_id) where e.atomic_number=$1")
  echo "$ATTRIBUTES" | while IFS='|' read AN NAME SYMBOL TYPE AM MP BP
  do
    echo "$BP"
  done
}

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
  GET_ATTRIBUTES $ATOM1
elif [[ -n $ATOM2 ]]
then
  GET_ATTRIBUTES $ATOM2
elif [[ -n $ATOM3 ]]
then
  GET_ATTRIBUTES $ATOM3
else
  echo "I could not find that element in the database."
fi

