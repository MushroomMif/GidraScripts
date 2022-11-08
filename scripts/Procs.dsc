colored_tps:
    type: procedure
    debug: false
    script:
    - define tps <server.recent_tps.first.round_to[2]>
    - if <[tps]> > 20:
        - define tps 20
    - if <[tps]> >= 19.9:
        - determine <green><[tps]>
    - else if <[tps]> >= 17:
        - determine <yellow><[tps]>
    - else:
        - determine <red><[tps]>

colored_mspt:
    type: procedure
    debug: false
    script:
    - define mspt <paper.tick_times.first.in_milliseconds.round_to[1]>
    - if <[mspt]> <= 35:
        - determine <green><[mspt]>
    - else if <[mspt]> <= 50:
        - determine <yellow><[mspt]>
    - else:
        - determine <red><[mspt]>

colored_ping:
    type: procedure
    debug: false
    script:
    - define ping <player.ping>
    - if <[ping]> <= 100:
        - determine <green><[ping]>
    - else if <[ping]> <= 500:
        - determine <yellow><[ping]>
    - else:
        - determine <red><[ping]>

parse_tab_element:
    type: procedure
    debug: false
    definitions: value
    script:
    - define list <yaml[tab].read[<[value]>]>
    - define text ꐖꐡ
    - foreach <[list]> as:value:
        - if <[value].contains_text[%end%]>:
            - define text <[text]><[value].replace_text[%end%].parsed.parse_color>
        - else:
            - define text <[text]><[value].parsed.parse_color><n>
    - determine <[text]>

is_oraxen_item:
    type: procedure
    debug: false
    definitions: item|id
    script:
    - define raw_nbt <[item].raw_nbt>
    - if <[raw_nbt].contains[PublicBukkitValues]> && <[raw_nbt].get[PublicBukkitValues].contains[oraxen:id]> && ( <[raw_nbt].get[PublicBukkitValues].get[oraxen:id]> == string:<[id]> ):
        - determine true
    - else:
        - determine false