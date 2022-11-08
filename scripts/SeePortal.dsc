seeportal:
    type: command
    name: seeportal
    usage: /seeportal
    description: Включить или выключить возможность видеть через порталы
    debug: false
    script:
    # Если игрок может видеть через поратлы
    - if <player.has_permission[betterportals.see]>:
        - execute as_server "lp user <player.name> permission set betterportals.see false"
        - narrate "<&r>Теперь вы <red>не можете <&r>видеть сквозь порталы"
    # Если не может
    - else:
        - execute as_server "lp user <player.name> permission set betterportals.see true"
        - narrate "<&r>Теперь вы <green>можете <&r>видеть сквозь порталы"