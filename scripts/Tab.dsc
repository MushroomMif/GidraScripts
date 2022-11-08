update_tab:
    type: world
    debug: false
    events:
        on player join:
        - while <player.is_online>:
            - adjust <player> tab_list_info:<proc[parse_tab_element].context[header]>|<proc[parse_tab_element].context[footer]>
            - wait <yaml[tab].read[cooldown].if_null[5s]>
        on scripts loaded:
        - yaml load:/config/tab.yml id:tab
