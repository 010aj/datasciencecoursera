## The following functions compute the inverse of a matrix, and cache it for repeated uses.

## This function(makeCacheMatrix) creates list containing functions to set the value of the matrix,
## get the value of the matrix, set the value of the inverse, and get the value of inverse matrix.

makeCacheMatrix <- function(x = matrix()) {
	inv <- NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setinv <- function(inverse) inv <<- inverse
        getinv <- function() inv
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}


## The following function calculates the inverse of the matrix created with the above function. 
## If the inverse already exists, then it gets the inverse from the cache.
## Otherwise, it calculates the inverse of the matrix and sets the value of the inverse in the cache 
## via the setinv function.

cacheSolve <- function(x, ...) {
        inv <- x$getinv()
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        data <- inv$get()
        inv <- solve(data, ...)
        x$setinv(inv)
        inv
}
