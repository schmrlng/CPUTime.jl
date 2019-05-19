using CPUTime
using Test

function add_and_sleep()
    x = 0
    for i in 1:10_000_000
        x += i
    end
    sleep(1)
end

function time_difference()
    dt = @elapsed begin
        CPUdt = @CPUelapsed add_and_sleep()
    end
    return dt - CPUdt
end

time_difference()  # compilation overhead should not affect results, but just in case
time_diff = time_difference()
eval(Meta.parse("@test abs($time_diff - 1.0) <= .1"))
