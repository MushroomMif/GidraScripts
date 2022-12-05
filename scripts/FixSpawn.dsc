decrease_spawn:
    type: world
    debug: false
    events:
        on strider spawns because NATURAL chance:95:
        - determine cancelled
        on pig spawns:
        - determine cancelled
        on chunk loads for the first time:
        - remove <context.chunk.entities[pig]>