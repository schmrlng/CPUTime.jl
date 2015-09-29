using CPUTime
using Base.Test

function add_and_sleep()
    x = 0
    for i in 1:1e7
        x += i
    end
    sleep(1)
end

function time_difference()
    tic()
    CPUtic()
    add_and_sleep()
    return toq() - CPUtoq()
end

time_difference()  # compilation overhead should not affect results, but just in case
time_diff = time_difference()
eval(parse("@test abs($time_diff - 1.0) <= .01"))