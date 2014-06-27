# CPUTime.jl

[![Build Status](https://travis-ci.org/schmrlng/CPUTime.jl.svg?branch=master)](https://travis-ci.org/schmrlng/CPUTime.jl)

A Julia package for measuring elapsed CPU time in Julia.

## Functions and Macros

The exported functions and macros, as well as their absolute time equivalents, are listed in the following table.

| Real time (Julia standard library) | CPU time (CPUTime.jl) |
| ---------------------------------- | --------------------- |
| time_ns()                          | CPUtime_us()          |
| tic()                              | CPUtic()              |
| toq()                              | CPUtoq()              |
| toc()                              | CPUtoc()              |
| @time                              | @CPUtime              |
| @elapsed                           | @CPUelapsed           |

Note that the finest resolution for CPU time is microseconds, as opposed to nanoseconds for absolute time.

## Usage Example

````julia
using CPUTime

function add_and_sleep()
    x = 0
    for i in 1:1e7
        x += i
    end
    sleep(1)
end

@time @CPUtime add_and_sleep()
````
````
elapsed CPU time: 0.578552 seconds
elapsed time: 1.580263121 seconds (320166488 bytes allocated, 11.91% gc time)
````
