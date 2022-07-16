destroyCamera = function(cam)
    DestroyCam(cam, true)
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 1000, 1, 0)
end
