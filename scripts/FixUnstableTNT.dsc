unstable_tnt:
    type: world
    debug: false
    events:
        on player breaks tnt:
        - spawn primed_tnt <context.location> if:<context.material.unstable>