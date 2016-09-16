### Exercise 1

#Patient    Gender          Treatment 1     Treatment 2     Treatment 3
#---------- --------------- --------------- --------------- ---------------
#  1          Male            Yes             Yes             Yes
#  2          Male            Yes             Yes             No 
#  3          Male            Yes             No              Yes
#  4          Male            Yes             No              No
#  5          Male            No              Yes             Yes
#  6          Male            No              Yes             No
#  7          Male            No              No              Yes
#  8          Male            No              No              No
#  9          Female          Yes             Yes             Yes 
#  10         Female          Yes             Yes             No
#  11         Female          Yes             No              Yes
#  12         Female          Yes             No              No
#  13         Female          No              Yes             Yes
#  14         Female          No              Yes             No
#  15         Female          No              No              Yes
#  16         Female          No              No              No

d = data.frame(
  Patient    = 1:16,
  Gender     = rep(c("Male","Female"),c(8,8)),
  Treatment1 = rep(rep(c("Yes","No"),c(4,4)), 2),
  Treatment2 = rep(rep(c("Yes","No"),c(2,2)), 4),
  Treatment3 = rep(c("Yes","No"),8)
)



### Exercise 2

primes = c(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 
           43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97)

x = c(56, 3, 17, 2, 4, 9, 6, 5, 19, 5, 2, 3, 5, 0, 13, 12, 6, 31, 10, 21, 
      8, 4, 1, 1, 2, 5, 16, 1, 3, 8, 1, 3, 4, 8, 5, 2, 8, 6, 18, 40, 10, 
      20, 1, 27, 2, 11, 14, 5, 7, 0, 3, 0, 7, 0, 8, 10, 10, 12, 8, 82,
      21, 3, 34, 55, 18, 2, 9, 29, 1, 4, 7, 14, 7, 1, 2, 7, 4, 74, 5, 
      0, 3, 13, 2, 8, 1, 6, 13, 7, 1, 10, 5, 2, 4, 4, 14, 15, 4, 17, 1, 9)

# Select every third value starting at position 2 in x. 

x[seq(2, length(x), 3)]

tmp=x[1:length(x)*3-1]
tmp[!is.na(tmp)]

# Remove all values with an odd index (e.g. 1, 3, etc.)

x[ -((1:50)*2-1) ]
x[-seq(1, length(x), 2)]

# Select only the values that are primes. (You may assume all values are less than 100)

x[x %in% primes]

# Remove every 4th value, but only if it is odd.

x[ !( (x %% 2 == 1) & seq_along(x) %in% seq(4,length(x),4) ) ]
x[ !( (x %% 2 == 1) & c(FALSE,FALSE,FALSE,TRUE) ) ]

x[ -intersect(which(x %% 2 == 1), seq(4,length(x),4))]


### Exercise 3

grades = data.frame(
  student = c("Alice","Bob","Carol","Dan","Eve","Frank",
              "Mallory","Oscar","Peggy","Sam","Wendy"),
  grade   = c(82, 78, 62, 98, 64, 53, 86, 73, 54, 57, 61),
  year    = c(3L, 2L, 2L, 1L, 3L, 3L, 4L, 3L, 2L, 2L, 1L),
  stringsAsFactors = FALSE
)


### Add letter grades


# BAD - don't hard code
grades$letter = c("B","C","D","A","D","F","B","C","F","F","D")

# Lookup table - Letter grade

letter_table = c(rep("F",60), rep("D",10), rep("C",10), 
                 rep("B",10), rep("A",11))
(grades$letter = letter_table[ as.integer(grades$grade)+1  ])

letter_table_short = c(rep("F",6), "D", "C", "B", "A", "A") 
(grades$letter = letter_table_short[ as.integer(grades$grade/10) + 1])


# Lookup table - Pass fail

passing_table = c(A=TRUE, B=TRUE, C=TRUE, D=FALSE, F=FALSE)
(grades$passing = passing_table[ grades$letter ])

(grades$passing = grades$letter %in% c("A","B","C"))

(grades$passing = grades$grade >= 70)
