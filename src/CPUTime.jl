module CPUTime

export
    CPUtime_us,
    CPUtic,
    CPUtoq,
    CPUtoc,
    @CPUtime,
    @CPUelapsed

function CPUtime_us()
    rusage = Libc.malloc(4*sizeof(Clong) + 14*sizeof(UInt64))  # sizeof(uv_rusage_t); this is different from sizeof(rusage)
    ccall(:uv_getrusage, Cint, (Ptr{Nothing},), rusage)
    utime = UInt64(1000000)*unsafe_load(convert(Ptr{Clong}, rusage + 0*sizeof(Clong))) +    # user CPU time
                            unsafe_load(convert(Ptr{Clong}, rusage + 1*sizeof(Clong)))
    stime = UInt64(1000000)*unsafe_load(convert(Ptr{Clong}, rusage + 2*sizeof(Clong))) +    # system CPU time
                            unsafe_load(convert(Ptr{Clong}, rusage + 3*sizeof(Clong)))
    ttime = utime + stime  # total CPU time
    Libc.free(rusage)
    return ttime
end

function CPUtic()
    t0 = CPUtime_us()
    task_local_storage(:CPUTIMERS, (t0, get(task_local_storage(), :CPUTIMERS, ())))
    return t0
end

function CPUtoq()
    t1 = CPUtime_us()
    timers = get(task_local_storage(), :CPUTIMERS, ())
    if timers === ()
        error("CPUtoc() without CPUtic()")
    end
    t0 = timers[1]::UInt64
    task_local_storage(:CPUTIMERS, timers[2])
    (t1-t0)/1e6
end

function CPUtoc()
    t = CPUtoq()
    println("elapsed CPU time: ", t, " seconds")
    return t
end

# print elapsed CPU time, return expression value
macro CPUtime(ex)
    quote
        local t0 = CPUtime_us()
        local val = $(esc(ex))
        local t1 = CPUtime_us()
        println("elapsed CPU time: ", (t1-t0)/1e6, " seconds")
        val
    end
end

# print nothing, return elapsed CPU time
macro CPUelapsed(ex)
    quote
        local t0 = CPUtime_us()
        local val = $(esc(ex))
        (CPUtime_us()-t0)/1e6
    end
end

end # module
