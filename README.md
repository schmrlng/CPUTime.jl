# CPUTime.jl

[![Build Status](https://travis-ci.org/schmrlng/CPUTime.jl.svg?branch=master)](https://travis-ci.org/schmrlng/CPUTime.jl)

A Julia package for measuring elapsed CPU time in Julia.

## Installation

You should only use this package if you know what you're doing - CPU time on multi-core processors is a tricky beast. Please at least read the discussion in [Issue #1](https://github.com/schmrlng/CPUTime.jl/issues/1) before proceeding. Once you've done that, to install call:
```
Pkg.add("CPUTime")
```
from the Julia command line.

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
    for i in 1:10_000_000
        x += i
    end
    sleep(1)
    x
end

@time @CPUtime add_and_sleep()
````
````
elapsed CPU time: 0.000174 seconds
  1.005624 seconds (32 allocations: 1.109 KiB)
50000005000000
````
