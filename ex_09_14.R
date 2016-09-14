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

### Exercise 3