## Exercise 1

### Part 1

typeof(c(1, NA+1L, "C"))  # => type Character

typeof(c(1L / 0, NA))     # => type Double

typeof(c(1:3, 5))         # => type Double

typeof(c(3L, NaN+1L))     # => type Double

typeof(c(NA, TRUE))       # => type Logical


### Part 2

##### Character -> Double -> Integer -> Logical



## Exercise 2

json = '{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25,
  "address": 
  {
    "streetAddress": "21 2nd Street",
    "city": "New York",
    "state": "NY",
    "postalCode": 10021
  },
  "phoneNumber": 
    [
      {
        "type": "home",
        "number": "212 555-1239"
      },
      {
        "type": "fax",
        "number": "646 555-4567"
      }
    ]
}'

library(jsonlite)
dput(fromJSON(json, simplifyVector = FALSE))


list(
  "firstName" = "John",
  "lastName" = "Smith",
  "age" = 25,
  "address" = 
    list(
      "streetAddress" = "21 2nd Street",
      "city" = "New York",
      "state" = "NY",
      "postalCode" = 10021
    ),
  "phoneNumber" = 
    list(
      list(
        "type" = "home",
        "number" = "212 555-1239"
      ),
      list(
        "type" = "fax",
        "number" = "646 555-4567"
      )
    )
)


## Exercise 3

#            1        2        3      4
levels = c("sun", "clouds", "rain", "snow")

x = c(2L, 2L, 1L, 1L, 2L, 3L, 3L)
attr(x, "levels") = levels
attr(x, "class") = "factor"


factor(c("clouds","clouds","sun","sun","clouds","rain","rain"),levels = levels)




