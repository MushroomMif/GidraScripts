make_invisible:
    type: world
    debug: false
    events:
        after potion splash:
        - define is_invisible false
        - define is_water false
        - foreach <context.potion.effects_data> as:effect:
            - if <[effect].get[type]> == INVISIBILITY:
                - define is_invisible true
            - else if <[effect].get[type]> == WATER:
                - define is_water true
        - if !<[is_invisible]> && !<[is_water]>:
            - stop
        - define entities <context.location.find_entities.within[3]>
        - foreach <[entities]> as:entity:
            - if <[entity].entity_type> == armor_stand:
                - if <[is_invisible]>:
                    - adjust <[entity]> base_plate:false
                - else:
                    - adjust <[entity]> base_plate:true
            - else if ( <[entity].entity_type> == item_frame ) || ( <[entity].entity_type> == glow_item_frame ):
                - if <[is_invisible]>:
                    - adjust <[entity]> visible:false
                - else:
                    - adjust <[entity]> visible:true