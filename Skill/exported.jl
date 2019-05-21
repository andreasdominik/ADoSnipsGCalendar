# exported functions:
#

# deliver actions and intents to the Main context:
#
function getIntentActions()
    return Snips.getIntentActions()
end




# This function is executed to run a
# skill action in the module.
#
function callbackRun(fun, topic, payload)

    println("running callbackRun() for $topic and fun $fun")
    Snips.setSiteId(payload[:siteId])
    Snips.setSessionId(payload[:sessionId])
    Snips.setTopic(topic)
    result = fun(topic, payload)

    # fix, if the action does not return true or false:
    #
    if !(result isa Bool)
        result = false
    end

    if CONTINUE_WO_HOTWORD && result
        Snips.publishStartSessionAction("")
    end
end
