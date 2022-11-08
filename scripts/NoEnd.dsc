no_end:
    type: world
    debug: true
    events:
        on player changes world:
        - if <context.destination_world.name> == world_the_end:
            - narrate "<red>Пока рано"
            - kill <player>