# Когда крипер взрывается ставим пустой список взорванных блоков
no_explode:
    type: world
    debug: false
    events:
        on creeper explodes:
        - determine <list>