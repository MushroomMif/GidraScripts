flag_block:
    type: world
    debug: false
    events:
        after player right clicks block with:paper:
        - define material <player.cursor_on.material>
        - if <list[note_block|tripwire]> contains <[material].name>:
            - foreach <yaml[blocks].read[blocks]>:
                - if ( <[value].get[type]> == <[material].name> ) && ( <[value].get[instrument]> == <[material].instrument> ) && ( <[value].get[note]> == <[material].note> ) && ( <[value].get[powered]> == <[material].switched> ):
                    - flag <player.cursor_on> oraxen_type:<[key]>
        on player breaks note_block|tripwire:
        - if <context.location.has_flag[oraxen_type]>:
            - flag <context.location> oraxen_type:!
        on scripts loaded:
        - ~yaml load:config/blocks.yml id:blocks