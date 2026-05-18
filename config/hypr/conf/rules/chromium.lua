-- Browser types
hl.window_rule({ match = { class = "((google-)?[cC]hrom(e|ium)|[bB]rave-browser|helium)" }, tag = "+chromium-browser" })
hl.window_rule({ match = { class = "([fF]irefox|zen|librewolf)" },                          tag = "+firefox-browser" })

-- Force chromium browsers into a tile to deal with --app bug
hl.window_rule({ match = { tag = "chromium-browser" }, tile = true })
