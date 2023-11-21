obs = obslua
local icon = "put base64 data here"
local description = "This is a description that can also contain html using [[<all html elements>]] if need be"
properties = {}
--------SCRIPT------
function script_properties()
    properties = obs.obs_properties_create()
    local runButton = createButton("Run", button_clicked)
    local stopButton = createButton("Stop", stop_clicked)
    return properties
end

function script_description()
    return description
end

--------TIMER--------
function startTimer(seconds)
    obs.timer_add(timerCallback, 5000)
end

function stopTimer()
    obs.timer_remove(getTimer)
end

function timerCallback()
    --obs.obs_data_get_string
end

--------BUTTONS--------
function button_clicked()
    -- source = getSourceByName("Television")
    -- local file = getFileFromMediaSource(source)
    -- log(file)
    local source = getSourceByName("Television")
    local settings = obs.obs_source_get_settings(source);
    obs.obs_data_set_string(settings, "local_file", "D:/YouTube/60 Second Gaming/Final Fantasy Told In/FF7.mp4")
    obs.obs_source_update(source, settings)
    obs.obs_data_release(settings)
    obs.obs_source_release(source)
    log(string.format("Source Found: %s", source))
end

function stop_clicked()
    obs.stopTimer(getTimer)
end

--------OBS HELPERS---------
function createButton(label, click_function)
    local buttonName = string.format("%s_button", label)
    return obs.obs_properties_add_button(properties, buttonName, label, click_function)
end

function getFileFromMediaSource(source)
    local settings = obs.obs_source_get_settings(source);
    local fileString = obs.obs_data_get_string(settings, "local_file")
    obs.obs_data_release(settings)
    return fileString
end

function getSourceByName(sourceName)
    local source = obs.obs_get_source_by_name(sourceName)
    return source
end

function log(message)
    obs.script_log(obs.LOG_INFO, message)
end