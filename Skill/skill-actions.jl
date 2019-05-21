#
# actions called by the main callback()
# provide one function for each intent, defined in the Snips Console.
#
# ... and link the function with the intent name as shown in config.jl
#
# The functions will be called by the main callback function with
# 2 arguments:
# * MQTT-Topic as String
# * MQTT-Payload (The JSON part) as a nested dictionary, with all keys
#   as Symbols (Julia-style)
#

"""
function googleCalendar(topic, payload)

"""
function googleCalendar(topic, payload)

    # log:
    #
    println("[ADoSnipsGCalendar]: action googleCalendar() started.")

    mode = Snips.extractSlotValue(payload, SLOT_MODE)
    if mode == nothing
        mode = "next4"
    end

    if mode == "today"
        when = "Heute"
    elseif mode == "tomorrow"
        when = "Morgen"
    else
        when = "In nächster Zeit"
    end

    if getGoogleCalendar(mode)
        raw = Snips.tryParseJSONfile(CALENDAR_JSON)

        if raw[:num_events] < 1
            Snips.publishEndSession("$when gibt es keine Termine!")
        else
            events = raw[:events]
            if raw[:num_events] == 1
                Snips.publishSay("$when gibt es einen Termin:", lang = LANG)
            else
                Snips.publishSay("$when gibt es $(raw[:num_events]) Termine:",
                                 lang = LANG)
            end
            sayEvents(events)
            Snips.publishEndSession("")
        end
    else
        Snips.publishEndSession("Es gab ein Problem beim Abrufen der Termine!")
    end
    return false
end





function sayEvents(events)

    for e in events
        start = Snips.readableDateTime(e[:time])
        Snips.publishSay(start)
        Snips.publishSay(e[:description])
    end
end
