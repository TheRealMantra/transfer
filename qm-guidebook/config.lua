Config = {}

-- Basic Settings
Config.Command = 'guidebook'
Config.Keybind = 'F1'

-- Menu Settings
Config.MenuSettings = {
    MaxRecentGuides = 5,
    ShowIcons = true,
    EnableSearch = true,
    MenuPosition = 'right', -- 'left' or 'right'
    MenuWidth = 'wide', -- 'narrow', 'wide', or 'full'
    TextSize = 'large', -- 'small', 'medium', 'large'
}

-- Guide Categories
Config.Categories = {
    ['general'] = {
        enabled = true,
        icon = 'fas fa-book',
        label = 'General Information',
        subcategories = {
            ['rules'] = {
                label = 'Server Rules',
                content = {
                    {
                        title = 'General Rules',
                        text = [[

1. Be respectful to all players

2. No harassment or discrimination

3. Follow roleplay guidelines

4. No metagaming or powergaming

5. Keep OOC chat in designated channels

6. Respect players for their RP and choices.

7. Bases are not buildable in safe zones, or in the way of the main path.

8. Bases are not buildable in the water.

9. Bases are not buildable in the sky.

10. Bases are destroyed after 30 days of inactivity, to keep the world clean and to prevent griefing.

                        ]]
                    },
                    {
                        title = 'Combat Rules',
                        text = [[

1. No random killing (RDM) - You must have a valid reason to engage in PvP combat.

2. Valid reasons for combat include:
   • Defending your base or territory
   • Protecting your resources or supplies
   • Responding to threats or aggression
   • Raiding enemy bases (with proper RP setup)
   • Defending against raiders

3. Make sure you have a reason to be in combat, if you do not have a reason to be in combat DO NOT GO INTO COMBAT.

4. No combat logging - If you're in combat, you must stay and fight or properly escape.

5. Remember to have fun and not take things too seriously.

6. Remember it is a PvP server, so you will need to be careful and watch your back. AT ALL TIMES.

7. Safe Zones:
   • No PvP in designated safe zones
   • No base building in safe zones
   • No raiding near safe zones
   • Safe zones are marked on your map

8. Base Raiding Rules:
   • Must have proper RP setup before raiding
   • No raiding the same base within 24 hours
   • No exploiting or glitching into bases

9. Zombie Combat:
   • Zombies are always hostile
   • No teaming with zombies against players
   • No using zombies to grief other players

10. Combat Logging:
    • If you log out during combat, your character stays in-game for 30 seconds
    • If killed during this time, you lose your items
    • This prevents combat logging abuse

                        ]]
                    }
                }
            },
            ['commands'] = {
                label = 'Basic Commands',
                content = {
                    {
                        title = 'Essential Commands',
                        text = [[

/me - Roleplay action
/do - Describe situation
/twitter - Send tweet
/911 - Emergency services
/311 - Non-emergency services

                        ]]
                    }
                }
            }
        }
    },
    ['crews'] = {
        enabled = true,
        icon = 'fas fa-users',
        label = 'Crews & Factions',
        subcategories = {
            ['creation'] = {
                label = 'Crew Creation',
                content = {
                    {
                        title = 'Starting a Crew',
                        text = [[

1. To create a crew, you will need to use the command /crew and create a crew.

2. Crews are a way to group together with friends and other players to help each other out, and to have a group to do missions and raids with.

3. Each crew needs a unique name and tag (3-4 characters), and no more than 10 memebers.

4. Crew leaders can  manage there crew memebers and give them ranks and permissions.

5. Crews can have up to 3 bases, and up to  5 vehicles, as they are able to be shared amongst  crew leaders.

                        ]]
                    },
                    {
                        title = 'Crew Management',
                        text = [[

1. Crew leaders can invite, kick, and promote members.

2. Crew funds can be used for upgrades and shared resources.

3. Crew bases can be built and managed by all members based on permissions.

4. Bases are accessable by all crew memebers.

5. Crew members can share resources and items.

                        ]]
                    }
                }
            },
            ['activities'] = {
                label = 'Crew Activities',
                content = {
                    {
                        title = 'Crew Missions',
                        text = [[

1. TBA

                        ]]
                    },
                    {
                        title = 'Crew Benefits',
                        text = [[

1. TBA

                        ]]
                    }
                }
            }
        }
    },
    ['jobs'] = {
        enabled = true,
        icon = 'fas fa-briefcase',
        label = 'Jobs & Careers',
        subcategories = {
            ['police'] = {
                label = 'Police Department',
                content = {
                    {
                        title = 'Requirements',
                        text = [[

1. TBA

                        ]]
                    },
                    {
                        title = 'Duties',
                        text = [[

1. TBA

                        ]]
                    }
                }
            },
            ['ems'] = {
                label = 'Emergency Services',
                content = {
                    {
                        title = 'Checking In',
                        text = [[

1. TBA

                        ]]
                    },
                    {
                        title = 'Duties',
                        text = [[

1. TBA

                        ]]
                    }
                }
            }
        }
    },
    ['mechanics'] = {
        enabled = true,
        icon = 'fas fa-cogs',
        label = 'Game Mechanics',
        subcategories = {
            ['vehicles'] = {
                label = 'Vehicle System',
                content = {
                    {
                        title = 'Vehicle Crafting',
                        text = [[

1. You can craft vehicles you find in the world or buy them from the dealer.

2. Parts for cars can be found in dumpsters, trashbags, or destroyed cars on the road.

3. Parts will be able to purchased by shops in the near future. So keep an eye out for that.

                        ]]
                    },
                    {
                        title = 'Vehicle Maintenance',
                        text = [[

1. For fixing vehicles you can find  repair kits around Dead Nation and use them or you can go to the mechanic at bennys.

2. For fuel you can go to gas stations or you can use the fuel cans that you find  around the world, so vehicles  use gas or diesel.

3. Insurance system, IS NOT AVAILABLE YET.

4. Performance upgrades can you bought at  the mechanic place at bennys for a proce, so come with money.

5. Vehicle storage , there is garages all over the worl where youc an store your vehicles, vehicles are persistant and do not despawn during retsrats.

                        ]]
                    }
                }
            },
            ['housing'] = {
                label = 'Base Building',
                content = {
                    {
                        title = 'How To Start A Base',
                        text = [[

1. As you know this sia  zombie apocalypse so you will need to find a safe place to stay.

2. The world is is PvP so you will need to find a place that is safe from other players.

3. You can  gather wood from tree and nails from trashcans and other places to build your base.

4. In Safe Zone Alpha there is work benches that you will need to use to build your base items.

5. You can not build  your bases on roads, in safe zones, or in the way of the main path.

6. In the future you will be able to buy parts to build your base, so keep an eye out for that.

7. In the beginning you will  need to get your level high enough to craft certain things.

                        ]]
                    },
                    {
                        title = 'Base Management',
                        text = [[

1. In order fror your base to not deteoriate you will need to repair it, you will need to  make a big storage.

2. You can make storage containers to store your items that you collect  via the world.

3. For now not much decoration items are available, but there will be more in the future.

4. Base defenses are available to protect your base from zombies and players, which are at a levbel requirement.

5. You can also make beds to sleep in and rest, in the future you will be able to spawn at bases that you create.

                        ]]
                    }
                }
            }
        }
    }
} 