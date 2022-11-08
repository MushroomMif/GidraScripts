# Изменение сообщения о смрети, просто прикольно
death_msg:
    type: world
    debug: false
    events:
        on player dies:
        - determine "<white>ꐳ <red><context.message>"