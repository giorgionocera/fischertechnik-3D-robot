function sysCall_threadmain()
    targetHandle = sim.getObjectHandle('Target')
    pathHandle = sim.getObjectHandle('PathPickRelease')
    sim.followPath(targetHandle, pathHandle, 1, 0, 0.01, 0)
end

function sysCall_cleanup()
end