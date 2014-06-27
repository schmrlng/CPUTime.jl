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

time_difference()
@test 1.0 <= time_difference() <= 1.01